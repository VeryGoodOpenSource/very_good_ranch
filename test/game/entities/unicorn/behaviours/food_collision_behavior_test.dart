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
        for (final stageFood in {
          UnicornStage.baby: FoodType.candy,
          UnicornStage.kid: FoodType.lollipop,
          UnicornStage.teenager: FoodType.iceCream,
          UnicornStage.adult: FoodType.pancake,
        }.entries) {
          flameTester
              .test('${stageFood.key.name} prefers ${stageFood.value.name}',
                  (game) async {
            final stage = stageFood.key;
            final foodType = stageFood.value;

            final leavingBehavior = _MockLeavingBehavior();
            when(() => leavingBehavior.isLeaving).thenReturn(false);

            final evolutionBehavior = _MockEvolutionBehavior();
            when(() => evolutionBehavior.currentStage).thenReturn(stage);

            final foodCollisionBehavior = FoodCollisionBehavior();
            final unicorn = Unicorn.test(
              position: Vector2.zero(),
              behaviors: [
                evolutionBehavior,
                foodCollisionBehavior,
                leavingBehavior,
              ],
            );
            unicorn.enjoymentFactor = 0.5;

            await game.ensureAdd(unicorn);

            final food = _MockFood();
            when(() => food.type).thenReturn(foodType);
            when(() => food.beingDragged).thenReturn(false);

            foodCollisionBehavior.onCollision({Vector2.zero()}, food);

            expect(unicorn.enjoymentFactor, 0.8);
          });
        }
      });

      flameTester.test('with the wrong type of food', (game) async {
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
        unicorn.enjoymentFactor = 0.5;

        await game.ensureAdd(unicorn);

        final food = _MockFood();
        when(() => food.type).thenReturn(FoodType.candy);
        when(() => food.beingDragged).thenReturn(false);

        foodCollisionBehavior.onCollision({Vector2.zero()}, food);

        expect(unicorn.enjoymentFactor, 0.4);
      });
    });

    group('feeding unicorn impacts fullness', () {
      group('in a positive way', () {
        for (final stageFullnessResult in {
          UnicornStage.baby: 0.8,
          UnicornStage.kid: 0.75,
          UnicornStage.teenager: 0.7,
          UnicornStage.adult: 0.65,
        }.entries) {
          flameTester.test('for ${stageFullnessResult.key.name}', (game) async {
            final stage = stageFullnessResult.key;
            final fullnessResult = stageFullnessResult.value;
            final evolutionBehavior = _MockEvolutionBehavior();
            when(() => evolutionBehavior.currentStage).thenReturn(stage);

            final foodCollisionBehavior = FoodCollisionBehavior();
            final unicorn = Unicorn.test(
              position: Vector2.zero(),
              behaviors: [
                evolutionBehavior,
                foodCollisionBehavior,
              ],
            );
            unicorn.fullnessFactor = 0.5;

            await game.ensureAdd(unicorn);

            final food = _MockFood();
            when(() => food.type).thenReturn(FoodType.candy);
            when(() => food.beingDragged).thenReturn(false);

            foodCollisionBehavior.onCollision({Vector2.zero()}, food);

            expect(unicorn.fullnessFactor, fullnessResult);
          });
        }
      });
    });
  });
}
