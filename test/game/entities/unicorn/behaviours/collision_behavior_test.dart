// ignore_for_file: cascade_invocations

import 'package:flame/extensions.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:ranch_components/ranch_components.dart';
import 'package:very_good_ranch/game/entities/unicorn/behaviors/behaviors.dart';

import '../../../../helpers/helpers.dart';

class MockFood extends Mock implements FoodComponent {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final flameTester = FlameTester<TestGame>(TestGame.new);

  group('CollisionBehavior', () {
    test('consumes food', () {
      final collisionBehavior = CollisionBehavior();
      final food = MockFood();

      collisionBehavior.onCollision(<Vector2>{Vector2.zero()}, food);

      verify(food.removeFromParent).called(1);
    });
  });
}
