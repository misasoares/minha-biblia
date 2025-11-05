// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $TraducoesTable extends Traducoes
    with TableInfo<$TraducoesTable, Traducoe> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TraducoesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nomeMeta = const VerificationMeta('nome');
  @override
  late final GeneratedColumn<String> nome = GeneratedColumn<String>(
      'nome', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _siglaMeta = const VerificationMeta('sigla');
  @override
  late final GeneratedColumn<String> sigla = GeneratedColumn<String>(
      'sigla', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _idiomaMeta = const VerificationMeta('idioma');
  @override
  late final GeneratedColumn<String> idioma = GeneratedColumn<String>(
      'idioma', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, nome, sigla, idioma];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'traducoes';
  @override
  VerificationContext validateIntegrity(Insertable<Traducoe> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('nome')) {
      context.handle(
          _nomeMeta, nome.isAcceptableOrUnknown(data['nome']!, _nomeMeta));
    } else if (isInserting) {
      context.missing(_nomeMeta);
    }
    if (data.containsKey('sigla')) {
      context.handle(
          _siglaMeta, sigla.isAcceptableOrUnknown(data['sigla']!, _siglaMeta));
    } else if (isInserting) {
      context.missing(_siglaMeta);
    }
    if (data.containsKey('idioma')) {
      context.handle(_idiomaMeta,
          idioma.isAcceptableOrUnknown(data['idioma']!, _idiomaMeta));
    } else if (isInserting) {
      context.missing(_idiomaMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Traducoe map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Traducoe(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      nome: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nome'])!,
      sigla: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sigla'])!,
      idioma: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}idioma'])!,
    );
  }

  @override
  $TraducoesTable createAlias(String alias) {
    return $TraducoesTable(attachedDatabase, alias);
  }
}

class Traducoe extends DataClass implements Insertable<Traducoe> {
  final String id;
  final String nome;
  final String sigla;
  final String idioma;
  const Traducoe(
      {required this.id,
      required this.nome,
      required this.sigla,
      required this.idioma});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['nome'] = Variable<String>(nome);
    map['sigla'] = Variable<String>(sigla);
    map['idioma'] = Variable<String>(idioma);
    return map;
  }

  TraducoesCompanion toCompanion(bool nullToAbsent) {
    return TraducoesCompanion(
      id: Value(id),
      nome: Value(nome),
      sigla: Value(sigla),
      idioma: Value(idioma),
    );
  }

  factory Traducoe.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Traducoe(
      id: serializer.fromJson<String>(json['id']),
      nome: serializer.fromJson<String>(json['nome']),
      sigla: serializer.fromJson<String>(json['sigla']),
      idioma: serializer.fromJson<String>(json['idioma']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'nome': serializer.toJson<String>(nome),
      'sigla': serializer.toJson<String>(sigla),
      'idioma': serializer.toJson<String>(idioma),
    };
  }

  Traducoe copyWith(
          {String? id, String? nome, String? sigla, String? idioma}) =>
      Traducoe(
        id: id ?? this.id,
        nome: nome ?? this.nome,
        sigla: sigla ?? this.sigla,
        idioma: idioma ?? this.idioma,
      );
  Traducoe copyWithCompanion(TraducoesCompanion data) {
    return Traducoe(
      id: data.id.present ? data.id.value : this.id,
      nome: data.nome.present ? data.nome.value : this.nome,
      sigla: data.sigla.present ? data.sigla.value : this.sigla,
      idioma: data.idioma.present ? data.idioma.value : this.idioma,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Traducoe(')
          ..write('id: $id, ')
          ..write('nome: $nome, ')
          ..write('sigla: $sigla, ')
          ..write('idioma: $idioma')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nome, sigla, idioma);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Traducoe &&
          other.id == this.id &&
          other.nome == this.nome &&
          other.sigla == this.sigla &&
          other.idioma == this.idioma);
}

class TraducoesCompanion extends UpdateCompanion<Traducoe> {
  final Value<String> id;
  final Value<String> nome;
  final Value<String> sigla;
  final Value<String> idioma;
  final Value<int> rowid;
  const TraducoesCompanion({
    this.id = const Value.absent(),
    this.nome = const Value.absent(),
    this.sigla = const Value.absent(),
    this.idioma = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TraducoesCompanion.insert({
    required String id,
    required String nome,
    required String sigla,
    required String idioma,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        nome = Value(nome),
        sigla = Value(sigla),
        idioma = Value(idioma);
  static Insertable<Traducoe> custom({
    Expression<String>? id,
    Expression<String>? nome,
    Expression<String>? sigla,
    Expression<String>? idioma,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nome != null) 'nome': nome,
      if (sigla != null) 'sigla': sigla,
      if (idioma != null) 'idioma': idioma,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TraducoesCompanion copyWith(
      {Value<String>? id,
      Value<String>? nome,
      Value<String>? sigla,
      Value<String>? idioma,
      Value<int>? rowid}) {
    return TraducoesCompanion(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      sigla: sigla ?? this.sigla,
      idioma: idioma ?? this.idioma,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (nome.present) {
      map['nome'] = Variable<String>(nome.value);
    }
    if (sigla.present) {
      map['sigla'] = Variable<String>(sigla.value);
    }
    if (idioma.present) {
      map['idioma'] = Variable<String>(idioma.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TraducoesCompanion(')
          ..write('id: $id, ')
          ..write('nome: $nome, ')
          ..write('sigla: $sigla, ')
          ..write('idioma: $idioma, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LivrosTable extends Livros with TableInfo<$LivrosTable, Livro> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LivrosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nomeMeta = const VerificationMeta('nome');
  @override
  late final GeneratedColumn<String> nome = GeneratedColumn<String>(
      'nome', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _testamentoMeta =
      const VerificationMeta('testamento');
  @override
  late final GeneratedColumn<String> testamento = GeneratedColumn<String>(
      'testamento', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, nome, testamento];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'livros';
  @override
  VerificationContext validateIntegrity(Insertable<Livro> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('nome')) {
      context.handle(
          _nomeMeta, nome.isAcceptableOrUnknown(data['nome']!, _nomeMeta));
    } else if (isInserting) {
      context.missing(_nomeMeta);
    }
    if (data.containsKey('testamento')) {
      context.handle(
          _testamentoMeta,
          testamento.isAcceptableOrUnknown(
              data['testamento']!, _testamentoMeta));
    } else if (isInserting) {
      context.missing(_testamentoMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Livro map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Livro(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      nome: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nome'])!,
      testamento: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}testamento'])!,
    );
  }

  @override
  $LivrosTable createAlias(String alias) {
    return $LivrosTable(attachedDatabase, alias);
  }
}

class Livro extends DataClass implements Insertable<Livro> {
  final String id;
  final String nome;
  final String testamento;
  const Livro({required this.id, required this.nome, required this.testamento});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['nome'] = Variable<String>(nome);
    map['testamento'] = Variable<String>(testamento);
    return map;
  }

  LivrosCompanion toCompanion(bool nullToAbsent) {
    return LivrosCompanion(
      id: Value(id),
      nome: Value(nome),
      testamento: Value(testamento),
    );
  }

  factory Livro.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Livro(
      id: serializer.fromJson<String>(json['id']),
      nome: serializer.fromJson<String>(json['nome']),
      testamento: serializer.fromJson<String>(json['testamento']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'nome': serializer.toJson<String>(nome),
      'testamento': serializer.toJson<String>(testamento),
    };
  }

  Livro copyWith({String? id, String? nome, String? testamento}) => Livro(
        id: id ?? this.id,
        nome: nome ?? this.nome,
        testamento: testamento ?? this.testamento,
      );
  Livro copyWithCompanion(LivrosCompanion data) {
    return Livro(
      id: data.id.present ? data.id.value : this.id,
      nome: data.nome.present ? data.nome.value : this.nome,
      testamento:
          data.testamento.present ? data.testamento.value : this.testamento,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Livro(')
          ..write('id: $id, ')
          ..write('nome: $nome, ')
          ..write('testamento: $testamento')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nome, testamento);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Livro &&
          other.id == this.id &&
          other.nome == this.nome &&
          other.testamento == this.testamento);
}

class LivrosCompanion extends UpdateCompanion<Livro> {
  final Value<String> id;
  final Value<String> nome;
  final Value<String> testamento;
  final Value<int> rowid;
  const LivrosCompanion({
    this.id = const Value.absent(),
    this.nome = const Value.absent(),
    this.testamento = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LivrosCompanion.insert({
    required String id,
    required String nome,
    required String testamento,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        nome = Value(nome),
        testamento = Value(testamento);
  static Insertable<Livro> custom({
    Expression<String>? id,
    Expression<String>? nome,
    Expression<String>? testamento,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nome != null) 'nome': nome,
      if (testamento != null) 'testamento': testamento,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LivrosCompanion copyWith(
      {Value<String>? id,
      Value<String>? nome,
      Value<String>? testamento,
      Value<int>? rowid}) {
    return LivrosCompanion(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      testamento: testamento ?? this.testamento,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (nome.present) {
      map['nome'] = Variable<String>(nome.value);
    }
    if (testamento.present) {
      map['testamento'] = Variable<String>(testamento.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LivrosCompanion(')
          ..write('id: $id, ')
          ..write('nome: $nome, ')
          ..write('testamento: $testamento, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $VersiculosTable extends Versiculos
    with TableInfo<$VersiculosTable, Versiculo> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VersiculosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _traducaoIdMeta =
      const VerificationMeta('traducaoId');
  @override
  late final GeneratedColumn<String> traducaoId = GeneratedColumn<String>(
      'traducao_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES traducoes (id)'));
  static const VerificationMeta _livroIdMeta =
      const VerificationMeta('livroId');
  @override
  late final GeneratedColumn<String> livroId = GeneratedColumn<String>(
      'livro_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES livros (id)'));
  static const VerificationMeta _capituloMeta =
      const VerificationMeta('capitulo');
  @override
  late final GeneratedColumn<int> capitulo = GeneratedColumn<int>(
      'capitulo', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _numeroVersiculoMeta =
      const VerificationMeta('numeroVersiculo');
  @override
  late final GeneratedColumn<int> numeroVersiculo = GeneratedColumn<int>(
      'numero_versiculo', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _textoMeta = const VerificationMeta('texto');
  @override
  late final GeneratedColumn<String> texto = GeneratedColumn<String>(
      'texto', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, traducaoId, livroId, capitulo, numeroVersiculo, texto];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'versiculos';
  @override
  VerificationContext validateIntegrity(Insertable<Versiculo> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('traducao_id')) {
      context.handle(
          _traducaoIdMeta,
          traducaoId.isAcceptableOrUnknown(
              data['traducao_id']!, _traducaoIdMeta));
    } else if (isInserting) {
      context.missing(_traducaoIdMeta);
    }
    if (data.containsKey('livro_id')) {
      context.handle(_livroIdMeta,
          livroId.isAcceptableOrUnknown(data['livro_id']!, _livroIdMeta));
    } else if (isInserting) {
      context.missing(_livroIdMeta);
    }
    if (data.containsKey('capitulo')) {
      context.handle(_capituloMeta,
          capitulo.isAcceptableOrUnknown(data['capitulo']!, _capituloMeta));
    } else if (isInserting) {
      context.missing(_capituloMeta);
    }
    if (data.containsKey('numero_versiculo')) {
      context.handle(
          _numeroVersiculoMeta,
          numeroVersiculo.isAcceptableOrUnknown(
              data['numero_versiculo']!, _numeroVersiculoMeta));
    } else if (isInserting) {
      context.missing(_numeroVersiculoMeta);
    }
    if (data.containsKey('texto')) {
      context.handle(
          _textoMeta, texto.isAcceptableOrUnknown(data['texto']!, _textoMeta));
    } else if (isInserting) {
      context.missing(_textoMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Versiculo map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Versiculo(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      traducaoId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}traducao_id'])!,
      livroId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}livro_id'])!,
      capitulo: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}capitulo'])!,
      numeroVersiculo: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}numero_versiculo'])!,
      texto: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}texto'])!,
    );
  }

  @override
  $VersiculosTable createAlias(String alias) {
    return $VersiculosTable(attachedDatabase, alias);
  }
}

class Versiculo extends DataClass implements Insertable<Versiculo> {
  final int id;
  final String traducaoId;
  final String livroId;
  final int capitulo;
  final int numeroVersiculo;
  final String texto;
  const Versiculo(
      {required this.id,
      required this.traducaoId,
      required this.livroId,
      required this.capitulo,
      required this.numeroVersiculo,
      required this.texto});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['traducao_id'] = Variable<String>(traducaoId);
    map['livro_id'] = Variable<String>(livroId);
    map['capitulo'] = Variable<int>(capitulo);
    map['numero_versiculo'] = Variable<int>(numeroVersiculo);
    map['texto'] = Variable<String>(texto);
    return map;
  }

  VersiculosCompanion toCompanion(bool nullToAbsent) {
    return VersiculosCompanion(
      id: Value(id),
      traducaoId: Value(traducaoId),
      livroId: Value(livroId),
      capitulo: Value(capitulo),
      numeroVersiculo: Value(numeroVersiculo),
      texto: Value(texto),
    );
  }

  factory Versiculo.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Versiculo(
      id: serializer.fromJson<int>(json['id']),
      traducaoId: serializer.fromJson<String>(json['traducaoId']),
      livroId: serializer.fromJson<String>(json['livroId']),
      capitulo: serializer.fromJson<int>(json['capitulo']),
      numeroVersiculo: serializer.fromJson<int>(json['numeroVersiculo']),
      texto: serializer.fromJson<String>(json['texto']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'traducaoId': serializer.toJson<String>(traducaoId),
      'livroId': serializer.toJson<String>(livroId),
      'capitulo': serializer.toJson<int>(capitulo),
      'numeroVersiculo': serializer.toJson<int>(numeroVersiculo),
      'texto': serializer.toJson<String>(texto),
    };
  }

  Versiculo copyWith(
          {int? id,
          String? traducaoId,
          String? livroId,
          int? capitulo,
          int? numeroVersiculo,
          String? texto}) =>
      Versiculo(
        id: id ?? this.id,
        traducaoId: traducaoId ?? this.traducaoId,
        livroId: livroId ?? this.livroId,
        capitulo: capitulo ?? this.capitulo,
        numeroVersiculo: numeroVersiculo ?? this.numeroVersiculo,
        texto: texto ?? this.texto,
      );
  Versiculo copyWithCompanion(VersiculosCompanion data) {
    return Versiculo(
      id: data.id.present ? data.id.value : this.id,
      traducaoId:
          data.traducaoId.present ? data.traducaoId.value : this.traducaoId,
      livroId: data.livroId.present ? data.livroId.value : this.livroId,
      capitulo: data.capitulo.present ? data.capitulo.value : this.capitulo,
      numeroVersiculo: data.numeroVersiculo.present
          ? data.numeroVersiculo.value
          : this.numeroVersiculo,
      texto: data.texto.present ? data.texto.value : this.texto,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Versiculo(')
          ..write('id: $id, ')
          ..write('traducaoId: $traducaoId, ')
          ..write('livroId: $livroId, ')
          ..write('capitulo: $capitulo, ')
          ..write('numeroVersiculo: $numeroVersiculo, ')
          ..write('texto: $texto')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, traducaoId, livroId, capitulo, numeroVersiculo, texto);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Versiculo &&
          other.id == this.id &&
          other.traducaoId == this.traducaoId &&
          other.livroId == this.livroId &&
          other.capitulo == this.capitulo &&
          other.numeroVersiculo == this.numeroVersiculo &&
          other.texto == this.texto);
}

class VersiculosCompanion extends UpdateCompanion<Versiculo> {
  final Value<int> id;
  final Value<String> traducaoId;
  final Value<String> livroId;
  final Value<int> capitulo;
  final Value<int> numeroVersiculo;
  final Value<String> texto;
  const VersiculosCompanion({
    this.id = const Value.absent(),
    this.traducaoId = const Value.absent(),
    this.livroId = const Value.absent(),
    this.capitulo = const Value.absent(),
    this.numeroVersiculo = const Value.absent(),
    this.texto = const Value.absent(),
  });
  VersiculosCompanion.insert({
    this.id = const Value.absent(),
    required String traducaoId,
    required String livroId,
    required int capitulo,
    required int numeroVersiculo,
    required String texto,
  })  : traducaoId = Value(traducaoId),
        livroId = Value(livroId),
        capitulo = Value(capitulo),
        numeroVersiculo = Value(numeroVersiculo),
        texto = Value(texto);
  static Insertable<Versiculo> custom({
    Expression<int>? id,
    Expression<String>? traducaoId,
    Expression<String>? livroId,
    Expression<int>? capitulo,
    Expression<int>? numeroVersiculo,
    Expression<String>? texto,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (traducaoId != null) 'traducao_id': traducaoId,
      if (livroId != null) 'livro_id': livroId,
      if (capitulo != null) 'capitulo': capitulo,
      if (numeroVersiculo != null) 'numero_versiculo': numeroVersiculo,
      if (texto != null) 'texto': texto,
    });
  }

  VersiculosCompanion copyWith(
      {Value<int>? id,
      Value<String>? traducaoId,
      Value<String>? livroId,
      Value<int>? capitulo,
      Value<int>? numeroVersiculo,
      Value<String>? texto}) {
    return VersiculosCompanion(
      id: id ?? this.id,
      traducaoId: traducaoId ?? this.traducaoId,
      livroId: livroId ?? this.livroId,
      capitulo: capitulo ?? this.capitulo,
      numeroVersiculo: numeroVersiculo ?? this.numeroVersiculo,
      texto: texto ?? this.texto,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (traducaoId.present) {
      map['traducao_id'] = Variable<String>(traducaoId.value);
    }
    if (livroId.present) {
      map['livro_id'] = Variable<String>(livroId.value);
    }
    if (capitulo.present) {
      map['capitulo'] = Variable<int>(capitulo.value);
    }
    if (numeroVersiculo.present) {
      map['numero_versiculo'] = Variable<int>(numeroVersiculo.value);
    }
    if (texto.present) {
      map['texto'] = Variable<String>(texto.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VersiculosCompanion(')
          ..write('id: $id, ')
          ..write('traducaoId: $traducaoId, ')
          ..write('livroId: $livroId, ')
          ..write('capitulo: $capitulo, ')
          ..write('numeroVersiculo: $numeroVersiculo, ')
          ..write('texto: $texto')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $TraducoesTable traducoes = $TraducoesTable(this);
  late final $LivrosTable livros = $LivrosTable(this);
  late final $VersiculosTable versiculos = $VersiculosTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [traducoes, livros, versiculos];
}

typedef $$TraducoesTableCreateCompanionBuilder = TraducoesCompanion Function({
  required String id,
  required String nome,
  required String sigla,
  required String idioma,
  Value<int> rowid,
});
typedef $$TraducoesTableUpdateCompanionBuilder = TraducoesCompanion Function({
  Value<String> id,
  Value<String> nome,
  Value<String> sigla,
  Value<String> idioma,
  Value<int> rowid,
});

final class $$TraducoesTableReferences
    extends BaseReferences<_$AppDatabase, $TraducoesTable, Traducoe> {
  $$TraducoesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$VersiculosTable, List<Versiculo>>
      _versiculosRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.versiculos,
          aliasName:
              $_aliasNameGenerator(db.traducoes.id, db.versiculos.traducaoId));

  $$VersiculosTableProcessedTableManager get versiculosRefs {
    final manager = $$VersiculosTableTableManager($_db, $_db.versiculos)
        .filter((f) => f.traducaoId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_versiculosRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$TraducoesTableFilterComposer
    extends Composer<_$AppDatabase, $TraducoesTable> {
  $$TraducoesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nome => $composableBuilder(
      column: $table.nome, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get sigla => $composableBuilder(
      column: $table.sigla, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get idioma => $composableBuilder(
      column: $table.idioma, builder: (column) => ColumnFilters(column));

  Expression<bool> versiculosRefs(
      Expression<bool> Function($$VersiculosTableFilterComposer f) f) {
    final $$VersiculosTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.versiculos,
        getReferencedColumn: (t) => t.traducaoId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$VersiculosTableFilterComposer(
              $db: $db,
              $table: $db.versiculos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$TraducoesTableOrderingComposer
    extends Composer<_$AppDatabase, $TraducoesTable> {
  $$TraducoesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nome => $composableBuilder(
      column: $table.nome, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get sigla => $composableBuilder(
      column: $table.sigla, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get idioma => $composableBuilder(
      column: $table.idioma, builder: (column) => ColumnOrderings(column));
}

class $$TraducoesTableAnnotationComposer
    extends Composer<_$AppDatabase, $TraducoesTable> {
  $$TraducoesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nome =>
      $composableBuilder(column: $table.nome, builder: (column) => column);

  GeneratedColumn<String> get sigla =>
      $composableBuilder(column: $table.sigla, builder: (column) => column);

  GeneratedColumn<String> get idioma =>
      $composableBuilder(column: $table.idioma, builder: (column) => column);

  Expression<T> versiculosRefs<T extends Object>(
      Expression<T> Function($$VersiculosTableAnnotationComposer a) f) {
    final $$VersiculosTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.versiculos,
        getReferencedColumn: (t) => t.traducaoId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$VersiculosTableAnnotationComposer(
              $db: $db,
              $table: $db.versiculos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$TraducoesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TraducoesTable,
    Traducoe,
    $$TraducoesTableFilterComposer,
    $$TraducoesTableOrderingComposer,
    $$TraducoesTableAnnotationComposer,
    $$TraducoesTableCreateCompanionBuilder,
    $$TraducoesTableUpdateCompanionBuilder,
    (Traducoe, $$TraducoesTableReferences),
    Traducoe,
    PrefetchHooks Function({bool versiculosRefs})> {
  $$TraducoesTableTableManager(_$AppDatabase db, $TraducoesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TraducoesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TraducoesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TraducoesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> nome = const Value.absent(),
            Value<String> sigla = const Value.absent(),
            Value<String> idioma = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TraducoesCompanion(
            id: id,
            nome: nome,
            sigla: sigla,
            idioma: idioma,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String nome,
            required String sigla,
            required String idioma,
            Value<int> rowid = const Value.absent(),
          }) =>
              TraducoesCompanion.insert(
            id: id,
            nome: nome,
            sigla: sigla,
            idioma: idioma,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$TraducoesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({versiculosRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (versiculosRefs) db.versiculos],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (versiculosRefs)
                    await $_getPrefetchedData<Traducoe, $TraducoesTable,
                            Versiculo>(
                        currentTable: table,
                        referencedTable:
                            $$TraducoesTableReferences._versiculosRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$TraducoesTableReferences(db, table, p0)
                                .versiculosRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.traducaoId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$TraducoesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TraducoesTable,
    Traducoe,
    $$TraducoesTableFilterComposer,
    $$TraducoesTableOrderingComposer,
    $$TraducoesTableAnnotationComposer,
    $$TraducoesTableCreateCompanionBuilder,
    $$TraducoesTableUpdateCompanionBuilder,
    (Traducoe, $$TraducoesTableReferences),
    Traducoe,
    PrefetchHooks Function({bool versiculosRefs})>;
typedef $$LivrosTableCreateCompanionBuilder = LivrosCompanion Function({
  required String id,
  required String nome,
  required String testamento,
  Value<int> rowid,
});
typedef $$LivrosTableUpdateCompanionBuilder = LivrosCompanion Function({
  Value<String> id,
  Value<String> nome,
  Value<String> testamento,
  Value<int> rowid,
});

final class $$LivrosTableReferences
    extends BaseReferences<_$AppDatabase, $LivrosTable, Livro> {
  $$LivrosTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$VersiculosTable, List<Versiculo>>
      _versiculosRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.versiculos,
          aliasName: $_aliasNameGenerator(db.livros.id, db.versiculos.livroId));

  $$VersiculosTableProcessedTableManager get versiculosRefs {
    final manager = $$VersiculosTableTableManager($_db, $_db.versiculos)
        .filter((f) => f.livroId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_versiculosRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$LivrosTableFilterComposer
    extends Composer<_$AppDatabase, $LivrosTable> {
  $$LivrosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nome => $composableBuilder(
      column: $table.nome, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get testamento => $composableBuilder(
      column: $table.testamento, builder: (column) => ColumnFilters(column));

  Expression<bool> versiculosRefs(
      Expression<bool> Function($$VersiculosTableFilterComposer f) f) {
    final $$VersiculosTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.versiculos,
        getReferencedColumn: (t) => t.livroId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$VersiculosTableFilterComposer(
              $db: $db,
              $table: $db.versiculos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$LivrosTableOrderingComposer
    extends Composer<_$AppDatabase, $LivrosTable> {
  $$LivrosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nome => $composableBuilder(
      column: $table.nome, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get testamento => $composableBuilder(
      column: $table.testamento, builder: (column) => ColumnOrderings(column));
}

class $$LivrosTableAnnotationComposer
    extends Composer<_$AppDatabase, $LivrosTable> {
  $$LivrosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nome =>
      $composableBuilder(column: $table.nome, builder: (column) => column);

  GeneratedColumn<String> get testamento => $composableBuilder(
      column: $table.testamento, builder: (column) => column);

  Expression<T> versiculosRefs<T extends Object>(
      Expression<T> Function($$VersiculosTableAnnotationComposer a) f) {
    final $$VersiculosTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.versiculos,
        getReferencedColumn: (t) => t.livroId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$VersiculosTableAnnotationComposer(
              $db: $db,
              $table: $db.versiculos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$LivrosTableTableManager extends RootTableManager<
    _$AppDatabase,
    $LivrosTable,
    Livro,
    $$LivrosTableFilterComposer,
    $$LivrosTableOrderingComposer,
    $$LivrosTableAnnotationComposer,
    $$LivrosTableCreateCompanionBuilder,
    $$LivrosTableUpdateCompanionBuilder,
    (Livro, $$LivrosTableReferences),
    Livro,
    PrefetchHooks Function({bool versiculosRefs})> {
  $$LivrosTableTableManager(_$AppDatabase db, $LivrosTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LivrosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LivrosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LivrosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> nome = const Value.absent(),
            Value<String> testamento = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LivrosCompanion(
            id: id,
            nome: nome,
            testamento: testamento,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String nome,
            required String testamento,
            Value<int> rowid = const Value.absent(),
          }) =>
              LivrosCompanion.insert(
            id: id,
            nome: nome,
            testamento: testamento,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$LivrosTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({versiculosRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (versiculosRefs) db.versiculos],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (versiculosRefs)
                    await $_getPrefetchedData<Livro, $LivrosTable, Versiculo>(
                        currentTable: table,
                        referencedTable:
                            $$LivrosTableReferences._versiculosRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$LivrosTableReferences(db, table, p0)
                                .versiculosRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.livroId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$LivrosTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $LivrosTable,
    Livro,
    $$LivrosTableFilterComposer,
    $$LivrosTableOrderingComposer,
    $$LivrosTableAnnotationComposer,
    $$LivrosTableCreateCompanionBuilder,
    $$LivrosTableUpdateCompanionBuilder,
    (Livro, $$LivrosTableReferences),
    Livro,
    PrefetchHooks Function({bool versiculosRefs})>;
typedef $$VersiculosTableCreateCompanionBuilder = VersiculosCompanion Function({
  Value<int> id,
  required String traducaoId,
  required String livroId,
  required int capitulo,
  required int numeroVersiculo,
  required String texto,
});
typedef $$VersiculosTableUpdateCompanionBuilder = VersiculosCompanion Function({
  Value<int> id,
  Value<String> traducaoId,
  Value<String> livroId,
  Value<int> capitulo,
  Value<int> numeroVersiculo,
  Value<String> texto,
});

final class $$VersiculosTableReferences
    extends BaseReferences<_$AppDatabase, $VersiculosTable, Versiculo> {
  $$VersiculosTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $TraducoesTable _traducaoIdTable(_$AppDatabase db) =>
      db.traducoes.createAlias(
          $_aliasNameGenerator(db.versiculos.traducaoId, db.traducoes.id));

  $$TraducoesTableProcessedTableManager get traducaoId {
    final $_column = $_itemColumn<String>('traducao_id')!;

    final manager = $$TraducoesTableTableManager($_db, $_db.traducoes)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_traducaoIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $LivrosTable _livroIdTable(_$AppDatabase db) => db.livros
      .createAlias($_aliasNameGenerator(db.versiculos.livroId, db.livros.id));

  $$LivrosTableProcessedTableManager get livroId {
    final $_column = $_itemColumn<String>('livro_id')!;

    final manager = $$LivrosTableTableManager($_db, $_db.livros)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_livroIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$VersiculosTableFilterComposer
    extends Composer<_$AppDatabase, $VersiculosTable> {
  $$VersiculosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get capitulo => $composableBuilder(
      column: $table.capitulo, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get numeroVersiculo => $composableBuilder(
      column: $table.numeroVersiculo,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get texto => $composableBuilder(
      column: $table.texto, builder: (column) => ColumnFilters(column));

  $$TraducoesTableFilterComposer get traducaoId {
    final $$TraducoesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.traducaoId,
        referencedTable: $db.traducoes,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TraducoesTableFilterComposer(
              $db: $db,
              $table: $db.traducoes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$LivrosTableFilterComposer get livroId {
    final $$LivrosTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.livroId,
        referencedTable: $db.livros,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LivrosTableFilterComposer(
              $db: $db,
              $table: $db.livros,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$VersiculosTableOrderingComposer
    extends Composer<_$AppDatabase, $VersiculosTable> {
  $$VersiculosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get capitulo => $composableBuilder(
      column: $table.capitulo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get numeroVersiculo => $composableBuilder(
      column: $table.numeroVersiculo,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get texto => $composableBuilder(
      column: $table.texto, builder: (column) => ColumnOrderings(column));

  $$TraducoesTableOrderingComposer get traducaoId {
    final $$TraducoesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.traducaoId,
        referencedTable: $db.traducoes,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TraducoesTableOrderingComposer(
              $db: $db,
              $table: $db.traducoes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$LivrosTableOrderingComposer get livroId {
    final $$LivrosTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.livroId,
        referencedTable: $db.livros,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LivrosTableOrderingComposer(
              $db: $db,
              $table: $db.livros,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$VersiculosTableAnnotationComposer
    extends Composer<_$AppDatabase, $VersiculosTable> {
  $$VersiculosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get capitulo =>
      $composableBuilder(column: $table.capitulo, builder: (column) => column);

  GeneratedColumn<int> get numeroVersiculo => $composableBuilder(
      column: $table.numeroVersiculo, builder: (column) => column);

  GeneratedColumn<String> get texto =>
      $composableBuilder(column: $table.texto, builder: (column) => column);

  $$TraducoesTableAnnotationComposer get traducaoId {
    final $$TraducoesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.traducaoId,
        referencedTable: $db.traducoes,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TraducoesTableAnnotationComposer(
              $db: $db,
              $table: $db.traducoes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$LivrosTableAnnotationComposer get livroId {
    final $$LivrosTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.livroId,
        referencedTable: $db.livros,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LivrosTableAnnotationComposer(
              $db: $db,
              $table: $db.livros,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$VersiculosTableTableManager extends RootTableManager<
    _$AppDatabase,
    $VersiculosTable,
    Versiculo,
    $$VersiculosTableFilterComposer,
    $$VersiculosTableOrderingComposer,
    $$VersiculosTableAnnotationComposer,
    $$VersiculosTableCreateCompanionBuilder,
    $$VersiculosTableUpdateCompanionBuilder,
    (Versiculo, $$VersiculosTableReferences),
    Versiculo,
    PrefetchHooks Function({bool traducaoId, bool livroId})> {
  $$VersiculosTableTableManager(_$AppDatabase db, $VersiculosTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VersiculosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VersiculosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VersiculosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> traducaoId = const Value.absent(),
            Value<String> livroId = const Value.absent(),
            Value<int> capitulo = const Value.absent(),
            Value<int> numeroVersiculo = const Value.absent(),
            Value<String> texto = const Value.absent(),
          }) =>
              VersiculosCompanion(
            id: id,
            traducaoId: traducaoId,
            livroId: livroId,
            capitulo: capitulo,
            numeroVersiculo: numeroVersiculo,
            texto: texto,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String traducaoId,
            required String livroId,
            required int capitulo,
            required int numeroVersiculo,
            required String texto,
          }) =>
              VersiculosCompanion.insert(
            id: id,
            traducaoId: traducaoId,
            livroId: livroId,
            capitulo: capitulo,
            numeroVersiculo: numeroVersiculo,
            texto: texto,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$VersiculosTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({traducaoId = false, livroId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (traducaoId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.traducaoId,
                    referencedTable:
                        $$VersiculosTableReferences._traducaoIdTable(db),
                    referencedColumn:
                        $$VersiculosTableReferences._traducaoIdTable(db).id,
                  ) as T;
                }
                if (livroId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.livroId,
                    referencedTable:
                        $$VersiculosTableReferences._livroIdTable(db),
                    referencedColumn:
                        $$VersiculosTableReferences._livroIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$VersiculosTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $VersiculosTable,
    Versiculo,
    $$VersiculosTableFilterComposer,
    $$VersiculosTableOrderingComposer,
    $$VersiculosTableAnnotationComposer,
    $$VersiculosTableCreateCompanionBuilder,
    $$VersiculosTableUpdateCompanionBuilder,
    (Versiculo, $$VersiculosTableReferences),
    Versiculo,
    PrefetchHooks Function({bool traducaoId, bool livroId})>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$TraducoesTableTableManager get traducoes =>
      $$TraducoesTableTableManager(_db, _db.traducoes);
  $$LivrosTableTableManager get livros =>
      $$LivrosTableTableManager(_db, _db.livros);
  $$VersiculosTableTableManager get versiculos =>
      $$VersiculosTableTableManager(_db, _db.versiculos);
}
