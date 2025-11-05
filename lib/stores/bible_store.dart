import 'package:mobx/mobx.dart';

part 'bible_store.g.dart';

class BibleStore = _BibleStore with Store;

abstract class _BibleStore with Store {
  @observable
  bool initialized = false;

  @action
  void markInitialized() {
    initialized = true;
  }
}