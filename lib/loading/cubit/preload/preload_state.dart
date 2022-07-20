import 'package:equatable/equatable.dart';

class PreloadState extends Equatable {
  const PreloadState.initial()
      : totalCount = 0,
        loadedCount = 0,
        currentLabel = '';

  const PreloadState._update(
    this.loadedCount,
    this.currentLabel,
    this.totalCount,
  );

  final int totalCount;
  final int loadedCount;
  final String currentLabel;

  double get progress => totalCount == 0 ? 0 : loadedCount / totalCount;

  bool get isLoaded => progress == 1.0;

  PreloadState startLoading(int totalCount) {
    return PreloadState._update(0, '', totalCount);
  }

  PreloadState onStartPhase(String label) {
    return PreloadState._update(
      loadedCount,
      label,
      totalCount,
    );
  }

  PreloadState onFinishPhase(Future<void> resolvedFuture) {
    return PreloadState._update(
      loadedCount + 1,
      currentLabel,
      totalCount,
    );
  }

  @override
  List<Object?> get props => [
        totalCount,
        loadedCount,
        currentLabel,
      ];
}
