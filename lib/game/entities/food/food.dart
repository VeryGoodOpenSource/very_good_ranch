import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flutter/material.dart';
import 'package:ranch_components/ranch_components.dart';
import 'package:very_good_ranch/config.dart';
import 'package:very_good_ranch/game/behaviors/behaviors.dart';
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
            DespawningBehavior(despawnTime: despawnTime),
            PositionalPriorityBehavior(anchor: Anchor.bottomCenter),
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
          despawnTime: Config.cakeDespawnTime,
        );

  /// {@macro food_component}
  ///
  /// Constructs a lollipop.
  Food.lollipop({
    required Vector2 position,
  }) : this(
          position: position,
          type: FoodType.lollipop,
          despawnTime: Config.lollipopDespawnTime,
        );

  /// {@macro food_component}
  ///
  /// Constructs an ice cream.
  Food.iceCream({
    required Vector2 position,
  }) : this(
          position: position,
          type: FoodType.iceCream,
          despawnTime: Config.iceCreamDespawnTime,
        );

  /// {@macro food_component}
  ///
  /// Constructs a pancake.
  Food.pancake({
    required Vector2 position,
  }) : this(
          position: position,
          type: FoodType.pancake,
          despawnTime: Config.pancakeDespawnTime,
        );

  /// The amount of nutrition the food provides.
  double get nutrition => type.nutrition;

  /// Indicates if the food is currently being dragged.
  bool beingDragged = false;

  /// Indicates if the food was dragged before.
  bool wasDragged = false;

  int? overridePriority;

  @override
  int get priority => overridePriority ?? super.priority;

  /// The type of food.
  final FoodType type;
}
