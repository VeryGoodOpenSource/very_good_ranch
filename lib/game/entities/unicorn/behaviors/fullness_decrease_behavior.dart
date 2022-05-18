import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:very_good_ranch/game/entities/entities.dart';

import 'package:very_good_ranch/game/entities/unicorn/behaviors/evolution_behavior.dart';

class FullnessDecreaseBehavior extends Behavior<Unicorn> {
  static double decreaseInterval = 7;

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

  // Todo(renancaraujo): Confirm logic: fullness decreases linearly. We may
  // change this rule to vary according to the unicorn stage.
  void _decreaseFullness() {
    parent.fullnessFactor -= parent.currentStage.fullnessDecreaseFactor;
  }
}

extension on UnicornStage {
  // Todo(renancaraujo): Confirm logic: As older unicorn gets, more food it
  // needs (?)
  double get fullnessDecreaseFactor {
    switch (this) {
      case UnicornStage.baby:
        return 0.1;
      case UnicornStage.kid:
        return 0.1;
      case UnicornStage.teenager:
        return 0.2;
      case UnicornStage.adult:
        return 0.3;
    }
  }
}
