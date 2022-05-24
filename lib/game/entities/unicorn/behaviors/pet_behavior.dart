import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flutter/widgets.dart';
import 'package:very_good_ranch/game/entities/entities.dart';

class PetBehavior extends Behavior<Unicorn> with Tappable {
  static const Duration petThrottleDuration = Duration(seconds: 1);

  bool _throttling = false;

  @override
  bool onTapDown(TapDownInfo info) {
    if (_throttling == false) {
      _increaseEnjoyment();
      return true;
    }
    return false;
  }

  void _increaseEnjoyment() {
    parent.enjoymentFactor += parent.currentStage.petEnjoymentIncrease;
    _throttling = true;
    Future<void>.delayed(petThrottleDuration).then((_) => _throttling = false);
  }

  @override
  bool containsPoint(Vector2 point) {
    return parent.containsPoint(point);
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
