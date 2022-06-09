import 'dart:ui';

import 'package:flame/components.dart';

/// Type of food.
enum FoodType {
  /// Cake type.
  cake,

  /// Lollipop type.
  lollipop,

  /// Pancake type.
  pancake,

  /// Ice cream type.
  iceCream;
}

/// NOTE: This should be a 2.17 enum constructor but guess what, coverage
/// doesn't work for that, see: https://github.com/dart-lang/coverage/issues/386
extension FoodTypeX on FoodType {
  /// The nutrition value of the food.
  double get nutrition {
    switch (this) {
      case FoodType.cake:
        return 1;
      case FoodType.lollipop:
        return 2;
      case FoodType.pancake:
        return 3;
      case FoodType.iceCream:
        return 4;
    }
  }

  /// The rarity of the food.
  ///
  /// Each food type has a rarity percentage between 0 and 100, where 0 is the
  /// most rare and 100 is the most common.
  ///
  /// The rarity of a food is used to determine the chance of it being spawned.
  int get rarity {
    switch (this) {
      case FoodType.cake:
        return 40;
      case FoodType.lollipop:
        return 30;
      case FoodType.pancake:
        return 20;
      case FoodType.iceCream:
        return 10;
    }
  }

  /// The color of the food.
  ///
  /// NOTE: This is a temporary solution until there are assets for each food
  /// type.
  Color get color {
    switch (this) {
      case FoodType.lollipop:
        return const Color(0xFF3B93FF);
      case FoodType.pancake:
        return const Color(0xFFCED352);
      case FoodType.iceCream:
        return const Color(0xFFE9E9E9);
      case FoodType.cake:
        return const Color(0xFFF707FF);
    }
  }
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
    paint = Paint()..color = type.color;
  }

  @override
  void render(Canvas canvas) {
    canvas.drawCircle(Offset(radius, radius), radius, paint);
  }
}
