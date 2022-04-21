// ignore_for_file: cascade_invocations

import 'package:flame/extensions.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:ranch_components/ranch_components.dart';
import 'package:very_good_ranch/game/entities/unicorn/behaviors/behaviors.dart';
import 'package:very_good_ranch/game/entities/unicorn/unicorn.dart';

import '../../../../helpers/helpers.dart';

class MockFood extends Mock implements FoodComponent {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final flameTester = FlameTester<TestGame>(TestGame.new);

  group('CollisionBehavior', () {
    group('resizes according to parent', () {
      flameTester.test('keeps size in sync with parent', (game) async {
        final collisionBehavior = CollisionBehavior();

        final unicorn = Unicorn.test(position: Vector2.zero());

        await game.ready();
        await game.ensureAdd(unicorn);
        await unicorn.ensureAdd(collisionBehavior);

        expect(
          collisionBehavior.size,
          closeToVector(unicorn.size.x, unicorn.size.y),
        );

        unicorn.size.multiply(Vector2.all(2));

        expect(
          collisionBehavior.size,
          closeToVector(unicorn.size.x, unicorn.size.y),
        );
      });

      flameTester.test('does not keep size in sync after removing from parent',
          (game) async {
        final collisionBehavior = CollisionBehavior();
        final unicorn = Unicorn.test(position: Vector2.zero());
        await game.ready();
        await game.ensureAdd(unicorn);
        await unicorn.ensureAdd(collisionBehavior);

        expect(
          collisionBehavior.size,
          closeToVector(unicorn.size.x, unicorn.size.y),
        );

        collisionBehavior.removeFromParent();
        game.update(0); // Simulate game tick

        unicorn.size.multiply(Vector2.all(2));

        expect(
          collisionBehavior.size,
          closeToVector(32, 32),
        );
      });
    });

    test('consumes food', () {
      final collisionBehavior = CollisionBehavior();
      final food = MockFood();

      collisionBehavior.onCollision(<Vector2>{Vector2.zero()}, food);

      verify(food.removeFromParent).called(1);
    });
  });
}
