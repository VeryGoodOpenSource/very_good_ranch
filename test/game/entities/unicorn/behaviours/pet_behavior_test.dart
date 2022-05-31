// ignore_for_file: cascade_invocations

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:very_good_ranch/game/entities/entities.dart';
import 'package:very_good_ranch/game/entities/unicorn/behaviors/behaviors.dart';

import '../../../../helpers/test_game.dart';

class _MockEvolutionBehavior extends Mock implements EvolutionBehavior {}

class _MockEnjoymentBehavior extends Mock implements EnjoymentBehavior {}

void main() {
  final flameTester = FlameTester(TestGame.new);

  group('PetBehavior', () {
    group('increases enjoyment', () {
      late EnjoymentBehavior enjoymentBehavior;
      setUp(() {
        enjoymentBehavior = _MockEnjoymentBehavior();
      });

      for (final stage in UnicornStage.values) {
        final petEnjoymentIncrease = stage.petEnjoymentIncrease;
        flameTester.testGameWidget(
          'for $stage',
          setUp: (game, tester) async {
            final evolutionBehavior = _MockEvolutionBehavior();
            when(() => evolutionBehavior.currentStage).thenReturn(stage);
            final petBehavior = PetBehavior();
            final unicorn = Unicorn.test(
              position: Vector2.zero(),
              behaviors: [
                petBehavior,
                evolutionBehavior,
                enjoymentBehavior,
              ],
            );
            when(() => enjoymentBehavior.percentage).thenReturn(0.5);
            await game.ensureAdd(unicorn);
          },
          verify: (game, tester) async {
            await tester.tapAt(Offset.zero);

            /// Flush long press gesture timer
            game.pauseEngine();
            await tester.pumpAndSettle();
            game.resumeEngine();

            verify(() => enjoymentBehavior.increaseBy(petEnjoymentIncrease))
                .called(1);
          },
        );
      }
    });

    group('has a throttle time', () {
      late EnjoymentBehavior enjoymentBehavior;
      setUp(() {
        enjoymentBehavior = _MockEnjoymentBehavior();
      });
      flameTester.testGameWidget(
        'throttle prevents multiple taps',
        setUp: (game, tester) async {
          final evolutionBehavior = _MockEvolutionBehavior();
          when(() => evolutionBehavior.currentStage)
              .thenReturn(UnicornStage.baby);
          final petBehavior = PetBehavior();
          final unicorn = Unicorn.test(
            position: Vector2.zero(),
            behaviors: [
              petBehavior,
              evolutionBehavior,
              enjoymentBehavior,
            ],
          );
          when(() => enjoymentBehavior.percentage).thenReturn(0.5);
          await game.ensureAdd(unicorn);
        },
        verify: (game, tester) async {
          // Give it the first pet
          await tester.tapAt(Offset.zero);
          verify(() => enjoymentBehavior.increaseBy(0.2)).called(1);

          // Do not wait full throttle time, pet again
          game.update(PetBehavior.petThrottleDuration / 2);
          await tester.tapAt(Offset.zero);

          verifyNever(() => enjoymentBehavior.increaseBy(0.2));

          // Await for the rest of the throttle time, pet again
          game.update(PetBehavior.petThrottleDuration / 2);
          await tester.tapAt(Offset.zero);

          /// Flush long press gesture timer
          game.pauseEngine();
          await tester.pumpAndSettle();
          game.resumeEngine();

          verify(
            () => enjoymentBehavior.increaseBy(
              UnicornStage.baby.petEnjoymentIncrease,
            ),
          ).called(1);
        },
      );
    });
  });
}
