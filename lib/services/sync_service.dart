import 'dart:async';

import '../api/api_bible_client.dart';
import '../api/dtos.dart';
import '../repositories/bible_repository.dart';
import '../stores/sync_store.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/config.dart';
import 'package:flutter/foundation.dart';

class SyncService {
  final ApiBibleClient api;
  final BibleRepository repo;
  final SyncStore store;

  SyncService({required this.api, required this.repo, required this.store});

  Future<void> installTranslation(BibleDto bible, {int maxRetries = 2}) async {
    try {
      final start = DateTime.now();
      debugPrint('[SYNC] Iniciando sync para ${bible.id}');

      // Sinaliza início de sync imediatamente (total desconhecido ainda)
      store.start(bible.id, 0);

      // Busca livros com reintento básico
      List<BookDto> books = [];
      int attemptBooks = 0;
      while (true) {
        try {
          books = await api.listBooks(bible.id);
          break;
        } catch (e) {
          attemptBooks++;
          if (attemptBooks > maxRetries) {
            store.setError('Sem rede ou API indisponível: $e');
            rethrow;
          }
          await Future.delayed(const Duration(seconds: 1));
        }
      }

      await repo.upsertTraducao(bible);
      await repo.upsertLivros(books);

      final chaptersPerBook = <BookDto, List<ChapterDto>>{};
      int total = 0;
      final iterBooks = subsetOneBook && books.isNotEmpty ? [books.first] : books;
      for (final book in iterBooks) {
        // Busca capítulos com reintento básico
        List<ChapterDto> chapters = [];
        int attemptChaps = 0;
        while (true) {
          try {
            chapters = await api.listChapters(bible.id, book.id);
            break;
          } catch (e) {
            attemptChaps++;
            if (attemptChaps > maxRetries) {
              store.setError('Falha ao listar capítulos de ${book.name}: $e');
              rethrow;
            }
            await Future.delayed(const Duration(seconds: 1));
          }
        }
        chaptersPerBook[book] = chapters;
        total += chapters.length;
      }

      // Atualiza total agora que sabemos quantos capítulos iremos baixar
      store.setTotal(total);

      for (final entry in chaptersPerBook.entries) {
        final book = entry.key;
        final chapters = entry.value;

        for (final chapter in chapters) {
          // pause handling
          while (store.paused) {
            await Future.delayed(const Duration(milliseconds: 200));
          }

          int attempt = 0;
          while (true) {
            try {
              final verses = await api.listChapterVerses(bible.id, chapter.id);
              await repo.insertVersos(bible.id, book.id, chapter.number, verses);
              store.incrementCompleted();
              debugPrint('[SYNC] Baixado ${book.name} ${chapter.number} (${store.completedChapters}/${store.totalChapters})');
              break;
            } catch (e) {
              attempt++;
              if (attempt > maxRetries) {
                store.setError('Falha ao baixar ${book.name} ${chapter.number}: $e');
                rethrow;
              }
              await Future.delayed(const Duration(seconds: 1));
            }
          }
        }
      }

      store.setCompleted();
      final durationMs = DateTime.now().difference(start).inMilliseconds;
      debugPrint('[SYNC] Concluído ${bible.id} em ${durationMs}ms (${store.completedChapters} capítulos)');
      // Persiste estatísticas básicas da última sincronização (best-effort)
      try {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('sync.last.bibleId', bible.id);
        await prefs.setInt('sync.last.total', store.totalChapters);
        await prefs.setInt('sync.last.completed', store.completedChapters);
        await prefs.setInt('sync.last.ms', durationMs);
        await prefs.setString('sync.last.timestamp', DateTime.now().toIso8601String());
      } catch (_) {
        // Ignora falhas de plataforma
      }
    } catch (e) {
      store.setError('Erro na sincronização: $e');
    }
  }

  void pause() => store.setPaused(true);
  void resume() => store.setPaused(false);

  Future<void> removeTranslation(String bibleId) async {
    await repo.removeTranslation(bibleId);
    if (store.currentBibleId == bibleId) {
      store.reset();
    }
  }
}