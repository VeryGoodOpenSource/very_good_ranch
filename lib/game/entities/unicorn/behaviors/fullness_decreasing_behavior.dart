import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:very_good_ranch/config.dart';
import 'package:very_good_ranch/game/entities/entities.dart';

class FullnessDecreasingBehavior extends Behavior<Unicorn> {
  @override
  Future<void> onLoad() async {
    await add(
      TimerComponent(
        period: Config.fullnessDecreaseInterval,
        repeat: true,
        onTick: _decreaseFullness,
      ),
    );
  }

  void _decreaseFullness() {
    parent.fullness.decreaseBy(parent.evolutionStage.fullnessDecreaseFactor);
  }
}

extension on UnicornEvolutionStage {
  double get fullnessDecreaseFactor {
    switch (this) {
      case UnicornEvolutionStage.baby:
        return Config.fullnessDecreaseFactor.baby;
      case UnicornEvolutionStage.child:
        return Config.fullnessDecreaseFactor.child;
      case UnicornEvolutionStage.teen:
        return Config.fullnessDecreaseFactor.teen;
      case UnicornEvolutionStage.adult:
        return Config.fullnessDecreaseFactor.adult;
    }
  }
}
