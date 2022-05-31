// ignore_for_file: cascade_invocations

import 'package:flame/extensions.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ranch_components/ranch_components.dart';
import 'package:very_good_ranch/game/entities/food/food.dart';
import 'package:very_good_ranch/game/entities/unicorn/behaviors/behaviors.dart';
import 'package:very_good_ranch/game/entities/unicorn/unicorn.dart';
import 'package:very_good_ranch/game/game.dart';

import '../../../../helpers/helpers.dart';

class _MockFood extends Mock implements Food {}

class _MockEvolutionBehavior extends Mock implements EvolutionBehavior {}

class _MockLeavingBehavior extends Mock implements LeavingBehavior {}

class _MockEnjoymentBehavior extends Mock implements EnjoymentBehavior {}

class _MockFullnessBehavior extends Mock implements FullnessBehavior {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late GameBloc gameBloc;

  setUp(() {
    gameBloc = MockGameBloc();
    when(() => gameBloc.state).thenReturn(const GameState());
  });

  final flameTester = FlameTester<VeryGoodRanchGame>(
    () => VeryGoodRanchGame(
      gameBloc: gameBloc,
      inventoryBloc: MockInventoryBloc(),
    ),
  );

  group('FoodCollisionBehavior', () {
    test('does not remove the food while it is being dragged', () {
      final foodCollisionBehavior = FoodCollisionBehavior();
      final food = _MockFood();

      when(() => food.beingDragged).thenReturn(true);

      foodCollisionBehavior.onCollision(<Vector2>{Vector2.zero()}, food);

      verifyNever(food.removeFromParent);
    });

    flameTester.test(
      'does not remove the food while unicorn is leaving',
      (game) async {
        final leavingBehavior = _MockLeavingBehavior();
        when(() => leavingBehavior.isLeaving).thenReturn(true);

        final foodCollisionBehavior = FoodCollisionBehavior();
        final unicorn = Unicorn.test(
          position: Vector2.zero(),
          behaviors: [
            leavingBehavior,
            foodCollisionBehavior,
          ],
        );
        await game.ensureAdd(unicorn);

        final food = _MockFood();
        when(() => food.beingDragged).thenReturn(false);
        foodCollisionBehavior.onCollision(<Vector2>{Vector2.zero()}, food);

        verifyNever(food.removeFromParent);
      },
    );

    flameTester.test('removes the food from parent', (game) async {
      final leavingBehavior = _MockLeavingBehavior();
      when(() => leavingBehavior.isLeaving).thenReturn(false);

      final evolutionBehavior = _MockEvolutionBehavior();
      when(() => evolutionBehavior.currentStage).thenReturn(UnicornStage.kid);

      final foodCollisionBehavior = FoodCollisionBehavior();
      final unicorn = Unicorn.test(
        position: Vector2.zero(),
        behaviors: [
          evolutionBehavior,
          foodCollisionBehavior,
          leavingBehavior,
        ],
      );
      await game.ensureAdd(unicorn);

      final food = _MockFood();
      when(() => food.beingDragged).thenReturn(false);
      when(() => food.type).thenReturn(FoodType.lollipop);
      foodCollisionBehavior.onCollision(<Vector2>{Vector2.zero()}, food);

      verify(food.removeFromParent).called(1);
    });

    group('feeding unicorn impacts enjoyment', () {
      group('with the right type of food', () {
        for (final stage in UnicornStage.values) {
          flameTester
              .test('${stage.name} prefers ${stage.preferredFoodType.name}',
                  (game) async {
            final preferredFoodType = stage.preferredFoodType;

            final leavingBehavior = _MockLeavingBehavior();
            when(() => leavingBehavior.isLeaving).thenReturn(false);

            final evolutionBehavior = _MockEvolutionBehavior();
            when(() => evolutionBehavior.currentStage).thenReturn(stage);

            final enjoymentBehavior = _MockEnjoymentBehavior();
            when(() => enjoymentBehavior.percentage).thenReturn(0.5);

            final foodCollisionBehavior = FoodCollisionBehavior();
            final unicorn = Unicorn.test(
              position: Vector2.zero(),
              behaviors: [
                evolutionBehavior,
                foodCollisionBehavior,
                leavingBehavior,
                enjoymentBehavior,
              ],
            );

            await game.ensureAdd(unicorn);

            final food = _MockFood();
            when(() => food.type).thenReturn(preferredFoodType);
            when(() => food.beingDragged).thenReturn(false);

            foodCollisionBehavior.onCollision({Vector2.zero()}, food);

            verify(() => enjoymentBehavior.increaseBy(0.3)).called(1);
          });
        }
      });

      flameTester.test('with the wrong type of food', (game) async {
        final leavingBehavior = _MockLeavingBehavior();
        when(() => leavingBehavior.isLeaving).thenReturn(false);

        final evolutionBehavior = _MockEvolutionBehavior();
        when(() => evolutionBehavior.currentStage).thenReturn(UnicornStage.kid);

        final enjoymentBehavior = _MockEnjoymentBehavior();
        when(() => enjoymentBehavior.percentage).thenReturn(0.5);

        final foodCollisionBehavior = FoodCollisionBehavior();
        final unicorn = Unicorn.test(
          position: Vector2.zero(),
          behaviors: [
            evolutionBehavior,
            foodCollisionBehavior,
            leavingBehavior,
            enjoymentBehavior,
          ],
        );

        await game.ensureAdd(unicorn);

        final food = _MockFood();
        when(() => food.type).thenReturn(FoodType.candy);
        when(() => food.beingDragged).thenReturn(false);

        foodCollisionBehavior.onCollision({Vector2.zero()}, food);

        verify(() => enjoymentBehavior.increaseBy(-0.1)).called(1);
      });
    });

    group('feeding unicorn impacts fullness', () {
      group('in a positive way', () {
        for (final stageFullnessResult in {
          UnicornStage.baby: 0.3,
          UnicornStage.kid: 0.25,
          UnicornStage.teenager: 0.2,
          UnicornStage.adult: 0.15,
        }.entries) {
          flameTester.test('for ${stageFullnessResult.key.name}', (game) async {
            final stage = stageFullnessResult.key;
            final fullnessResult = stageFullnessResult.value;

            final evolutionBehavior = _MockEvolutionBehavior();
            when(() => evolutionBehavior.currentStage).thenReturn(stage);

            final fullnessBehavior = _MockFullnessBehavior();
            when(() => fullnessBehavior.percentage).thenReturn(0.5);

            final foodCollisionBehavior = FoodCollisionBehavior();
            final unicorn = Unicorn.test(
              position: Vector2.zero(),
              behaviors: [
                evolutionBehavior,
                foodCollisionBehavior,
                fullnessBehavior,
              ],
            );

            await game.ensureAdd(unicorn);

            final food = _MockFood();
            when(() => food.type).thenReturn(FoodType.candy);
            when(() => food.beingDragged).thenReturn(false);

            foodCollisionBehavior.onCollision({Vector2.zero()}, food);

            verify(() => fullnessBehavior.increaseBy(fullnessResult)).called(1);
          });
        }
      });
    });
  });
}
