// ignore_for_file: cascade_invocations

import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_ranch/game/behaviors/behaviors.dart';

import '../../helpers/helpers.dart';

class _TestEntity extends Entity {
  _TestEntity({super.behaviors, super.position, super.size});
}

void main() {
  final flameTester = FlameTester(TestGame.new);

  group('PositionalPriorityBehavior', () {
    flameTester.test('set priority on load', (game) async {
      final entity = _TestEntity(
        position: Vector2(0, 100),
        size: Vector2(50, 50),
        behaviors: [PositionalPriorityBehavior()],
      );
      await game.ensureAdd(entity);

      expect(entity.priority, equals(100));
    });

    flameTester.test('update priority on position change', (game) async {
      final entity = _TestEntity(
        position: Vector2(0, 100),
        size: Vector2(50, 50),
        behaviors: [PositionalPriorityBehavior()],
      );
      await game.ensureAdd(entity);

      entity.position.y += 100;

      expect(entity.priority, equals(200));
    });

    flameTester.test('does not update priority when the behavior is removed',
        (game) async {
      final behavior = PositionalPriorityBehavior();

      final entity = _TestEntity(
        position: Vector2(0, 100),
        size: Vector2(50, 50),
        behaviors: [behavior],
      );
      await game.ensureAdd(entity);

      entity.remove(behavior);
      await game.ready();

      entity.position.y += 100;

      expect(entity.priority, equals(100));
    });

    flameTester.test('uses different anchor for the position', (game) async {
      final entity = _TestEntity(
        position: Vector2(0, 100),
        size: Vector2(50, 50),
        behaviors: [PositionalPriorityBehavior(anchor: Anchor.bottomRight)],
      );
      await game.ensureAdd(entity);

      expect(entity.priority, equals(150));
    });
  });
}
