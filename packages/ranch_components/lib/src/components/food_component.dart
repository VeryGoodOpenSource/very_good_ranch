import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/input.dart';

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
class FoodComponent extends PositionComponent with Draggable {
  /// {@macro food_component}
  FoodComponent({
    required Vector2 position,
    required this.saturation,
    required this.type,
  }) : super(
          position: position,
          size: Vector2.all(32),
          children: [CircleHitbox()],
        );

  /// {@macro food_component}
  ///
  /// Constructs a cupcake.
  FoodComponent.cupcake({
    required Vector2 position,
  }) : this(position: position, saturation: 2.5, type: FoodType.cupcake);

  /// {@macro food_component}
  ///
  /// Constructs a lollipop.
  FoodComponent.lollipop({
    required Vector2 position,
  }) : this(position: position, saturation: 1.5, type: FoodType.lollipop);

  /// {@macro food_component}
  ///
  /// Constructs a pancake.
  FoodComponent.pancake({
    required Vector2 position,
  }) : this(position: position, saturation: 3, type: FoodType.pancake);

  /// {@macro food_component}
  ///
  /// Constructs an ice cream.
  FoodComponent.iceCream({
    required Vector2 position,
  }) : this(position: position, saturation: 2, type: FoodType.iceCream);

  /// {@macro food_component}
  ///
  /// Constructs a candy.
  FoodComponent.candy({
    required Vector2 position,
  }) : this(position: position, saturation: 1, type: FoodType.candy);

  /// The amount of saturation the food provides.
  final double saturation;

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
  bool onDragUpdate(DragUpdateInfo info) {
    position.add(info.delta.game);
    return false;
  }

  @override
  void render(Canvas canvas) {
    canvas.drawCircle(Offset(radius, radius), radius, paint);
  }
}
