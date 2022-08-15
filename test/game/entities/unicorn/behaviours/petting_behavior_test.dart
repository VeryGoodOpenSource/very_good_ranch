// ignore_for_file: cascade_invocations

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_steering_behaviors/flame_steering_behaviors.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:ranch_components/ranch_components.dart';
import 'package:very_good_ranch/game/entities/entities.dart';
import 'package:very_good_ranch/game/entities/unicorn/behaviors/behaviors.dart';

import '../../../../helpers/test_game.dart';

class _MockUnicornPercentage extends Mock implements UnicornPercentage {}

void main() {
  final flameTester = FlameTester(TestGame.new);

  group('PettingBehavior', () {
    group('increases enjoyment', () {
      late UnicornPercentage enjoyment;
      setUp(() {
        enjoyment = _MockUnicornPercentage();
      });

      for (final evolutionStage in UnicornEvolutionStage.values) {
        final petEnjoymentIncrease = evolutionStage.petEnjoymentIncrease;
        flameTester.testGameWidget(
          'for $evolutionStage',
          setUp: (game, tester) async {
            final pettingBehavior = PettingBehavior();
            final unicorn = Unicorn.test(
              position: Vector2.zero(),
              unicornComponent:
                  evolutionStage.componentForEvolutionStage(UnicornState.idle),
              behaviors: [
                pettingBehavior,
              ],
              enjoyment: enjoyment,
            );

            await game.ensureAdd(unicorn);
          },
          verify: (game, tester) async {
            await tester.tapAt(Offset.zero);

            /// Flush long press gesture timer
            game.pauseEngine();
            await tester.pumpAndSettle();
            game.resumeEngine();

            verify(() => enjoyment.increaseBy(petEnjoymentIncrease)).called(1);
          },
        );
      }
    });

    group('when clicking on overlapping unicorns', () {
      late UnicornPercentage enjoyment1;
      late UnicornPercentage enjoyment2;
      setUp(() {
        enjoyment1 = _MockUnicornPercentage();
        enjoyment2 = _MockUnicornPercentage();
      });

      flameTester.testGameWidget(
        'only computes on the top unicorn',
        setUp: (game, tester) async {
          await game.ensureAdd(
            Unicorn.test(
              position: Vector2.zero(),
              behaviors: [
                PettingBehavior(),
              ],
              enjoyment: enjoyment1,
            ),
          );
          await game.ensureAdd(
            Unicorn.test(
              position: Vector2.zero(),
              behaviors: [
                PettingBehavior(),
              ],
              enjoyment: enjoyment2,
            ),
          );
        },
        verify: (game, tester) async {
          await tester.tapAt(Offset.zero);

          /// Flush long press gesture timer
          game.pauseEngine();
          await tester.pumpAndSettle();
          game.resumeEngine();

          verifyNever(() => enjoyment1.increaseBy(any()));
          verify(() => enjoyment2.increaseBy(any())).called(1);
        },
      );
    });

    group('has a throttle time', () {
      late UnicornPercentage enjoyment;
      setUp(() {
        enjoyment = _MockUnicornPercentage();
      });
      flameTester.testGameWidget(
        'throttle prevents multiple taps',
        setUp: (game, tester) async {
          final pettingBehavior = PettingBehavior();
          final unicorn = Unicorn.test(
            position: Vector2.zero(),
            behaviors: [
              pettingBehavior,
            ],
            enjoyment: enjoyment,
          );
          await game.ensureAdd(unicorn);
        },
        verify: (game, tester) async {
          // Give it the first pet
          await tester.tapAt(Offset.zero);
          verify(() => enjoyment.increaseBy(0.2)).called(1);

          // Do not wait full throttle time, pet again
          game.update(PettingBehavior.petThrottleDuration / 2);
          await tester.tapAt(Offset.zero);

          verifyNever(() => enjoyment.increaseBy(0.2));

          // Await for the rest of the throttle time, pet again
          game.update(PettingBehavior.petThrottleDuration / 2);
          await tester.tapAt(Offset.zero);

          /// Flush long press gesture timer
          game.pauseEngine();
          await tester.pumpAndSettle();
          game.resumeEngine();

          verify(
            () => enjoyment.increaseBy(
              UnicornEvolutionStage.baby.petEnjoymentIncrease,
            ),
          ).called(1);
        },
      );
    });

    flameTester.testGameWidget(
      'starts animation',
      setUp: (game, tester) async {
        final pettingBehavior = PettingBehavior();
        final unicorn = Unicorn.test(
          position: Vector2.zero(),
          behaviors: [
            pettingBehavior,
          ],
        );

        await game.ensureAdd(unicorn);
        unicorn.startWalking();
        await game.ready();
      },
      verify: (game, tester) async {
        final unicorn = game.descendants().whereType<Unicorn>().first;

        expect(unicorn.state, UnicornState.walking);
        expect(unicorn.hasBehavior<WanderBehavior>(), true);

        await tester.tapAt(Offset.zero);

        /// Flush long press gesture timer
        game.pauseEngine();
        await tester.pumpAndSettle();
        game.resumeEngine();

        final wanderBehavior =
            game.descendants().whereType<WanderBehavior>().first;

        expect(unicorn.state, UnicornState.petted);
        expect(wanderBehavior.isRemoving, true);
      },
    );
  });
}
