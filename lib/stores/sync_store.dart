import 'package:mobx/mobx.dart';

part 'sync_store.g.dart';

enum SyncStatus { idle, downloading, paused, completed, error }

class SyncStore = _SyncStore with Store;

abstract class _SyncStore with Store {
  @observable
  SyncStatus status = SyncStatus.idle;

  @observable
  String? currentBibleId;

  @observable
  int totalChapters = 0;

  @observable
  int completedChapters = 0;

  @observable
  bool paused = false;

  @observable
  String? errorMessage;

  @computed
  double get progressPercent => totalChapters == 0
      ? 0
      : (completedChapters / totalChapters).clamp(0, 1);

  @action
  void start(String bibleId, int total) {
    currentBibleId = bibleId;
    totalChapters = total;
    completedChapters = 0;
    paused = false;
    errorMessage = null;
    status = SyncStatus.downloading;
  }

  @action
  void setTotal(int total) {
    totalChapters = total;
  }

  @action
  void incrementCompleted() {
    completedChapters++;
  }

  @action
  void setPaused(bool value) {
    paused = value;
    status = value ? SyncStatus.paused : SyncStatus.downloading;
  }

  @action
  void setCompleted() {
    status = SyncStatus.completed;
  }

  @action
  void setError(String message) {
    errorMessage = message;
    status = SyncStatus.error;
  }

  @action
  void reset() {
    status = SyncStatus.idle;
    currentBibleId = null;
    totalChapters = 0;
    completedChapters = 0;
    paused = false;
    errorMessage = null;
  }
}