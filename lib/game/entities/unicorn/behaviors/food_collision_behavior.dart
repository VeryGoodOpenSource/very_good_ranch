import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flutter/widgets.dart';
import 'package:ranch_components/ranch_components.dart';
import 'package:very_good_ranch/game/entities/entities.dart';
import 'package:very_good_ranch/game/entities/unicorn/behaviors/behaviors.dart';

class FoodCollisionBehavior extends CollisionBehavior<Food, Unicorn> {
  static const double positiveImpactOnEnjoyment = 0.3;
  static const double negativeImpactOnEnjoyment = -0.1;

  @override
  void onCollision(Set<Vector2> intersectionPoints, Food other) {
    if (other.beingDragged || !other.wasDragged) {
      return;
    }
    if (parent.hasBehavior<LeavingBehavior>() &&
        parent.findBehavior<LeavingBehavior>().isLeaving == true) {
      return;
    }
    _feedTheUnicorn(other.type);
    other.removeFromParent();
  }

  void _feedTheUnicorn(FoodType foodType) {
    final currentStage = parent.currentStage;

    final fullnessFeedFactor = currentStage.fullnessFeedFactor;
    parent.findBehavior<FullnessBehavior>().increaseBy(fullnessFeedFactor);

    final preferredFoodType = currentStage.preferredFoodType;
    final impactOnEnjoyment = preferredFoodType == foodType
        ? positiveImpactOnEnjoyment
        : negativeImpactOnEnjoyment;

    parent.findBehavior<EnjoymentBehavior>().increaseBy(impactOnEnjoyment);
    parent.timesFed++;
  }
}

@visibleForTesting
extension PreferredFoodType on UnicornStage {
  FoodType get preferredFoodType {
    switch (this) {
      case UnicornStage.baby:
        return FoodType.cake;
      case UnicornStage.child:
        return FoodType.lollipop;
      case UnicornStage.teen:
        return FoodType.iceCream;
      case UnicornStage.adult:
        return FoodType.pancake;
    }
  }

  /// How much of Unicorns fullness factor will be restored each time the
  /// unicorn is fed.
  double get fullnessFeedFactor {
    switch (this) {
      case UnicornStage.baby:
        return 0.3;
      case UnicornStage.child:
        return 0.25;
      case UnicornStage.teen:
        return 0.2;
      case UnicornStage.adult:
        return 0.15;
    }
  }
}
