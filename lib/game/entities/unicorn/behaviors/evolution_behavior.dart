import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flutter/foundation.dart';
import 'package:very_good_ranch/game/entities/entities.dart';
import 'package:very_good_ranch/game/entities/unicorn/behaviors/behaviors.dart';

class EvolutionBehavior extends Behavior<Unicorn> {
  factory EvolutionBehavior() {
    return EvolutionBehavior.withInitialStage(UnicornStage.baby);
  }

  @visibleForTesting
  EvolutionBehavior.withInitialStage(this._currentStage);

  static const double happinessThresholdToEvolve = 0.9;
  static const int timesThatMustBeFed = 4;

  UnicornStage get currentStage => _currentStage;
  UnicornStage _currentStage;

  @override
  void update(double dt) {
    if (!shouldEvolve) {
      return;
    }
    final nextStage = getNextStage();
    _currentStage = nextStage;

    parent.findBehavior<FullnessBehavior>()?.reset();
    parent.findBehavior<EnjoymentBehavior>()?.reset();
  }

  bool get shouldEvolve {
    if (currentStage == UnicornStage.adult) {
      return false;
    }
    return parent.timesFed >= timesThatMustBeFed &&
        parent.happinessFactor >= happinessThresholdToEvolve;
  }

  UnicornStage getNextStage() {
    final currentStage = this.currentStage;
    if (currentStage == UnicornStage.baby) {
      return UnicornStage.kid;
    }
    if (currentStage == UnicornStage.kid) {
      return UnicornStage.teenager;
    }
    if (currentStage == UnicornStage.teenager) {
      return UnicornStage.adult;
    }
    return currentStage;
  }
}
