// ignore_for_file: cascade_invocations

import 'package:flame/extensions.dart';
import 'package:flame_steering_behaviors/flame_steering_behaviors.dart';
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

class _MockUnicornPercentage extends Mock implements UnicornPercentage {}

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
      blessingBloc: MockBlessingBloc(),
      inventoryBloc: MockInventoryBloc(),
    ),
  );

  group('FoodCollidingBehavior', () {
    group('does not remove the food', () {
      test('while it is being dragged', () {
        final foodCollidingBehavior = FoodCollidingBehavior();
        final food = _MockFood();

        when(() => food.wasDragged).thenReturn(false);
        when(() => food.beingDragged).thenReturn(true);
        when(() => food.isRemoving).thenReturn(false);

        foodCollidingBehavior.onCollision(<Vector2>{Vector2.zero()}, food);

        verifyNever(food.removeFromParent);
      });
      test('while it was not being dragged before', () {
        final foodCollidingBehavior = FoodCollidingBehavior();
        final food = _MockFood();

        when(() => food.wasDragged).thenReturn(false);
        when(() => food.beingDragged).thenReturn(false);
        when(() => food.isRemoving).thenReturn(false);

        foodCollidingBehavior.onCollision(<Vector2>{Vector2.zero()}, food);

        verifyNever(food.removeFromParent);
      });
      test('when it as used', () {
        final foodCollidingBehavior = FoodCollidingBehavior();
        final food = _MockFood();

        when(() => food.beingDragged).thenReturn(false);
        when(() => food.wasDragged).thenReturn(true);
        when(() => food.isRemoving).thenReturn(true);

        foodCollidingBehavior.onCollision(<Vector2>{Vector2.zero()}, food);

        verifyNever(food.removeFromParent);
      });
      flameTester.test(
        'while unicorn is leaving',
        (game) async {
          final foodCollidingBehavior = FoodCollidingBehavior();
          final unicorn = Unicorn.test(
            position: Vector2.zero(),
            behaviors: [
              foodCollidingBehavior,
            ],
          )..isLeaving = true;
          await game.ensureAdd(unicorn);

          final food = _MockFood();
          when(() => food.wasDragged).thenReturn(false);
          when(() => food.beingDragged).thenReturn(false);
          foodCollidingBehavior.onCollision(<Vector2>{Vector2.zero()}, food);

          verifyNever(food.removeFromParent);
        },
      );
    });

    flameTester.test(
      'removes the food from parent when it was dragged',
      (game) async {
        final foodCollidingBehavior = FoodCollidingBehavior();
        final unicorn = Unicorn.test(
          position: Vector2.zero(),
          unicornComponent: ChildUnicornComponent(),
          behaviors: [
            foodCollidingBehavior,
          ],
        )..isLeaving = false;
        await game.ensureAdd(unicorn);

        final food = _MockFood();
        when(() => food.beingDragged).thenReturn(false);
        when(() => food.wasDragged).thenReturn(true);
        when(() => food.isRemoving).thenReturn(false);
        when(() => food.type).thenReturn(FoodType.lollipop);
        foodCollidingBehavior.onCollision(<Vector2>{Vector2.zero()}, food);

        verify(food.removeFromParent).called(1);
      },
    );

    group('feeding unicorn impacts enjoyment', () {
      group('with the right type of food', () {
        for (final evolutionStage in UnicornEvolutionStage.values) {
          flameTester.test(
              '${evolutionStage.name} prefers '
              '${evolutionStage.preferredFoodType.name}', (game) async {
            final preferredFoodType = evolutionStage.preferredFoodType;

            final enjoyment = _MockUnicornPercentage();

            final foodCollidingBehavior = FoodCollidingBehavior();
            final unicorn = Unicorn.test(
              position: Vector2.zero(),
              unicornComponent:
                  evolutionStage.componentForEvolutionStage(UnicornState.idle),
              behaviors: [
                foodCollidingBehavior,
              ],
              enjoyment: enjoyment,
            )..isLeaving = false;

            await game.ensureAdd(unicorn);

            final food = _MockFood();
            when(() => food.type).thenReturn(preferredFoodType);
            when(() => food.wasDragged).thenReturn(true);
            when(() => food.beingDragged).thenReturn(false);
            when(() => food.isRemoving).thenReturn(false);

            foodCollidingBehavior.onCollision({Vector2.zero()}, food);

            verify(() => enjoyment.increaseBy(0.3)).called(1);
          });
        }
      });

      flameTester.test('with the wrong type of food', (game) async {
        final enjoyment = _MockUnicornPercentage();

        final foodCollidingBehavior = FoodCollidingBehavior();
        final unicorn = Unicorn.test(
          position: Vector2.zero(),
          unicornComponent: ChildUnicornComponent(),
          behaviors: [
            foodCollidingBehavior,
          ],
          enjoyment: enjoyment,
        )..isLeaving = false;

        await game.ensureAdd(unicorn);

        final food = _MockFood();
        when(() => food.type).thenReturn(FoodType.cake);
        when(() => food.wasDragged).thenReturn(true);
        when(() => food.beingDragged).thenReturn(false);
        when(() => food.isRemoving).thenReturn(false);

        foodCollidingBehavior.onCollision({Vector2.zero()}, food);

        verify(() => enjoyment.increaseBy(-0.1)).called(1);
      });
    });

    group('feeding unicorn impacts fullness', () {
      group('in a positive way', () {
        for (final stageFullnessResult in {
          UnicornEvolutionStage.baby: 0.3,
          UnicornEvolutionStage.child: 0.25,
          UnicornEvolutionStage.teen: 0.2,
          UnicornEvolutionStage.adult: 0.15,
        }.entries) {
          flameTester.test('for ${stageFullnessResult.key.name}', (game) async {
            final evolutionStage = stageFullnessResult.key;
            final fullnessResult = stageFullnessResult.value;

            final fullness = _MockUnicornPercentage();

            final foodCollidingBehavior = FoodCollidingBehavior();
            final unicorn = Unicorn.test(
              position: Vector2.zero(),
              unicornComponent:
                  evolutionStage.componentForEvolutionStage(UnicornState.idle),
              behaviors: [
                foodCollidingBehavior,
              ],
              fullness: fullness,
            );

            await game.ensureAdd(unicorn);

            final food = _MockFood();
            when(() => food.type).thenReturn(FoodType.cake);
            when(() => food.wasDragged).thenReturn(true);
            when(() => food.beingDragged).thenReturn(false);
            when(() => food.isRemoving).thenReturn(false);

            foodCollidingBehavior.onCollision({Vector2.zero()}, food);

            verify(() => fullness.increaseBy(fullnessResult)).called(1);
          });
        }
      });
    });

    group('feeding unicorn impacts times fed', () {
      flameTester.test('summing one up', (game) async {
        final foodCollidingBehavior = FoodCollidingBehavior();
        final unicorn = Unicorn.test(
          position: Vector2.zero(),
          behaviors: [foodCollidingBehavior],
        );

        await game.ensureAdd(unicorn);

        final food = _MockFood();
        when(() => food.type).thenReturn(FoodType.cake);
        when(() => food.wasDragged).thenReturn(true);
        when(() => food.beingDragged).thenReturn(false);
        when(() => food.isRemoving).thenReturn(false);

        expect(unicorn.timesFed, 0);

        foodCollidingBehavior.onCollision({Vector2.zero()}, food);

        expect(unicorn.timesFed, 1);
      });
    });

    group('feeding unicorn impacts food used', () {
      flameTester.test('setting it to true', (game) async {
        final foodCollidingBehavior = FoodCollidingBehavior();
        final unicorn = Unicorn.test(
          position: Vector2.zero(),
          behaviors: [foodCollidingBehavior],
        );

        await game.ensureAdd(unicorn);

        final food = _MockFood();
        when(() => food.type).thenReturn(FoodType.cake);
        when(() => food.wasDragged).thenReturn(true);
        when(() => food.beingDragged).thenReturn(false);
        when(() => food.isRemoving).thenReturn(false);

        verifyNever(food.removeFromParent);

        foodCollidingBehavior.onCollision({Vector2.zero()}, food);

        verify(food.removeFromParent).called(1);
      });
    });

    group('feeding unicorn starts eating animation', () {
      flameTester.test('by changing state', (game) async {
        final foodCollidingBehavior = FoodCollidingBehavior();
        final unicorn = Unicorn.test(
          position: Vector2.zero(),
          behaviors: [foodCollidingBehavior],
        );

        await game.ensureAdd(unicorn);

        final food = _MockFood();
        when(() => food.type).thenReturn(FoodType.cake);
        when(() => food.wasDragged).thenReturn(true);
        when(() => food.beingDragged).thenReturn(false);
        when(() => food.isRemoving).thenReturn(false);
        expect(unicorn.timesFed, 0);
        unicorn.startWalking();
        await game.ready();

        expect(unicorn.state, UnicornState.walking);
        expect(unicorn.hasBehavior<WanderBehavior>(), true);

        foodCollidingBehavior.onCollision({Vector2.zero()}, food);

        final wanderBehavior =
            game.descendants().whereType<WanderBehavior>().first;

        expect(unicorn.state, UnicornState.eating);
        expect(wanderBehavior.isRemoving, true);
      });
    });
  });
}
