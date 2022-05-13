// ignore_for_file: cascade_invocations

import 'package:flame/extensions.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_ranch/game/entities/food/food.dart';
import 'package:very_good_ranch/game/entities/unicorn/behaviors/behaviors.dart';

class MockFood extends Mock implements Food {}

void main() {
  group('CollisionBehavior', () {
    test('consumes food', () {
      final foodCollisionBehavior = FoodCollisionBehavior();
      final food = MockFood();

      foodCollisionBehavior.onCollision(<Vector2>{Vector2.zero()}, food);

      verify(food.removeFromParent).called(1);
    });
  });
}
