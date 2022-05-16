import 'dart:ui';

import 'package:flame/components.dart';

/// Type of food.
enum FoodType {
  /// Candy type.
  candy(
    nutrition: 1,
    rarity: 40,
  ),

  /// Lollipop type.
  lollipop(
    nutrition: 2,
    rarity: 30,
  ),

  /// Pancake type.
  pancake(
    nutrition: 3,
    rarity: 20,
  ),

  /// Ice cream type.
  iceCream(
    nutrition: 4,
    rarity: 10,
  );

  /// Food enum constructor.
  const FoodType({required this.nutrition, required this.rarity});

  /// The nutrition value of the food.
  final double nutrition;

  /// The rarity of the food.
  final int rarity;
}

/// {@template food_component}
/// A component that represents a food.
/// {@endtemplate}
class FoodComponent extends PositionComponent {
  /// {@macro food_component}
  FoodComponent({
    required this.type,
  }) : super(size: Vector2.all(32));

  /// The type of food.
  final FoodType type;

  /// The paint used to render the food.
  ///
  /// NOTE: This is a temporary solution until there are assets for each food
  /// type.
  late Paint paint;

  /// The radius of visual food representation.
  ///
  /// NOTE: This is a temporary solution until there are assets for each food
  /// type.
  late double radius;

  @override
  Future<void> onLoad() async {
    radius = size.x / 2;
    paint = Paint();
    switch (type) {
      case FoodType.lollipop:
        paint.color = const Color(0xFF3B93FF);
        break;
      case FoodType.pancake:
        paint.color = const Color(0xFFCED352);
        break;
      case FoodType.iceCream:
        paint.color = const Color(0xFFE9E9E9);
        break;
      case FoodType.candy:
        paint.color = const Color(0xFFF707FF);
        break;
    }
  }

  @override
  void render(Canvas canvas) {
    canvas.drawCircle(Offset(radius, radius), radius, paint);
  }
}
