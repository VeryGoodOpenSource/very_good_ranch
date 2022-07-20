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
import 'package:very_good_ranch/l10n/l10n.dart';

import '../../../../helpers/helpers.dart';

class _MockFood extends Mock implements Food {}

class _MockUnicornPercentage extends Mock implements UnicornPercentage {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late GameBloc gameBloc;
  late AppLocalizations l10n;

  setUp(() {
    gameBloc = MockGameBloc();
    when(() => gameBloc.state).thenReturn(const GameState());

    l10n = MockAppLocalizations();
    when(() => l10n.score).thenReturn('score');
  });

  final flameTester = FlameTester<VeryGoodRanchGame>(
    () => VeryGoodRanchGame(
      gameBloc: gameBloc,
      inventoryBloc: MockInventoryBloc(),
      l10n: l10n,
    ),
  );

  group('FoodCollisionBehavior', () {
    test('does not remove the food while it is being dragged', () {
      final foodCollisionBehavior = FoodCollisionBehavior();
      final food = _MockFood();

      when(() => food.wasDragged).thenReturn(false);
      when(() => food.beingDragged).thenReturn(true);

      foodCollisionBehavior.onCollision(<Vector2>{Vector2.zero()}, food);

      verifyNever(food.removeFromParent);
    });

    test('does not remove the food while it was not being dragged before', () {
      final foodCollisionBehavior = FoodCollisionBehavior();
      final food = _MockFood();

      when(() => food.wasDragged).thenReturn(false);
      when(() => food.beingDragged).thenReturn(false);

      foodCollisionBehavior.onCollision(<Vector2>{Vector2.zero()}, food);

      verifyNever(food.removeFromParent);
    });

    flameTester.test(
      'does not remove the food while unicorn is leaving',
      (game) async {
        final foodCollisionBehavior = FoodCollisionBehavior();
        final unicorn = Unicorn.test(
          position: Vector2.zero(),
          behaviors: [
            foodCollisionBehavior,
          ],
        )..isLeaving = true;
        await game.ensureAdd(unicorn);

        final food = _MockFood();
        when(() => food.wasDragged).thenReturn(false);
        when(() => food.beingDragged).thenReturn(false);
        foodCollisionBehavior.onCollision(<Vector2>{Vector2.zero()}, food);

        verifyNever(food.removeFromParent);
      },
    );

    flameTester.test(
      'removes the food from parent when it was dragged',
      (game) async {
        final foodCollisionBehavior = FoodCollisionBehavior();
        final unicorn = Unicorn.test(
          position: Vector2.zero(),
          unicornComponent: ChildUnicornComponent(),
          behaviors: [
            foodCollisionBehavior,
          ],
        )..isLeaving = false;
        await game.ensureAdd(unicorn);

        final food = _MockFood();
        when(() => food.beingDragged).thenReturn(false);
        when(() => food.wasDragged).thenReturn(true);
        when(() => food.type).thenReturn(FoodType.lollipop);
        foodCollisionBehavior.onCollision(<Vector2>{Vector2.zero()}, food);

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

            final foodCollisionBehavior = FoodCollisionBehavior();
            final unicorn = Unicorn.test(
              position: Vector2.zero(),
              unicornComponent: evolutionStage.componentForEvolutionStage,
              behaviors: [
                foodCollisionBehavior,
              ],
              enjoyment: enjoyment,
            )..isLeaving = false;

            await game.ensureAdd(unicorn);

            final food = _MockFood();
            when(() => food.type).thenReturn(preferredFoodType);
            when(() => food.wasDragged).thenReturn(true);
            when(() => food.beingDragged).thenReturn(false);

            foodCollisionBehavior.onCollision({Vector2.zero()}, food);

            verify(() => enjoyment.increaseBy(0.3)).called(1);
          });
        }
      });

      flameTester.test('with the wrong type of food', (game) async {
        final enjoyment = _MockUnicornPercentage();

        final foodCollisionBehavior = FoodCollisionBehavior();
        final unicorn = Unicorn.test(
          position: Vector2.zero(),
          unicornComponent: ChildUnicornComponent(),
          behaviors: [
            foodCollisionBehavior,
          ],
          enjoyment: enjoyment,
        )..isLeaving = false;

        await game.ensureAdd(unicorn);

        final food = _MockFood();
        when(() => food.type).thenReturn(FoodType.cake);
        when(() => food.wasDragged).thenReturn(true);
        when(() => food.beingDragged).thenReturn(false);

        foodCollisionBehavior.onCollision({Vector2.zero()}, food);

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

            final foodCollisionBehavior = FoodCollisionBehavior();
            final unicorn = Unicorn.test(
              position: Vector2.zero(),
              unicornComponent: evolutionStage.componentForEvolutionStage,
              behaviors: [
                foodCollisionBehavior,
              ],
              fullness: fullness,
            );

            await game.ensureAdd(unicorn);

            final food = _MockFood();
            when(() => food.type).thenReturn(FoodType.cake);
            when(() => food.wasDragged).thenReturn(true);
            when(() => food.beingDragged).thenReturn(false);

            foodCollisionBehavior.onCollision({Vector2.zero()}, food);

            verify(() => fullness.increaseBy(fullnessResult)).called(1);
          });
        }
      });
    });

    group('feeding unicorn impacts times fed', () {
      flameTester.test('summing one up', (game) async {
        final foodCollisionBehavior = FoodCollisionBehavior();
        final unicorn = Unicorn.test(
          position: Vector2.zero(),
          behaviors: [foodCollisionBehavior],
        );

        await game.ensureAdd(unicorn);

        final food = _MockFood();
        when(() => food.type).thenReturn(FoodType.cake);
        when(() => food.wasDragged).thenReturn(true);
        when(() => food.beingDragged).thenReturn(false);

        expect(unicorn.timesFed, 0);

        foodCollisionBehavior.onCollision({Vector2.zero()}, food);

        expect(unicorn.timesFed, 1);
      });
    });
  });
}
