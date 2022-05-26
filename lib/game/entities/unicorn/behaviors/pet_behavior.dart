import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flutter/widgets.dart';
import 'package:very_good_ranch/game/entities/entities.dart';

class PetBehavior extends TappableBehavior<Unicorn> {
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
    if (info.handled || !_throttlingTimer.timer.isRunning()) {
      _throttlingTimer.timer.start();
      parent.enjoymentFactor += parent.currentStage.petEnjoymentIncrease;
      return false;
    }
    return true;
  }
}

@visibleForTesting
extension PetBehaviorIncreasePerStage on UnicornStage {
  double get petEnjoymentIncrease {
    switch (this) {
      case UnicornStage.baby:
        return 0.2;
      case UnicornStage.kid:
        return 0.16;
      case UnicornStage.teenager:
        return 0.13;
      case UnicornStage.adult:
        return 0.1;
    }
  }
}
