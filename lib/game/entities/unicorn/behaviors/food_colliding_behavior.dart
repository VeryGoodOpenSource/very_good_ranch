import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flutter/widgets.dart';
import 'package:ranch_components/ranch_components.dart';
import 'package:very_good_ranch/config.dart';
import 'package:very_good_ranch/game/entities/entities.dart';

class FoodCollidingBehavior extends CollisionBehavior<Food, Unicorn> {
  @override
  void onCollision(Set<Vector2> intersectionPoints, Food other) {
    if (other.beingDragged || !other.wasDragged || other.isRemoving) {
      return;
    }
    if (parent.isLeaving == true) {
      return;
    }
    parent.feed(other);
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
        return Config.fullnessFeedFactor.baby;
      case UnicornEvolutionStage.child:
        return Config.fullnessFeedFactor.child;
      case UnicornEvolutionStage.teen:
        return Config.fullnessFeedFactor.teen;
      case UnicornEvolutionStage.adult:
        return Config.fullnessFeedFactor.adult;
    }
  }
}
