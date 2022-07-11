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
    final nextEvolutionStage = getNextEvolutionStage();
    parent
      ..evolutionStage = nextEvolutionStage
      ..reset();
  }

  bool get shouldEvolve {
    if (parent.evolutionStage == UnicornEvolutionStage.adult) {
      return false;
    }
    return parent.timesFed >= timesThatMustBeFed &&
        parent.happinessFactor >= happinessThresholdToEvolve;
  }

  UnicornEvolutionStage getNextEvolutionStage() {
    final currentEvolutionStage = parent.evolutionStage;
    if (currentEvolutionStage == UnicornEvolutionStage.baby) {
      return UnicornEvolutionStage.child;
    }
    if (currentEvolutionStage == UnicornEvolutionStage.child) {
      return UnicornEvolutionStage.teen;
    }
    if (currentEvolutionStage == UnicornEvolutionStage.teen) {
      return UnicornEvolutionStage.adult;
    }
    return currentEvolutionStage;
  }
}
