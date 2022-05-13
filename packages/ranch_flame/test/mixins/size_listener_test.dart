// ignore_for_file: cascade_invocations

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ranch_flame/ranch_flame.dart';

class TestComponent extends PositionComponent with SizeListener {
  TestComponent(Vector2 size) : super(size: size);

  final Vector2 newSize = Vector2.zero();

  @override
  void onSizeChanged() {
    newSize.setFrom(size);
  }
}

void main() {
  final flameTester = FlameTester(FlameGame.new);

  group('SizeListener', () {
    flameTester.test('calls onSizeChanged when size changed', (game) async {
      final originalSize = Vector2.all(64);
      final component = TestComponent(originalSize);

      await game.ready();
      await game.ensureAdd(component);

      component.size.multiply(Vector2.all(2));

      expect(
        component.newSize,
        closeToVector(originalSize.x * 2, originalSize.y * 2),
      );
    });

    flameTester.test('does not call onSizeChanged after removing from parent',
        (game) async {
      final originalSize = Vector2.all(64);
      final component = TestComponent(originalSize);

      await game.ready();
      await game.ensureAdd(component);

      component.removeFromParent();
      game.update(0); // Simulate game tick

      component.size.multiply(Vector2.all(2));

      expect(
        component.newSize,
        closeToVector(originalSize.x, originalSize.y),
      );
    });
  });
}
