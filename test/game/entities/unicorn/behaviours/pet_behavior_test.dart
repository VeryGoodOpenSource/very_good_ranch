// ignore_for_file: cascade_invocations

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:very_good_ranch/game/entities/entities.dart';
import 'package:very_good_ranch/game/entities/unicorn/behaviors/behaviors.dart';

import '../../../../helpers/test_game.dart';

class _MockUnicornPercentage extends Mock implements UnicornPercentage {}

void main() {
  final flameTester = FlameTester(TestGame.new);

  group('PetBehavior', () {
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
            final petBehavior = PetBehavior();
            final unicorn = Unicorn.test(
              position: Vector2.zero(),
              unicornComponent: evolutionStage.componentForEvolutionStage,
              behaviors: [
                petBehavior,
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

    group('has a throttle time', () {
      late UnicornPercentage enjoyment;
      setUp(() {
        enjoyment = _MockUnicornPercentage();
      });
      flameTester.testGameWidget(
        'throttle prevents multiple taps',
        setUp: (game, tester) async {
          final petBehavior = PetBehavior();
          final unicorn = Unicorn.test(
            position: Vector2.zero(),
            behaviors: [
              petBehavior,
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
          game.update(PetBehavior.petThrottleDuration / 2);
          await tester.tapAt(Offset.zero);

          verifyNever(() => enjoyment.increaseBy(0.2));

          // Await for the rest of the throttle time, pet again
          game.update(PetBehavior.petThrottleDuration / 2);
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
  });
}
