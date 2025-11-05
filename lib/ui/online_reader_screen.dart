import 'package:flutter/material.dart';
import '../api/api_bible_client.dart';
import '../api/dtos.dart';

class OnlineReaderScreen extends StatefulWidget {
  final ApiBibleClient api;
  final String bibleId;
  final String? bibleName;

  const OnlineReaderScreen({
    super.key,
    required this.api,
    required this.bibleId,
    this.bibleName,
  });

  @override
  State<OnlineReaderScreen> createState() => _OnlineReaderScreenState();
}

class _OnlineReaderScreenState extends State<OnlineReaderScreen> {
  List<BookDto> _books = const [];
  String? _bookId;
  List<ChapterDto> _chapters = const [];
  String? _chapterId;
  int? _chapterNumber;
  Future<List<VerseDto>>? _versesFuture;
  String? _error;
  bool _loadingBooks = false;
  bool _loadingChapters = false;

  @override
  void initState() {
    super.initState();
    _loadBooks();
  }

  Future<void> _loadBooks() async {
    setState(() {
      _loadingBooks = true;
      _error = null;
    });
    try {
      final books = await widget.api.listBooks(widget.bibleId);
      setState(() {
        _books = books;
      });
    } catch (e) {
      setState(() {
        _error = 'Falha ao listar livros: $e';
      });
    } finally {
      setState(() {
        _loadingBooks = false;
      });
    }
  }

  Future<void> _loadChapters(String bookId) async {
    setState(() {
      _loadingChapters = true;
      _error = null;
      _chapters = const [];
      _chapterId = null;
      _chapterNumber = null;
      _versesFuture = null;
    });
    try {
      final chapters = await widget.api.listChapters(widget.bibleId, bookId);
      setState(() {
        _chapters = chapters;
      });
    } catch (e) {
      setState(() {
        _error = 'Falha ao listar capítulos: $e';
      });
    } finally {
      setState(() {
        _loadingChapters = false;
      });
    }
  }

  void _loadVerses(String chapterId, int number) {
    setState(() {
      _error = null;
      _versesFuture = widget.api.listChapterVerses(widget.bibleId, chapterId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.bibleName == null
            ? 'Ler online'
            : 'Ler online • ${widget.bibleName}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_error != null)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  border: Border.all(color: Colors.redAccent),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.error, color: Colors.red),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _error!,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.refresh),
                      tooltip: 'Tentar novamente',
                      onPressed: () {
                        if (_bookId == null) {
                          _loadBooks();
                        } else if (_chapterId == null) {
                          _loadChapters(_bookId!);
                        } else {
                          _loadVerses(_chapterId!, _chapterNumber!);
                        }
                      },
                    ),
                  ],
                ),
              ),
            Row(
              children: [
                Expanded(
                  child: InputDecorator(
                    decoration: const InputDecoration(
                      labelText: 'Livro',
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                    child: _loadingBooks
                        ? const SizedBox(
                            height: 24,
                            child: LinearProgressIndicator(),
                          )
                        : DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              isExpanded: true,
                              value: _bookId,
                              hint: const Text('Selecione um livro'),
                              items: _books
                                  .map((b) => DropdownMenuItem<String>(
                                        value: b.id,
                                        child: Text(b.name),
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  _bookId = value;
                                });
                                if (value != null) {
                                  _loadChapters(value);
                                }
                              },
                            ),
                          ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: InputDecorator(
                    decoration: const InputDecoration(
                      labelText: 'Capítulo',
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                    child: _loadingChapters
                        ? const SizedBox(
                            height: 24,
                            child: LinearProgressIndicator(),
                          )
                        : DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              isExpanded: true,
                              value: _chapterId,
                              hint: const Text('Selecione um capítulo'),
                              items: _chapters
                                  .map((c) => DropdownMenuItem<String>(
                                        value: c.id,
                                        child: Text('${c.number}'),
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  _chapterId = value;
                                  _chapterNumber = _chapters
                                      .firstWhere((c) => c.id == value)
                                      .number;
                                });
                                if (value != null && _chapterNumber != null) {
                                  _loadVerses(value, _chapterNumber!);
                                }
                              },
                            ),
                          ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _versesFuture == null
                  ? const Center(
                      child: Text('Selecione livro e capítulo para ler.'),
                    )
                  : FutureBuilder<List<VerseDto>>(
                      future: _versesFuture,
                      builder: (context, snap) {
                        if (snap.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        if (snap.hasError) {
                          return Center(
                            child: Text('Erro ao carregar versos: ${snap.error}'),
                          );
                        }
                        final verses = snap.data ?? const <VerseDto>[];
                        if (verses.isEmpty) {
                          return const Center(child: Text('Sem versos para este capítulo.'));
                        }
                        return ListView.separated(
                          itemCount: verses.length,
                          separatorBuilder: (_, __) => const Divider(height: 1),
                          itemBuilder: (context, index) {
                            final v = verses[index];
                            return ListTile(
                              leading: CircleAvatar(
                                radius: 14,
                                child: Text('${v.number}'),
                              ),
                              title: Text(v.text),
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