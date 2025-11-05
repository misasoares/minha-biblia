// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reader_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ReaderStore on _ReaderStore, Store {
  Computed<bool>? _$hasSelectionComputed;

  @override
  bool get hasSelection =>
      (_$hasSelectionComputed ??= Computed<bool>(() => super.hasSelection,
              name: '_ReaderStore.hasSelection'))
          .value;

  late final _$traducaoIdAtom =
      Atom(name: '_ReaderStore.traducaoId', context: context);

  @override
  String? get traducaoId {
    _$traducaoIdAtom.reportRead();
    return super.traducaoId;
  }

  @override
  set traducaoId(String? value) {
    _$traducaoIdAtom.reportWrite(value, super.traducaoId, () {
      super.traducaoId = value;
    });
  }

  late final _$livroIdAtom =
      Atom(name: '_ReaderStore.livroId', context: context);

  @override
  String? get livroId {
    _$livroIdAtom.reportRead();
    return super.livroId;
  }

  @override
  set livroId(String? value) {
    _$livroIdAtom.reportWrite(value, super.livroId, () {
      super.livroId = value;
    });
  }

  late final _$capituloAtom =
      Atom(name: '_ReaderStore.capitulo', context: context);

  @override
  int? get capitulo {
    _$capituloAtom.reportRead();
    return super.capitulo;
  }

  @override
  set capitulo(int? value) {
    _$capituloAtom.reportWrite(value, super.capitulo, () {
      super.capitulo = value;
    });
  }

  late final _$versesFutureAtom =
      Atom(name: '_ReaderStore.versesFuture', context: context);

  @override
  ObservableFuture<List<dynamic>>? get versesFuture {
    _$versesFutureAtom.reportRead();
    return super.versesFuture;
  }

  @override
  set versesFuture(ObservableFuture<List<dynamic>>? value) {
    _$versesFutureAtom.reportWrite(value, super.versesFuture, () {
      super.versesFuture = value;
    });
  }

  late final _$booksAtom = Atom(name: '_ReaderStore.books', context: context);

  @override
  List<dynamic> get books {
    _$booksAtom.reportRead();
    return super.books;
  }

  @override
  set books(List<dynamic> value) {
    _$booksAtom.reportWrite(value, super.books, () {
      super.books = value;
    });
  }

  late final _$chaptersAtom =
      Atom(name: '_ReaderStore.chapters', context: context);

  @override
  List<int> get chapters {
    _$chaptersAtom.reportRead();
    return super.chapters;
  }

  @override
  set chapters(List<int> value) {
    _$chaptersAtom.reportWrite(value, super.chapters, () {
      super.chapters = value;
    });
  }

  late final _$setSelectionAsyncAction =
      AsyncAction('_ReaderStore.setSelection', context: context);

  @override
  Future<void> setSelection(String livro, int chapter) {
    return _$setSelectionAsyncAction
        .run(() => super.setSelection(livro, chapter));
  }

  late final _$ensureInitialSelectionForTranslationAsyncAction = AsyncAction(
      '_ReaderStore.ensureInitialSelectionForTranslation',
      context: context);

  @override
  Future<void> ensureInitialSelectionForTranslation() {
    return _$ensureInitialSelectionForTranslationAsyncAction
        .run(() => super.ensureInitialSelectionForTranslation());
  }

  late final _$_loadAsyncAction =
      AsyncAction('_ReaderStore._load', context: context);

  @override
  Future<void> _load() {
    return _$_loadAsyncAction.run(() => super._load());
  }

  late final _$loadBooksForTranslationAsyncAction =
      AsyncAction('_ReaderStore.loadBooksForTranslation', context: context);

  @override
  Future<void> loadBooksForTranslation() {
    return _$loadBooksForTranslationAsyncAction
        .run(() => super.loadBooksForTranslation());
  }

  late final _$loadChaptersForBookAsyncAction =
      AsyncAction('_ReaderStore.loadChaptersForBook', context: context);

  @override
  Future<void> loadChaptersForBook(String livro) {
    return _$loadChaptersForBookAsyncAction
        .run(() => super.loadChaptersForBook(livro));
  }

  late final _$_ReaderStoreActionController =
      ActionController(name: '_ReaderStore', context: context);

  @override
  void setTranslation(String id) {
    final _$actionInfo = _$_ReaderStoreActionController.startAction(
        name: '_ReaderStore.setTranslation');
    try {
      return super.setTranslation(id);
    } finally {
      _$_ReaderStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
traducaoId: ${traducaoId},
livroId: ${livroId},
capitulo: ${capitulo},
versesFuture: ${versesFuture},
books: ${books},
chapters: ${chapters},
hasSelection: ${hasSelection}
    ''';
  }
}
