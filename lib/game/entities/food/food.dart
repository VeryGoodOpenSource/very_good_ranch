import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:ranch_components/ranch_components.dart';
import 'package:very_good_ranch/game/entities/food/behaviors/draggable_behavior.dart';

class Food extends PositionComponent {
  Food({
    required Vector2 position,
    required this.saturation,
    required this.type,
  }) : super(
          position: position,
          size: Vector2.all(32),
          children: [
            FoodComponent(type: type),
            CircleHitbox(),
            DraggableBehavior(),
          ],
        );

  /// Creates a Food without any children.
  ///
  /// This can be used for testing each behavior of a food.
  @visibleForTesting
  Food.test({
    this.type = FoodType.candy,
    this.saturation = 0,
  }) : super(size: Vector2.all(32), children: [FoodComponent(type: type)]);

  /// {@macro food_component}
  ///
  /// Constructs a cupcake.
  Food.cupcake({
    required Vector2 position,
  }) : this(position: position, saturation: 2.5, type: FoodType.cupcake);

  /// {@macro food_component}
  ///
  /// Constructs a lollipop.
  Food.lollipop({
    required Vector2 position,
  }) : this(position: position, saturation: 1.5, type: FoodType.lollipop);

  /// {@macro food_component}
  ///
  /// Constructs a pancake.
  Food.pancake({
    required Vector2 position,
  }) : this(position: position, saturation: 3, type: FoodType.pancake);

  /// {@macro food_component}
  ///
  /// Constructs an ice cream.
  Food.iceCream({
    required Vector2 position,
  }) : this(position: position, saturation: 2, type: FoodType.iceCream);

  /// {@macro food_component}
  ///
  /// Constructs a candy.
  Food.candy({
    required Vector2 position,
  }) : this(position: position, saturation: 1, type: FoodType.candy);

  /// The amount of saturation the food provides.
  final double saturation;

  /// The type of food.
  final FoodType type;
}
