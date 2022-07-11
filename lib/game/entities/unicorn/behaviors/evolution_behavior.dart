import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:very_good_ranch/game/entities/entities.dart';

class EvolutionBehavior extends Behavior<Unicorn> {
  static const double happinessThresholdToEvolve = 0.9;
  static const int timesThatMustBeFed = 4;

  @override
  void update(double dt) {
    if (!shouldEvolve) {
      return;
    }
    final nextStage = getNextStage();
    parent
      ..currentStage = nextStage
      ..reset();
  }

  bool get shouldEvolve {
    if (parent.currentStage == UnicornStage.adult) {
      return false;
    }
    return parent.timesFed >= timesThatMustBeFed &&
        parent.happinessFactor >= happinessThresholdToEvolve;
  }

  UnicornStage getNextStage() {
    final currentStage = parent.currentStage;
    if (currentStage == UnicornStage.baby) {
      return UnicornStage.child;
    }
    if (currentStage == UnicornStage.child) {
      return UnicornStage.teen;
    }
    if (currentStage == UnicornStage.teen) {
      return UnicornStage.adult;
    }
    return currentStage;
  }
}
