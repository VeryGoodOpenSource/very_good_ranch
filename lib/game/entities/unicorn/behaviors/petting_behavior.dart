import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flutter/widgets.dart';
import 'package:very_good_ranch/game/entities/entities.dart';

class PettingBehavior extends TappableBehavior<Unicorn> {
  static const petThrottleDuration = 1.0;

  late final TimerComponent _throttlingTimer;

  @override
  Future<void> onLoad() async {
    await add(
      _throttlingTimer = TimerComponent(
        period: petThrottleDuration,
        autoStart: false,
      ),
    );
  }

  @override
  bool onTapDown(TapDownInfo info) {
    if (info.handled || _throttlingTimer.timer.isRunning()) {
      return true;
    }

    _throttlingTimer.timer.start();

    parent.enjoyment.increaseBy(parent.evolutionStage.petEnjoymentIncrease);

    return false;
  }
}

@visibleForTesting
extension PetBehaviorIncreasePerStage on UnicornEvolutionStage {
  double get petEnjoymentIncrease {
    switch (this) {
      case UnicornEvolutionStage.baby:
        return 0.2;
      case UnicornEvolutionStage.child:
        return 0.16;
      case UnicornEvolutionStage.teen:
        return 0.13;
      case UnicornEvolutionStage.adult:
        return 0.1;
    }
  }
}
