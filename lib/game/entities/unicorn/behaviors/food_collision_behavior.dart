import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:ranch_components/ranch_components.dart';
import 'package:very_good_ranch/game/entities/entities.dart';

class FoodCollisionBehavior extends CollisionBehavior<Food, Unicorn> {
  static const double positiveImpactOnEnjoyment = 0.3;
  static const double negativeImpactOnEnjoyment = -0.1;

  @override
  void onCollision(Set<Vector2> intersectionPoints, Food other) {
    if (other.beingDragged) {
      return;
    }
    _feedTheUnicorn(other.type);
    other.removeFromParent();
  }

  void _feedTheUnicorn(FoodType foodType) {
    final currentStage = parent.currentStage;

    final fullnessFeedFactor = currentStage.fullnessFeedFactor;
    parent.fullnessFactor += fullnessFeedFactor;

    final preferredFoodType = currentStage.preferredFoodType;
    final impactOnEnjoyment = preferredFoodType == foodType
        ? positiveImpactOnEnjoyment
        : negativeImpactOnEnjoyment;

    parent.enjoymentFactor += impactOnEnjoyment;
  }
}

extension on UnicornStage {
  FoodType get preferredFoodType {
    switch (this) {
      case UnicornStage.baby:
        return FoodType.candy;
      case UnicornStage.kid:
        return FoodType.lollipop;
      case UnicornStage.teenager:
        return FoodType.iceCream;
      case UnicornStage.adult:
        return FoodType.pancake;
    }
  }

  /// How much of [Unicorn.fullnessFactor] will be restored each time the
  /// unicorn is fed.
  double get fullnessFeedFactor {
    switch (this) {
      case UnicornStage.baby:
        return 0.3;
      case UnicornStage.kid:
        return 0.25;
      case UnicornStage.teenager:
        return 0.2;
      case UnicornStage.adult:
        return 0.15;
    }
  }
}
