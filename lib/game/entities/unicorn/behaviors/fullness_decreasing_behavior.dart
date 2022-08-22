import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:very_good_ranch/game/entities/entities.dart';

class FullnessDecreasingBehavior extends Behavior<Unicorn> {
  static const double decreaseInterval = 7;

  @override
  Future<void> onLoad() async {
    await add(
      TimerComponent(
        period: decreaseInterval,
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
        return 0.1;
      case UnicornEvolutionStage.child:
        return 0.1;
      case UnicornEvolutionStage.teen:
        return 0.2;
      case UnicornEvolutionStage.adult:
        return 0.3;
    }
  }
}
