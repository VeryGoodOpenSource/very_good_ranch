import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flutter/widgets.dart';
import 'package:ranch_components/ranch_components.dart';
import 'package:very_good_ranch/game/entities/entities.dart';

class FoodCollisionBehavior extends CollisionBehavior<Food, Unicorn> {
  static const double positiveImpactOnEnjoyment = 0.3;
  static const double negativeImpactOnEnjoyment = -0.1;

  @override
  void onCollision(Set<Vector2> intersectionPoints, Food other) {
    if (other.beingDragged || !other.wasDragged) {
      return;
    }
    if (parent.isLeaving == true) {
      return;
    }
    _feedTheUnicorn(other.type);
    other.removeFromParent();
  }

  void _feedTheUnicorn(FoodType foodType) {
    final currentStage = parent.evolutionStage;

    final fullnessFeedFactor = currentStage.fullnessFeedFactor;
    parent.fullness.increaseBy(fullnessFeedFactor);

    final preferredFoodType = currentStage.preferredFoodType;
    final impactOnEnjoyment = preferredFoodType == foodType
        ? positiveImpactOnEnjoyment
        : negativeImpactOnEnjoyment;

    parent.enjoyment.increaseBy(impactOnEnjoyment);
    parent.timesFed++;
  }
}

@visibleForTesting
extension PreferredFoodType on UnicornEvolutionStage {
  FoodType get preferredFoodType {
    switch (this) {
      case UnicornEvolutionStage.baby:
        return FoodType.cake;
      case UnicornEvolutionStage.child:
        return FoodType.lollipop;
      case UnicornEvolutionStage.teen:
        return FoodType.iceCream;
      case UnicornEvolutionStage.adult:
        return FoodType.pancake;
    }
  }

  /// How much of Unicorns fullness factor will be restored each time the
  /// unicorn is fed.
  double get fullnessFeedFactor {
    switch (this) {
      case UnicornEvolutionStage.baby:
        return 0.3;
      case UnicornEvolutionStage.child:
        return 0.25;
      case UnicornEvolutionStage.teen:
        return 0.2;
      case UnicornEvolutionStage.adult:
        return 0.15;
    }
  }
}
