// ignore_for_file: cascade_invocations

import 'dart:math';

import 'package:flame/extensions.dart';
import 'package:flame_steering_behaviors/flame_steering_behaviors.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:ranch_components/ranch_components.dart';
import 'package:very_good_ranch/game/entities/unicorn/behaviors/behaviors.dart';
import 'package:very_good_ranch/game/entities/unicorn/unicorn.dart';
import 'package:very_good_ranch/game/game.dart';
import 'package:very_good_ranch/l10n/l10n.dart';

import '../../../../helpers/helpers.dart';

class MockFood extends Mock implements FoodComponent {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late Random seed;
  late GameBloc gameBloc;
  late AppLocalizations l10n;

  setUp(() {
    seed = MockRandom();
    when(() => seed.nextInt(any())).thenReturn(0);
    when(() => seed.nextDouble()).thenReturn(0);
    when(() => seed.nextBool()).thenReturn(false);

    gameBloc = MockGameBloc();
    when(() => gameBloc.state).thenReturn(const GameState());

    l10n = MockAppLocalizations();
    when(() => l10n.score).thenReturn('score');
  });

  final flameTester = FlameTester<VeryGoodRanchGame>(
    () => VeryGoodRanchGame(
      seed: seed,
      gameBloc: gameBloc,
      inventoryBloc: MockInventoryBloc(),
      l10n: l10n,
    ),
  );

  group('MovementBehavior', () {
    group('roaming', () {
      flameTester.test('roams towards direction', (game) async {
        final movementBehavior = MovementBehavior();
        final pastureTop = game.background.pastureField.topLeft.toVector2();

        final unicorn = Unicorn.test(
          position: pastureTop,
          behaviors: [
            movementBehavior,
          ],
        );
        await game.ensureAdd(unicorn);

        when(seed.nextDouble).thenReturn(0);
        movementBehavior.simulateTick();
        expect(unicorn.state, UnicornState.walking);
        await game.ready();

        game.update(1); // Setup velocity.
        game.update(5); // Update position.

        final result = pastureTop + Vector2(50, 0);

        expect(
          unicorn.position,
          closeToVector(result.x, result.y),
        );
      });

      group('starts idling ', () {
        flameTester.test('when randomness decides so', (game) async {
          final movementBehavior = MovementBehavior();

          final pastureTop = game.background.pastureField.top;
          final pastureLeft = game.background.pastureField.left;

          final unicorn = Unicorn.test(
            position: Vector2(pastureLeft + 20, pastureTop),
            behaviors: [
              movementBehavior,
            ],
          );
          await game.ensureAdd(unicorn);

          when(seed.nextDouble).thenReturn(0);
          game.update(10);
          expect(unicorn.state, UnicornState.walking);
          await game.ready();
          expect(unicorn.hasBehavior<WanderBehavior>(), isTrue);

          when(seed.nextDouble).thenReturn(1);
          game.update(10);
          expect(unicorn.state, UnicornState.idle);
          await game.ready();
          expect(unicorn.hasBehavior<WanderBehavior>(), isFalse);
        });

        flameTester.test('if left border is reached', (game) async {
          final movementBehavior = MovementBehavior();

          final pastureLeft = game.background.pastureField.left;

          final unicorn = Unicorn.test(
            position: Vector2(pastureLeft, game.size.y / 2),
            behaviors: [
              movementBehavior,
            ],
          );
          unicorn.velocity.x = -10;
          await game.ensureAdd(unicorn);

          when(seed.nextDouble).thenReturn(0);
          movementBehavior.simulateTick();
          expect(unicorn.state, UnicornState.walking);
          await game.ready();

          game.update(0);
          game.update(1);

          expect(
            unicorn.position,
            closeToVector(pastureLeft - 10, game.size.y / 2),
          );
          expect(unicorn.state, UnicornState.idle);

          await game.ready();
          expect(unicorn.hasBehavior<WanderBehavior>(), isFalse);
        });

        flameTester.test('if top border is reached', (game) async {
          final movementBehavior = MovementBehavior();

          final pastureTop = game.background.pastureField.top;

          final unicorn = Unicorn.test(
            position: Vector2(game.size.x / 2, pastureTop),
            behaviors: [
              movementBehavior,
            ],
          );
          unicorn.velocity.y = -10;
          await game.ensureAdd(unicorn);

          when(seed.nextDouble).thenReturn(0);
          movementBehavior.simulateTick();
          expect(unicorn.state, UnicornState.walking);
          await game.ready();

          game.update(0);
          game.update(1);

          expect(
            unicorn.position,
            closeToVector(game.size.x / 2, pastureTop - 10),
          );
          expect(unicorn.state, UnicornState.idle);

          await game.ready();
          expect(unicorn.hasBehavior<WanderBehavior>(), isFalse);
        });

        flameTester.test('if bottom border is reached', (game) async {
          final movementBehavior = MovementBehavior();

          final pastureBottom = game.background.pastureField.bottom;

          final unicorn = Unicorn.test(
            position: Vector2(game.size.x / 2, pastureBottom),
            behaviors: [
              movementBehavior,
            ],
          );
          unicorn.velocity.y = 10;
          await game.ensureAdd(unicorn);

          when(seed.nextDouble).thenReturn(0);
          movementBehavior.simulateTick();
          expect(unicorn.state, UnicornState.walking);
          await game.ready();

          game.update(0);
          game.update(1);

          expect(
            unicorn.position,
            closeToVector(game.size.x / 2, pastureBottom - unicorn.size.y + 10),
          );
          expect(unicorn.state, UnicornState.idle);

          await game.ready();
          expect(unicorn.hasBehavior<WanderBehavior>(), isFalse);
        });

        flameTester.test('if right border is reached', (game) async {
          final movementBehavior = MovementBehavior();
          final pastureRight = game.background.pastureField.right;

          final unicorn = Unicorn.test(
            position: Vector2(pastureRight, game.size.y / 2),
            behaviors: [
              movementBehavior,
            ],
          );
          unicorn.velocity.x = 10;
          unicorn.position.x -= unicorn.size.x;
          await game.ensureAdd(unicorn);

          when(seed.nextDouble).thenReturn(0);
          movementBehavior.simulateTick();
          expect(unicorn.state, UnicornState.walking);
          await game.ready();

          game.update(0);
          game.update(1);

          expect(
            unicorn.position,
            closeToVector(pastureRight - unicorn.size.x + 10, game.size.y / 2),
          );
          expect(unicorn.state, UnicornState.idle);

          await game.ready();
          expect(unicorn.hasBehavior<WanderBehavior>(), isFalse);
        });
      });
    });

    group('onTick', () {
      flameTester.test('sets state to roaming', (game) async {
        when(() => seed.nextBool()).thenReturn(true);
        when(() => seed.nextDouble()).thenReturn(0.25);

        final movementBehavior = MovementBehavior();

        final unicorn = Unicorn.test(
          position: Vector2.zero(),
          behaviors: [
            movementBehavior,
          ],
        );
        await game.ensureAdd(unicorn);

        game.update(10);
        await game.ready();

        expect(unicorn.hasBehavior<WanderBehavior>(), isTrue);
        expect(unicorn.state, UnicornState.walking);
      });

      flameTester.test('sets state to idle', (game) async {
        when(() => seed.nextDouble()).thenReturn(1);

        final movementBehavior = MovementBehavior();

        final unicorn = Unicorn.test(
          position: Vector2.zero(),
          behaviors: [
            movementBehavior,
          ],
        );

        await game.ready();
        await game.ensureAdd(unicorn);

        game.update(10);

        expect(unicorn.hasBehavior<WanderBehavior>(), isFalse);
        expect(unicorn.state, UnicornState.idle);
      });

      group('flips horizontally', () {
        flameTester.test('flips it', (game) async {
          when(() => seed.nextBool()).thenReturn(true);
          when(() => seed.nextDouble()).thenReturn(0.25);

          final movementBehavior = MovementBehavior();

          final unicorn = Unicorn.test(
            position: Vector2.zero(),
            behaviors: [
              movementBehavior,
            ],
          );
          unicorn.unicornComponent.transform.scale.x = 1;
          unicorn.velocity.x = 1;

          await game.ensureAdd(unicorn);

          game.update(0);

          expect(unicorn.unicornComponent.transform.scale.x, equals(-1));
        });

        flameTester.test('flips it back', (game) async {
          when(() => seed.nextBool()).thenReturn(false);
          when(() => seed.nextDouble()).thenReturn(0.25);

          final movementBehavior = MovementBehavior();

          final unicorn = Unicorn.test(
            position: Vector2.zero(),
            behaviors: [
              movementBehavior,
            ],
          );
          unicorn.unicornComponent.transform.scale.x = -1;
          unicorn.velocity.x = -1;

          await game.ensureAdd(unicorn);

          game.update(0);

          expect(unicorn.unicornComponent.transform.scale.x, equals(1));
        });

        flameTester.test('flips it back on zero', (game) async {
          when(() => seed.nextBool()).thenReturn(true);
          when(() => seed.nextDouble()).thenReturn(0);

          final movementBehavior = MovementBehavior();

          final unicorn = Unicorn.test(
            position: Vector2.zero(),
            behaviors: [
              movementBehavior,
            ],
          );
          unicorn.unicornComponent.transform.scale.x = -1;
          unicorn.velocity.x = 0;

          await game.ensureAdd(unicorn);

          game.update(0);

          expect(unicorn.unicornComponent.transform.scale.x, equals(1));
        });
      });
    });
  });
}
