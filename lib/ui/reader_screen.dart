import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

import '../stores/reader_store.dart';

class ReaderScreen extends StatefulWidget {
  final ReaderStore store;

  const ReaderScreen({super.key, required this.store});

  @override
  State<ReaderScreen> createState() => _ReaderScreenState();
}

class _ReaderScreenState extends State<ReaderScreen> {
  @override
  void initState() {
    super.initState();
    // Garante seleção inicial caso só a tradução esteja definida
    widget.store.ensureInitialSelectionForTranslation();
    // Carrega livros para a tradução atual (UI de seleção)
    widget.store.loadBooksForTranslation();
  }

  @override
  Widget build(BuildContext context) {
    final store = widget.store;
    return Scaffold(
      appBar: AppBar(
        title: Text(_titleFor(store)),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu_book),
            tooltip: 'Selecionar livro/capítulo',
            onPressed: () => _openSelectionSheet(context, store),
          ),
        ],
      ),
      body: Observer(builder: (_) {
        final future = store.versesFuture;
        if (future == null || future.status == FutureStatus.pending) {
          developer.log(
              'UI pending: hasSelection=${store.hasSelection} traducao=${store.traducaoId} livro=${store.livroId} cap=${store.capitulo}',
              name: '##reader.ui');
          return const Center(child: CircularProgressIndicator());
        }
        if (future.status == FutureStatus.rejected) {
          developer.log('UI rejected', name: '##reader.ui');
          return const Center(child: Text('Erro ao carregar'));
        }
        final verses = future.value;
        if (verses == null || verses.isEmpty) {
          developer.log('UI empty verses', name: '##reader.ui');
          return const Center(child: Text('Nenhum versículo encontrado'));
        }
        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          itemCount: verses.length,
          itemBuilder: (context, index) {
            final v = verses[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        height: 1.6,
                        fontSize: 18,
                      ),
                  children: [
                    WidgetSpan(
                      alignment: PlaceholderAlignment.baseline,
                      baseline: TextBaseline.alphabetic,
                      child: Container(
                        padding: const EdgeInsets.only(right: 8),
                        child: Text(
                          '${v.numeroVersiculo}',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.secondary,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                    ),
                    TextSpan(text: v.texto),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }

  String _titleFor(ReaderStore store) {
    if (!store.hasSelection) {
      return 'Leitura';
    }
    return 'Capítulo ${store.capitulo}';
  }

  void _openSelectionSheet(BuildContext context, ReaderStore store) async {
    final theme = Theme.of(context);
    // Carrega sem aguardar; a folha usa Observer e atualiza quando prontos
    // evita usar BuildContext após await
    // ignore: unawaited_futures
    store.loadBooksForTranslation();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: 16 + MediaQuery.of(ctx).viewInsets.bottom,
          ),
          child: Observer(builder: (_) {
            final books = store.books;
            final currentLivroId = store.livroId;
            final currentCap = store.capitulo;
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Seleção de leitura', style: theme.textTheme.titleMedium),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: currentLivroId ??
                      (books.isNotEmpty ? books.first.id : null),
                  items: books
                      .map((b) => DropdownMenuItem<String>(
                            value: (b as dynamic).id as String,
                            child: Text((b as dynamic).nome as String),
                          ))
                      .toList(),
                  onChanged: (value) async {
                    if (value == null) return;
                    await store.loadChaptersForBook(value);
                    final firstCap =
                        store.chapters.isNotEmpty ? store.chapters.first : 1;
                    await store.setSelection(value, firstCap);
                  },
                  decoration: const InputDecoration(labelText: 'Livro'),
                ),
                const SizedBox(height: 12),
                Observer(builder: (_) {
                  final chapters = store.chapters;
                  return DropdownButtonFormField<int>(
                    value: currentCap ??
                        (chapters.isNotEmpty ? chapters.first : null),
                    items: chapters
                        .map((c) => DropdownMenuItem(
                              value: c,
                              child: Text('Capítulo $c'),
                            ))
                        .toList(),
                    onChanged: (value) async {
                      final livro = store.livroId;
                      if (livro == null || value == null) return;
                      await store.setSelection(livro, value);
                    },
                    decoration: const InputDecoration(labelText: 'Capítulo'),
                  );
                }),
                const SizedBox(height: 16),
                FilledButton.icon(
                  onPressed: () => Navigator.of(ctx).pop(),
                  icon: const Icon(Icons.check),
                  label: const Text('Aplicar'),
                ),
              ],
            );
          }),
        );
      },
    );
  }
}
