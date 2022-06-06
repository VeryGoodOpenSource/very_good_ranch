// ignore_for_file: cascade_invocations

import 'dart:math';

import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:ranch_components/ranch_components.dart';
import 'package:very_good_ranch/game/entities/unicorn/behaviors/behaviors.dart';
import 'package:very_good_ranch/game/entities/unicorn/unicorn.dart';
import 'package:very_good_ranch/game/game.dart';

import '../../../../helpers/helpers.dart';

class MockFood extends Mock implements FoodComponent {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late Random seed;
  late GameBloc gameBloc;

  setUp(() {
    seed = MockRandom();
    when(() => seed.nextInt(any())).thenReturn(0);
    when(() => seed.nextDouble()).thenReturn(0);
    when(() => seed.nextBool()).thenReturn(false);

    gameBloc = MockGameBloc();
    when(() => gameBloc.state).thenReturn(const GameState());
  });

  final flameTester = FlameTester<VeryGoodRanchGame>(
    () => VeryGoodRanchGame(
      seed: seed,
      gameBloc: gameBloc,
      inventoryBloc: MockInventoryBloc(),
    ),
  );

  group('MovementBehavior', () {
    group('roaming', () {
      flameTester.test('roams towards direction', (game) async {
        final movementBehavior = MovementBehavior();
        movementBehavior.direction = Vector2(1, 1);

        final unicorn = Unicorn.test(
          position: Vector2.zero(),
          behaviors: [
            movementBehavior,
          ],
        );
        unicorn.state = UnicornState.roaming;

        await game.ready();
        await game.ensureAdd(unicorn);

        game.update(5);

        expect(
          unicorn.position,
          closeToVector(57.0, 50),
        );
      });

      flameTester.test('starts idling if border is reached', (game) async {
        final movementBehavior = MovementBehavior();
        movementBehavior.direction = Vector2(-1, -1);

        final unicorn = Unicorn.test(
          position: Vector2.zero(),
          behaviors: [
            movementBehavior,
          ],
        );
        unicorn.state = UnicornState.roaming;

        await game.ready();
        await game.ensureAdd(unicorn);

        game.update(5);

        expect(
          unicorn.position,
          closeToVector(57.0, 48.5),
        );
        expect(unicorn.state, UnicornState.idle);
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

        await game.ready();
        await game.ensureAdd(unicorn);

        game.update(10);

        expect(movementBehavior.direction, closeToVector(0.25, 0.25));
        expect(unicorn.state, UnicornState.roaming);
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

        expect(movementBehavior.direction, closeToVector(0, 0));
        expect(unicorn.state, UnicornState.idle);
      });

      group('flips horizontally', () {
        flameTester.test('flips it', (game) async {
          when(() => seed.nextBool()).thenReturn(false);
          when(() => seed.nextDouble()).thenReturn(0.25);

          final movementBehavior = MovementBehavior();

          final unicorn = Unicorn.test(
            position: Vector2.zero(),
            behaviors: [
              movementBehavior,
            ],
          );
          unicorn.transform.scale.x = 1;

          await game.ready();
          await game.ensureAdd(unicorn);

          game.update(10);

          expect(unicorn.transform.scale.x, lessThan(0));
        });

        flameTester.test('flips it back', (game) async {
          when(() => seed.nextBool()).thenReturn(true);
          when(() => seed.nextDouble()).thenReturn(0.25);

          final movementBehavior = MovementBehavior();

          final unicorn = Unicorn.test(
            position: Vector2.zero(),
            behaviors: [
              movementBehavior,
            ],
          );
          unicorn.transform.scale.x = -1;

          await game.ready();
          await game.ensureAdd(unicorn);

          game.update(10);

          expect(unicorn.transform.scale.x, greaterThan(0));
        });
      });
    });
  });
}
