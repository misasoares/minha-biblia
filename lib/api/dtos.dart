class BibleDto {
  final String id;
  final String name;
  final String abbreviation;
  final String languageId;

  BibleDto({
    required this.id,
    required this.name,
    required this.abbreviation,
    required this.languageId,
  });

  factory BibleDto.fromJson(Map<String, dynamic> json) {
    final lang = json['language'] as Map<String, dynamic>?;
    return BibleDto(
      id: json['id'] as String,
      name: (json['nameLocal'] ?? json['name']) as String,
      abbreviation: (json['abbreviationLocal'] ?? json['abbreviation']) as String,
      languageId: (lang?['id'] ?? '') as String,
    );
  }
}

class BookDto {
  final String id;
  final String name;
  final String testament; // AT | NT | unknown

  BookDto({
    required this.id,
    required this.name,
    required this.testament,
  });

  factory BookDto.fromJson(Map<String, dynamic> json) {
    // API.Bible book payloads typically provide `name`, `id`, and sometimes `testament` via `type` or extra metadata.
    final type = json['type'] as String?; // 'ot' or 'nt' sometimes
    String testamento = 'unknown';
    if (type != null) {
      if (type.toLowerCase().contains('ot')) testamento = 'AT';
      if (type.toLowerCase().contains('nt')) testamento = 'NT';
    }
    return BookDto(
      id: json['id'] as String,
      name: (json['nameLocal'] ?? json['name']) as String,
      testament: testamento,
    );
  }
}

class ChapterDto {
  final String id;
  final String bookId;
  final int number;

  ChapterDto({
    required this.id,
    required this.bookId,
    required this.number,
  });

  factory ChapterDto.fromJson(Map<String, dynamic> json) {
    return ChapterDto(
      id: json['id'] as String,
      bookId: json['bookId'] as String,
      number: int.tryParse('${json['number']}') ?? 0,
    );
  }
}

class VerseDto {
  final String id;
  final int number;
  final String text;

  VerseDto({
    required this.id,
    required this.number,
    required this.text,
  });

  factory VerseDto.fromJson(Map<String, dynamic> json) {
    // In text content endpoints, verse text may be under `content` or `text`.
    final text = (json['text'] ?? json['content'] ?? '').toString().trim();
    final parsed = int.tryParse('${json['number']}');
    final number = parsed == null ? 0 : (parsed <= 0 ? 0 : parsed);
    return VerseDto(
      id: json['id'] as String,
      number: number,
      text: text,
    );
  }
}