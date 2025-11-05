// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bible_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$BibleStore on _BibleStore, Store {
  late final _$initializedAtom =
      Atom(name: '_BibleStore.initialized', context: context);

  @override
  bool get initialized {
    _$initializedAtom.reportRead();
    return super.initialized;
  }

  @override
  set initialized(bool value) {
    _$initializedAtom.reportWrite(value, super.initialized, () {
      super.initialized = value;
    });
  }

  late final _$_BibleStoreActionController =
      ActionController(name: '_BibleStore', context: context);

  @override
  void markInitialized() {
    final _$actionInfo = _$_BibleStoreActionController.startAction(
        name: '_BibleStore.markInitialized');
    try {
      return super.markInitialized();
    } finally {
      _$_BibleStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
initialized: ${initialized}
    ''';
  }
}
