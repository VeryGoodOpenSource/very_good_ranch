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
          size: type.size,
          children: [
            FoodComponent.ofType(type),
            RectangleHitbox(),
          ],
          behaviors: [
            DraggingBehavior(),
            DespawnBehavior(despawnTime: despawnTime),
            MoveToInventoryBehavior(),
          ],
        );

  /// Creates a Food without any behaviors.
  ///
  /// This can be used for testing each behavior of a food.
  @visibleForTesting
  Food.test({
    this.type = FoodType.cake,
    super.behaviors,
  }) : super(
          size: type.size,
          children: [
            FoodComponent.ofType(type),
          ],
        );

  /// {@macro food_component}
  ///
  /// Constructs a cake.
  Food.cake({
    required Vector2 position,
  }) : this(
          position: position,
          type: FoodType.cake,
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
  bool get beingDragged => findBehavior<DraggingBehavior>().beingDragged;

  /// Indicates if the food was dragged before.
  bool get wasDragged => findBehavior<DraggingBehavior>().wasDragged;

  /// The type of food.
  final FoodType type;
}
