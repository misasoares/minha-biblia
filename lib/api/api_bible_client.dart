import 'dart:developer' as developer;
import 'package:dio/dio.dart';
import '../core/config.dart';
import 'dtos.dart';

class ApiBibleClient {
  final Dio _dio;
  final String baseUrl;

  ApiBibleClient({Dio? dio})
      : baseUrl = '$apiBibleEndpoint/v1',
        _dio = dio ?? Dio(BaseOptions(baseUrl: '$apiBibleEndpoint/v1')) {
    if (apiBibleKey.isNotEmpty) {
      _dio.options.headers['api-key'] = apiBibleKey;
    }
    _dio.options.headers['Accept'] = 'application/json';
  }

  Future<List<BibleDto>> listBibles({String language = 'por'}) async {
    final res = await _dio.get('/bibles', queryParameters: {
      'language': language,
    });
    final data = res.data['data'] as List<dynamic>? ?? const [];
    return data
        .map((e) => BibleDto.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<BookDto>> listBooks(String bibleId) async {
    developer.log('GET /bibles/$bibleId/books', name: '##$bibleId');
    final res = await _dio.get('/bibles/$bibleId/books');
    final data = res.data['data'] as List<dynamic>? ?? const [];
    return data
        .map((e) => BookDto.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<ChapterDto>> listChapters(String bibleId, String bookId) async {
    // Some APIs expose /bibles/{bibleId}/books/{bookId}/chapters
    final res = await _dio.get('/bibles/$bibleId/books/$bookId/chapters');
    final data = res.data['data'] as List<dynamic>? ?? const [];
    // Ensure we inject bookId into the payload if missing
    return data.map((raw) {
      final map = (raw as Map<String, dynamic>);
      if (!map.containsKey('bookId')) map['bookId'] = bookId;
      return ChapterDto.fromJson(map);
    }).toList();
  }

  Future<List<VerseDto>> listChapterVerses(
      String bibleId, String chapterId) async {
    // Prefer verses endpoint for clean split by verse number
    Response res;
    try {
      res = await _dio
          .get('/bibles/$bibleId/chapters/$chapterId/verses', queryParameters: {
        'content-type': 'text',
        'include-verse-numbers': true,
      });
      final data = res.data['data'] as List<dynamic>? ?? const [];
      return data
          .map((e) => VerseDto.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (_) {
      // Fallback to chapter content and try best-effort split (may be improved later)
      res = await _dio.get('/chapters/$chapterId', queryParameters: {
        'content-type': 'text',
        'include-verse-numbers': true,
      });
      final content = (res.data['data']?['content'] ?? '') as String;
      // Split básico: cria versos apenas quando a linha inicia com número;
      // linhas sem número após o primeiro verso são concatenadas ao texto anterior.
      final lines = content
          .split(RegExp(r'\n+'))
          .map((l) => l.trim())
          .where((l) => l.isNotEmpty)
          .toList();
      final verses = <VerseDto>[];
      int currentNumber = 0;
      for (final line in lines) {
        final m = RegExp(r'^(\d+)\s*(.*)').firstMatch(line);
        if (m != null) {
          currentNumber = int.tryParse(m.group(1)!) ?? currentNumber;
          final text = (m.group(2) ?? '').trim();
          if (currentNumber > 0 && text.isNotEmpty) {
            verses.add(VerseDto(
                id: 'v$currentNumber', number: currentNumber, text: text));
          }
        } else {
          // Se já temos um verso corrente, concatena texto extra a ele
          if (currentNumber > 0 && verses.isNotEmpty) {
            final last = verses.removeLast();
            final merged =
                (last.text.trim().isEmpty) ? line : '${last.text} ${line}';
            verses.add(VerseDto(
                id: last.id, number: last.number, text: merged.trim()));
          }
        }
      }
      return verses;
    }
  }
}
