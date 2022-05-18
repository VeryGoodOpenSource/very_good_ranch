import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:very_good_ranch/game/entities/unicorn/behaviors/behaviors.dart';
import 'package:very_good_ranch/game/entities/unicorn/unicorn.dart';

class EnjoymentDecreaseBehavior extends Behavior<Unicorn> {
  static double decreaseInterval = 8;

  @override
  Future<void> onLoad() async {
    await add(
      TimerComponent(
        period: decreaseInterval,
        repeat: true,
        onTick: _decreaseEnjoyment,
      ),
    );
  }

  // Todo(renancaraujo): Confirm logic: enjoyment decreases linearly. We may
  //  change this rule to vary according to the unicorn stage.
  void _decreaseEnjoyment() {
    final decreaseFactor = parent.currentStage.enjoymentDecreaseFactor;
    max(parent.enjoymentFactor -= decreaseFactor, 0);
  }
}

extension on UnicornStage {
  // Todo(renancaraujo): Confirm logic: As older unicorn gets, less pet it
  // needs (?)
  /// Percentage that of enjoyment lost every
  /// [EnjoymentDecreaseBehavior.decreaseInterval].
  double get enjoymentDecreaseFactor {
    switch (this) {
      case UnicornStage.baby:
        return 0.3;
      case UnicornStage.kid:
        return 0.2;
      case UnicornStage.teenager:
        return 0.1;
      case UnicornStage.adult:
        return 0.1;
    }
  }
}
