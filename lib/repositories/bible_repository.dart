import 'dart:developer' as developer;
import 'package:drift/drift.dart';
import '../api/dtos.dart';
import '../data/app_database.dart';

class BibleRepository {
  final AppDatabase db;

  BibleRepository(this.db);

  TraducoesCompanion toTraducaoCompanion(BibleDto dto) {
    return TraducoesCompanion(
      id: Value(dto.id),
      nome: Value(dto.name),
      sigla: Value(dto.abbreviation),
      idioma: Value(dto.languageId),
    );
  }

  LivrosCompanion toLivroCompanion(BookDto dto) {
    return LivrosCompanion(
      id: Value(dto.id),
      nome: Value(dto.name),
      testamento: Value(dto.testament),
    );
  }

  VersiculosCompanion toVersiculoCompanion({
    required String traducaoId,
    required String livroId,
    required int capitulo,
    required VerseDto verse,
  }) {
    return VersiculosCompanion(
      traducaoId: Value(traducaoId),
      livroId: Value(livroId),
      capitulo: Value(capitulo),
      numeroVersiculo: Value(verse.number),
      texto: Value(verse.text),
    );
  }

  Future<void> upsertTraducao(BibleDto dto) async {
    await db.upsertTraducao(toTraducaoCompanion(dto));
  }

  Future<void> upsertLivros(List<BookDto> books) async {
    await db.batch((batch) {
      batch.insertAllOnConflictUpdate(
        db.livros,
        books.map(toLivroCompanion).toList(),
      );
    });
  }

  Future<void> insertVersos(
    String traducaoId,
    String livroId,
    int capitulo,
    List<VerseDto> verses,
  ) async {
    // Evita falhas por constraint UNIQUE: troca por OR REPLACE
    // Também filtra versos inválidos (número <= 0 ou texto vazio)
    final valid = verses
        .where((v) => (v.number > 0) && v.text.trim().isNotEmpty)
        .map((v) => toVersiculoCompanion(
              traducaoId: traducaoId,
              livroId: livroId,
              capitulo: capitulo,
              verse: v,
            ))
        .toList();
    if (valid.isEmpty) return;
    await db.batch((batch) {
      batch.insertAllOnConflictUpdate(db.versiculos, valid);
    });
  }

  Future<List<Traducoe>> listInstalledTranslations() {
    return db.select(db.traducoes).get();
  }

  Future<void> removeTranslation(String traducaoId) async {
    await db.transaction(() async {
      await (db.delete(db.versiculos)
            ..where((tbl) => tbl.traducaoId.equals(traducaoId)))
          .go();
      await (db.delete(db.traducoes)..where((tbl) => tbl.id.equals(traducaoId)))
          .go();
    });
  }

  Future<List<Versiculo>> getChapterVerses(
      String traducaoId, String livroId, int capitulo) {
    final q = (db.select(db.versiculos)
      ..where((v) => v.traducaoId.equals(traducaoId))
      ..where((v) => v.livroId.equals(livroId))
      ..where((v) => v.capitulo.equals(capitulo))
      ..orderBy([(v) => OrderingTerm.asc(v.numeroVersiculo)]));
    developer.log('getChapterVerses query',
        name: '##repo $traducaoId/$livroId/$capitulo');
    return q.get().then((rows) {
      developer.log('getChapterVerses rows=${rows.length}',
          name: '##repo $traducaoId/$livroId/$capitulo');
      return rows;
    });
  }

  Future<(String, int)?> firstAvailableChapter(String traducaoId) async {
    // Obtém o primeiro par (livroId, capitulo) que possui versículos para a tradução
    final rows = await (db.select(db.versiculos)
          ..where((v) => v.traducaoId.equals(traducaoId))
          ..orderBy([
            (v) => OrderingTerm.asc(v.livroId),
            (v) => OrderingTerm.asc(v.capitulo),
            (v) => OrderingTerm.asc(v.numeroVersiculo),
          ]))
        .get();
    if (rows.isEmpty) {
      developer.log('firstAvailableChapter: none', name: '##repo $traducaoId');
      return null;
    }
    final first = rows.first;
    developer.log('firstAvailableChapter: ${first.livroId}:${first.capitulo}',
        name: '##repo $traducaoId');
    return (first.livroId, first.capitulo);
  }

  Future<List<Livro>> listBooksForTranslation(String traducaoId) async {
    // Livros que têm pelo menos um versículo para a tradução
    final q = db.select(db.livros).join([
      innerJoin(
        db.versiculos,
        db.versiculos.livroId.equalsExp(db.livros.id) &
            db.versiculos.traducaoId.equals(traducaoId),
      ),
    ])
      ..groupBy([db.livros.id])
      ..orderBy([OrderingTerm.asc(db.livros.nome)]);

    final rows = await q.get();
    developer.log('listBooksForTranslation rows=${rows.length}',
        name: '##repo $traducaoId');
    return rows.map((r) => r.readTable(db.livros)).toList();
  }

  Future<List<int>> listAvailableChapters(
      String traducaoId, String livroId) async {
    final q = (db.selectOnly(db.versiculos)
      ..addColumns([db.versiculos.capitulo])
      ..where(db.versiculos.traducaoId.equals(traducaoId))
      ..where(db.versiculos.livroId.equals(livroId))
      ..groupBy([db.versiculos.capitulo])
      ..orderBy([OrderingTerm.asc(db.versiculos.capitulo)]));
    final rows = await q.get();
    developer.log('listAvailableChapters rows=${rows.length}',
        name: '##repo $traducaoId/$livroId');
    return rows.map((r) => r.read(db.versiculos.capitulo)!).toList();
  }
}
