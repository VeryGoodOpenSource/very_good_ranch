import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flutter/material.dart';
import 'package:ranch_components/ranch_components.dart';
import 'package:very_good_ranch/game/entities/food/behaviors/behaviors.dart';

class Food extends Entity {
  Food({
    required super.position,
    required this.nutrition,
    required this.type,
  }) : super(
          size: Vector2.all(32),
          children: [
            FoodComponent(type: type),
            CircleHitbox(),
          ],
          behaviors: [
            DraggableBehavior(),
          ],
        );

  /// Creates a Food without any behaviors.
  ///
  /// This can be used for testing each behavior of a food.
  @visibleForTesting
  Food.test({
    this.type = FoodType.candy,
    this.nutrition = 0,
    super.behaviors,
  }) : super(size: Vector2.all(32), children: [FoodComponent(type: type)]);

  /// {@macro food_component}
  ///
  /// Constructs a cupcake.
  Food.cupcake({
    required Vector2 position,
  }) : this(position: position, nutrition: 2.5, type: FoodType.cupcake);

  /// {@macro food_component}
  ///
  /// Constructs a lollipop.
  Food.lollipop({
    required Vector2 position,
  }) : this(position: position, nutrition: 1.5, type: FoodType.lollipop);

  /// {@macro food_component}
  ///
  /// Constructs a pancake.
  Food.pancake({
    required Vector2 position,
  }) : this(position: position, nutrition: 3, type: FoodType.pancake);

  /// {@macro food_component}
  ///
  /// Constructs an ice cream.
  Food.iceCream({
    required Vector2 position,
  }) : this(position: position, nutrition: 2, type: FoodType.iceCream);

  /// {@macro food_component}
  ///
  /// Constructs a candy.
  Food.candy({
    required Vector2 position,
  }) : this(position: position, nutrition: 1, type: FoodType.candy);

  /// The amount of nutrition the food provides.
  final double nutrition;

  /// The type of food.
  final FoodType type;
}
