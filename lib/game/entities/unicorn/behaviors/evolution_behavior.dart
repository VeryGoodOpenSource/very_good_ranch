import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flutter/foundation.dart';
import 'package:very_good_ranch/game/entities/entities.dart';
import 'package:very_good_ranch/game/entities/unicorn/stages.dart';

class EvolutionBehavior extends Behavior<Unicorn> {
  factory EvolutionBehavior() {
    return EvolutionBehavior.withInitialStage(BabyUnicornStage());
  }

  @visibleForTesting
  EvolutionBehavior.withInitialStage(this._currentStage);

  UnicornStage get currentStage => _currentStage;
  UnicornStage _currentStage;

  @override
  void update(double dt) {
    if (currentStage is AdultUnicornStage) {
      return;
    }

    if (!currentStage.shouldEvolve) {
      return;
    }

    final newStage = currentStage.evolve();
    _currentStage = newStage;
  }
}
