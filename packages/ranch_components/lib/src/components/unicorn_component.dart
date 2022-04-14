import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

/// {@template unicorn_component}
/// A component that represents a unicorn.
/// {@endtemplate}
class UnicornComponent extends PositionComponent with CollisionCallbacks {
  /// {@macro unicorn_component}
  UnicornComponent({
    required Vector2 position,
  }) : super(
          position: position,
          size: Vector2.all(32),
          children: [RectangleHitbox()],
        );

  /// The paint used to render the unicorn.
  ///
  /// NOTE: This is a temporary solution until there are assets for unicorns.
  late Paint paint;

  @override
  Future<void> onLoad() async {
    paint = Paint()..color = const Color(0xFFE184E1);
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRect(Vector2.zero() & size, paint);
  }
}
