import 'dart:developer' as developer;
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../repositories/bible_repository.dart';

part 'reader_store.g.dart';

class ReaderStore = _ReaderStore with Store;

abstract class _ReaderStore with Store {
  final BibleRepository repo;

  _ReaderStore(this.repo);

  @observable
  String? traducaoId;

  @observable
  String? livroId;

  @observable
  int? capitulo;

  @observable
  ObservableFuture<List>? versesFuture;

  @observable
  List books = const [];

  @observable
  List<int> chapters = const [];

  @computed
  bool get hasSelection =>
      traducaoId != null && livroId != null && capitulo != null;

  @action
  void setTranslation(String id) {
    developer.log('setTranslation -> $id', name: '##reader');
    traducaoId = id;
  }

  @action
  Future<void> setSelection(String livro, int chapter) async {
    livroId = livro;
    capitulo = chapter;
    await _persistLastRead();
    await _load();
  }

  @action
  Future<void> ensureInitialSelectionForTranslation() async {
    if (traducaoId == null) return;
    developer.log('ensureInitialSelectionForTranslation',
        name: '##reader ${traducaoId}');
    // Tenta restaurar último lido
    final restored = await _restoreLastRead();
    developer.log('restoreLastRead=${restored}',
        name: '##reader ${traducaoId}');
    if (restored && hasSelection) {
      developer.log('restored selection livro=${livroId} cap=${capitulo}',
          name: '##reader ${traducaoId}');
      await _load();
      return;
    }
    // Caso contrário, usa o primeiro capítulo disponível
    final initial = await repo.firstAvailableChapter(traducaoId!);
    developer.log('firstAvailableChapter=${initial?.$1}:${initial?.$2}',
        name: '##reader ${traducaoId}');
    if (initial != null) {
      await setSelection(initial.$1, initial.$2);
    }
  }

  @action
  Future<void> _load() async {
    if (!hasSelection) return;
    developer.log('_load start livro=${livroId} cap=${capitulo}',
        name: '##reader ${traducaoId}');
    versesFuture = ObservableFuture(
      repo.getChapterVerses(traducaoId!, livroId!, capitulo!),
    );
    await versesFuture;
    final list = versesFuture?.value;
    developer.log('_load done verses=${list?.length ?? 0}',
        name: '##reader ${traducaoId}');
  }

  @action
  Future<void> loadBooksForTranslation() async {
    if (traducaoId == null) return;
    developer.log('loadBooksForTranslation', name: '##reader ${traducaoId}');
    books = await repo.listBooksForTranslation(traducaoId!);
    developer.log('books.count=${books.length}',
        name: '##reader ${traducaoId}');
  }

  @action
  Future<void> loadChaptersForBook(String livro) async {
    if (traducaoId == null) return;
    developer.log('loadChaptersForBook livro=$livro',
        name: '##reader ${traducaoId}');
    chapters = await repo.listAvailableChapters(traducaoId!, livro);
    developer.log('chapters.count=${chapters.length}',
        name: '##reader ${traducaoId}');
  }

  Future<void> _persistLastRead() async {
    if (!hasSelection) return;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('last.traducaoId', traducaoId!);
      await prefs.setString('last.livroId', livroId!);
      await prefs.setInt('last.capitulo', capitulo!);
    } catch (_) {
      // Ignora falhas de plataforma; leitura continua sem persistência
    }
  }

  Future<bool> _restoreLastRead() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final t = prefs.getString('last.traducaoId');
      final l = prefs.getString('last.livroId');
      final c = prefs.getInt('last.capitulo');
      if (t != null && l != null && c != null && t == traducaoId) {
        livroId = l;
        capitulo = c;
        return true;
      }
      return false;
    } catch (_) {
      return false;
    }
  }
}
