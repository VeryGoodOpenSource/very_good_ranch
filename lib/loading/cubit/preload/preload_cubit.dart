import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:ranch_components/ranch_components.dart';
import 'package:ranch_flame/ranch_flame.dart';
import 'package:very_good_ranch/game/components/components.dart';
import 'package:very_good_ranch/loading/loading.dart';

class PreloadCubit extends Cubit<PreloadState> {
  PreloadCubit(this.images) : super(const PreloadState.initial());

  final UnprefixedImages images;

  /// Load items sequentially allows display of what is being loaded
  Future<void> loadSequentially() async {
    final phases = <PreloadPhase>[
      PreloadPhase('counter', () => UnicornCounter.preloadAssets(images)),
      PreloadPhase(
        'environment',
        () => BackgroundComponent.preloadAssets(images),
      ),
      PreloadPhase('food', () => FoodComponent.preloadAssets(images)),
      PreloadPhase('unicorns', () => UnicornComponent.preloadAssets(images)),
    ];
    emit(state.startLoading(phases.length));
    for (final phase in phases) {
      emit(state.onStartPhase(phase.label));
      // Throttle phases to take at least 1/5 seconds
      await Future.wait([
        Future.delayed(Duration.zero, phase.start),
        Future<void>.delayed(const Duration(milliseconds: 200)),
      ]);
      emit(state.onFinishPhase());
    }
  }
}

@immutable
class PreloadPhase {
  const PreloadPhase(this.label, this.start);

  final String label;
  final ValueGetter<Future<void>> start;
}
