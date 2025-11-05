// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SyncStore on _SyncStore, Store {
  Computed<double>? _$progressPercentComputed;

  @override
  double get progressPercent => (_$progressPercentComputed ??= Computed<double>(
          () => super.progressPercent,
          name: '_SyncStore.progressPercent'))
      .value;

  late final _$statusAtom = Atom(name: '_SyncStore.status', context: context);

  @override
  SyncStatus get status {
    _$statusAtom.reportRead();
    return super.status;
  }

  @override
  set status(SyncStatus value) {
    _$statusAtom.reportWrite(value, super.status, () {
      super.status = value;
    });
  }

  late final _$currentBibleIdAtom =
      Atom(name: '_SyncStore.currentBibleId', context: context);

  @override
  String? get currentBibleId {
    _$currentBibleIdAtom.reportRead();
    return super.currentBibleId;
  }

  @override
  set currentBibleId(String? value) {
    _$currentBibleIdAtom.reportWrite(value, super.currentBibleId, () {
      super.currentBibleId = value;
    });
  }

  late final _$totalChaptersAtom =
      Atom(name: '_SyncStore.totalChapters', context: context);

  @override
  int get totalChapters {
    _$totalChaptersAtom.reportRead();
    return super.totalChapters;
  }

  @override
  set totalChapters(int value) {
    _$totalChaptersAtom.reportWrite(value, super.totalChapters, () {
      super.totalChapters = value;
    });
  }

  late final _$completedChaptersAtom =
      Atom(name: '_SyncStore.completedChapters', context: context);

  @override
  int get completedChapters {
    _$completedChaptersAtom.reportRead();
    return super.completedChapters;
  }

  @override
  set completedChapters(int value) {
    _$completedChaptersAtom.reportWrite(value, super.completedChapters, () {
      super.completedChapters = value;
    });
  }

  late final _$pausedAtom = Atom(name: '_SyncStore.paused', context: context);

  @override
  bool get paused {
    _$pausedAtom.reportRead();
    return super.paused;
  }

  @override
  set paused(bool value) {
    _$pausedAtom.reportWrite(value, super.paused, () {
      super.paused = value;
    });
  }

  late final _$errorMessageAtom =
      Atom(name: '_SyncStore.errorMessage', context: context);

  @override
  String? get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String? value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$_SyncStoreActionController =
      ActionController(name: '_SyncStore', context: context);

  @override
  void start(String bibleId, int total) {
    final _$actionInfo =
        _$_SyncStoreActionController.startAction(name: '_SyncStore.start');
    try {
      return super.start(bibleId, total);
    } finally {
      _$_SyncStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setTotal(int total) {
    final _$actionInfo =
        _$_SyncStoreActionController.startAction(name: '_SyncStore.setTotal');
    try {
      return super.setTotal(total);
    } finally {
      _$_SyncStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void incrementCompleted() {
    final _$actionInfo = _$_SyncStoreActionController.startAction(
        name: '_SyncStore.incrementCompleted');
    try {
      return super.incrementCompleted();
    } finally {
      _$_SyncStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPaused(bool value) {
    final _$actionInfo =
        _$_SyncStoreActionController.startAction(name: '_SyncStore.setPaused');
    try {
      return super.setPaused(value);
    } finally {
      _$_SyncStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCompleted() {
    final _$actionInfo = _$_SyncStoreActionController.startAction(
        name: '_SyncStore.setCompleted');
    try {
      return super.setCompleted();
    } finally {
      _$_SyncStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setError(String message) {
    final _$actionInfo =
        _$_SyncStoreActionController.startAction(name: '_SyncStore.setError');
    try {
      return super.setError(message);
    } finally {
      _$_SyncStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void reset() {
    final _$actionInfo =
        _$_SyncStoreActionController.startAction(name: '_SyncStore.reset');
    try {
      return super.reset();
    } finally {
      _$_SyncStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
status: ${status},
currentBibleId: ${currentBibleId},
totalChapters: ${totalChapters},
completedChapters: ${completedChapters},
paused: ${paused},
errorMessage: ${errorMessage},
progressPercent: ${progressPercent}
    ''';
  }
}
