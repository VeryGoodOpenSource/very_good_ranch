import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:very_good_ranch/game/bloc/blessing/blessing_bloc.dart';
import 'package:very_good_ranch/game/entities/entities.dart';

class EvolvingBehavior extends Behavior<Unicorn>
    with FlameBlocReader<BlessingBloc, BlessingState> {
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

    bloc.add(UnicornEvolved(nextEvolutionStage));
  }

  bool get shouldEvolve {
    if (parent.evolutionStage == UnicornEvolutionStage.adult) {
      return false;
    }
    return parent.timesFed >= timesThatMustBeFed &&
        parent.happiness >= happinessThresholdToEvolve;
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
