import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

/// Type of food.
enum FoodType {
  /// Cupcake type.
  cupcake,

  /// Lollipop type.
  lollipop,

  /// Pancake type.
  pancake,

  /// Ice cream type.
  iceCream,

  /// Candy type.
  candy,
}

/// {@template food_component}
/// A component that represents a food.
/// {@endtemplate}
class FoodComponent extends PositionComponent {
  /// {@macro food_component}
  FoodComponent({
    required this.type,
  }) : super(
          size: Vector2.all(32),
          children: [CircleHitbox()],
        );

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
      case FoodType.cupcake:
        paint.color = const Color(0xFFE1BA84);
        break;
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
