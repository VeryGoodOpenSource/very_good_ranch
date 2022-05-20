import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flutter/material.dart';
import 'package:ranch_components/ranch_components.dart';
import 'package:very_good_ranch/game/entities/food/behaviors/behaviors.dart';

class Food extends Entity {
  Food({
    required super.position,
    required this.type,
    required double despawnTime,
  }) : super(
          size: Vector2.all(32),
          children: [
            FoodComponent(type: type),
            CircleHitbox(),
          ],
          behaviors: [
            DraggableBehavior(),
            DespawnBehavior(despawnTime: despawnTime),
          ],
        );

  /// Creates a Food without any behaviors.
  ///
  /// This can be used for testing each behavior of a food.
  @visibleForTesting
  Food.test({
    this.type = FoodType.candy,
    super.behaviors,
  }) : super(size: Vector2.all(32), children: [FoodComponent(type: type)]);

  /// {@macro food_component}
  ///
  /// Constructs a candy.
  Food.candy({
    required Vector2 position,
  }) : this(
          position: position,
          type: FoodType.candy,
          despawnTime: 60,
        );

  /// {@macro food_component}
  ///
  /// Constructs a lollipop.
  Food.lollipop({
    required Vector2 position,
  }) : this(
          position: position,
          type: FoodType.lollipop,
          despawnTime: 40,
        );

  /// {@macro food_component}
  ///
  /// Constructs a pancake.
  Food.pancake({
    required Vector2 position,
  }) : this(
          position: position,
          type: FoodType.pancake,
          despawnTime: 20,
        );

  /// {@macro food_component}
  ///
  /// Constructs an ice cream.
  Food.iceCream({
    required Vector2 position,
  }) : this(
          position: position,
          type: FoodType.iceCream,
          despawnTime: 10,
        );

  /// The amount of nutrition the food provides.
  double get nutrition => type.nutrition;

  /// Indicates if the food is currently being dragged.
  bool get beingDragged =>
      findBehavior<DraggableBehavior>()!.beingDragged == true;

  /// The type of food.
  final FoodType type;
}
