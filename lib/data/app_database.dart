import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

// Traducoes (id, nome, sigla, idioma)
class Traducoes extends Table {
  TextColumn get id => text()();
  TextColumn get nome => text()();
  TextColumn get sigla => text()();
  TextColumn get idioma => text()();

  @override
  Set<Column> get primaryKey => {id};
}

// Livros (id, nome, testamento)
class Livros extends Table {
  TextColumn get id => text()();
  TextColumn get nome => text()();
  TextColumn get testamento => text()(); // 'AT' | 'NT'

  @override
  Set<Column> get primaryKey => {id};
}

// Versiculos (id, traducao_id, livro_id, capitulo, numero_versiculo, texto)
class Versiculos extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get traducaoId => text().references(Traducoes, #id)();
  TextColumn get livroId => text().references(Livros, #id)();
  IntColumn get capitulo => integer()();
  IntColumn get numeroVersiculo => integer()();
  TextColumn get texto => text()();

  // Para evitar duplicidade de versículos por tradução
  @override
  List<String> get customConstraints => [
        'UNIQUE(traducao_id, livro_id, capitulo, numero_versiculo)'
      ];
}

@DriftDatabase(tables: [Traducoes, Livros, Versiculos])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // Exemplos de operações básicas (podemos expandir conforme necessário)
  Future<void> upsertTraducao(TraducoesCompanion entry) async {
    await into(traducoes).insert(entry, mode: InsertMode.insertOrReplace);
  }

  Future<void> upsertLivro(LivrosCompanion entry) async {
    await into(livros).insert(entry, mode: InsertMode.insertOrReplace);
  }

  Future<void> insertVersiculo(VersiculosCompanion entry) async {
    await into(versiculos).insert(entry);
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final Directory appDocDir = await getApplicationDocumentsDirectory();
    final file = File(p.join(appDocDir.path, 'biblia_app.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}