import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../api/api_bible_client.dart';
import '../api/dtos.dart';
import '../repositories/bible_repository.dart';
import '../stores/sync_store.dart';
import '../services/sync_service.dart';
import '../data/app_database.dart';
import 'reader_screen.dart';
import '../stores/reader_store.dart';
import 'online_reader_screen.dart';

class ManageTranslationsScreen extends StatefulWidget {
  final ApiBibleClient api;
  final BibleRepository repo;
  final SyncStore store;
  final SyncService service;

  const ManageTranslationsScreen({
    super.key,
    required this.api,
    required this.repo,
    required this.store,
    required this.service,
  });

  @override
  State<ManageTranslationsScreen> createState() => _ManageTranslationsScreenState();
}

class _ManageTranslationsScreenState extends State<ManageTranslationsScreen> {
  late Future<List<BibleDto>> _availableFuture;
  late Future<List<Traducoe>> _installedFuture;

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  void _refresh() {
    // Busca traduções em português e inglês e mescla resultados
    _availableFuture = (() async {
      final lists = await Future.wait<List<BibleDto>>([
        widget.api.listBibles(language: 'por'),
        widget.api.listBibles(language: 'eng'),
      ]);
      final merged = <BibleDto>[]..addAll(lists[0])..addAll(lists[1]);
      // Remove duplicados por id e ordena por nome
      final byId = <String, BibleDto>{};
      for (final b in merged) {
        byId[b.id] = b;
      }
      final result = byId.values.toList();
      result.sort((a, b) => a.name.compareTo(b.name));
      return result;
    })();
    _installedFuture = widget.repo.listInstalledTranslations();
    setState(() {});
  }

  bool _isInstalled(String id, List<Traducoe> installed) {
    return installed.any((t) => t.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gerenciar Traduções')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Observer(builder: (_) {
              final s = widget.store;
              if (s.status == SyncStatus.downloading || s.status == SyncStatus.paused) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sincronizando: ${s.currentBibleId ?? ''}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: LinearProgressIndicator(
                            value: s.totalChapters == 0 ? null : s.progressPercent,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          s.totalChapters == 0
                              ? '—'
                              : '${(s.progressPercent * 100).clamp(0, 100).toStringAsFixed(0)}%',
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text('${s.completedChapters}/${s.totalChapters} capítulos'),
                        const Spacer(),
                        if (s.paused)
                          ElevatedButton.icon(
                            onPressed: widget.service.resume,
                            icon: const Icon(Icons.play_arrow),
                            label: const Text('Retomar'),
                          )
                        else
                          ElevatedButton.icon(
                            onPressed: widget.service.pause,
                            icon: const Icon(Icons.pause),
                            label: const Text('Pausar'),
                          ),
                      ],
                    ),
                  ],
                );
              }
              if (s.status == SyncStatus.completed) {
                return Row(
                  children: [
                    const Icon(Icons.check_circle, color: Colors.green),
                    const SizedBox(width: 8),
                    const Text('Sincronização concluída'),
                  ],
                );
              }
              if (s.status == SyncStatus.error) {
                return Row(
                  children: [
                    const Icon(Icons.error, color: Colors.red),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Erro: ${s.errorMessage ?? ''}',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                );
              }
              return const SizedBox.shrink();
            }),
            const SizedBox(height: 16),
            Expanded(
              child: FutureBuilder<List<BibleDto>>(
                future: _availableFuture,
                builder: (context, availableSnap) {
                  return FutureBuilder<List<Traducoe>>(
                    future: _installedFuture,
                    builder: (context, installedSnap) {
                      if (availableSnap.connectionState == ConnectionState.waiting ||
                          installedSnap.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (availableSnap.hasError) {
                        return Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.wifi_off, size: 40),
                              const SizedBox(height: 8),
                              const Text('Sem internet ou API indisponível.'),
                              const SizedBox(height: 12),
                              FilledButton.icon(
                                onPressed: _refresh,
                                icon: const Icon(Icons.refresh),
                                label: const Text('Tentar novamente'),
                              ),
                            ],
                          ),
                        );
                      }
                      if (installedSnap.hasError) {
                        return Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.error_outline, size: 40),
                              const SizedBox(height: 8),
                              const Text('Erro ao carregar traduções instaladas.'),
                              const SizedBox(height: 12),
                              FilledButton.icon(
                                onPressed: _refresh,
                                icon: const Icon(Icons.refresh),
                                label: const Text('Recarregar'),
                              ),
                            ],
                          ),
                        );
                      }
                      final available = availableSnap.data ?? const <BibleDto>[];
                      final installed = installedSnap.data ?? const <Traducoe>[];

                      return ListView.separated(
                        itemCount: available.length,
                        separatorBuilder: (_, __) => const Divider(height: 1),
                        itemBuilder: (context, index) {
                          final b = available[index];
                          final isInstalled = _isInstalled(b.id, installed);
                          return ListTile(
                            title: Text(b.name),
                            subtitle: Text('${b.abbreviation} • ${b.languageId}'),
                            trailing: isInstalled
                                ? Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text('Instalada'),
                                      const SizedBox(width: 12),
                                      IconButton(
                                        icon: const Icon(Icons.menu_book),
                                        tooltip: 'Ler',
                                        onPressed: () async {
                                          // Abre Reader com seleção inicial usando a tradução
                                          final readerStore = ReaderStore(widget.repo);
                                          readerStore.setTranslation(b.id);
                                          // Navega para a tela de leitura
                                          if (context.mounted) {
                                            await Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (_) => ReaderScreen(store: readerStore),
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.cloud_queue),
                                        tooltip: 'Ler online',
                                        onPressed: () async {
                                          if (context.mounted) {
                                            await Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (_) => OnlineReaderScreen(
                                                  api: widget.api,
                                                  bibleId: b.id,
                                                  bibleName: b.name,
                                                ),
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.delete),
                                        tooltip: 'Remover',
                                        onPressed: () async {
                                          await widget.service.removeTranslation(b.id);
                                          _refresh();
                                        },
                                      ),
                                    ],
                                  )
                                : Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () async {
                                          await widget.service.installTranslation(b);
                                          _refresh();
                                        },
                                        child: const Text('Instalar'),
                                      ),
                                      const SizedBox(width: 8),
                                      IconButton(
                                        icon: const Icon(Icons.cloud_queue),
                                        tooltip: 'Ler online',
                                        onPressed: () async {
                                          if (context.mounted) {
                                            await Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (_) => OnlineReaderScreen(
                                                  api: widget.api,
                                                  bibleId: b.id,
                                                  bibleName: b.name,
                                                ),
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}