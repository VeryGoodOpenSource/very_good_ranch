// ignore_for_file: cascade_invocations

import 'package:flame/components.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:very_good_ranch/game/entities/entities.dart';
import 'package:very_good_ranch/game/entities/unicorn/behaviors/behaviors.dart';

import '../../../../helpers/test_game.dart';

class _MockEvolutionBehavior extends Mock implements EvolutionBehavior {}

void main() {
  final flameTester = FlameTester(TestGame.new);
  group('PetBehavior', () {
    group('increases enjoyment', () {
      for (final stageEnjoymentResult in {
        UnicornStage.baby: 0.7,
        UnicornStage.kid: 0.66,
        UnicornStage.teenager: 0.63,
        UnicornStage.adult: 0.6,
      }.entries) {
        final stage = stageEnjoymentResult.key;
        final enjoymentResult = stageEnjoymentResult.value;
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
              ],
            );
            await game.ensureAdd(unicorn);
          },
          verify: (game, tester) async {
            final unicorn = game.descendants().whereType<Unicorn>().first;

            unicorn.enjoymentFactor = 0.5;

            await tester.tapAt(Offset.zero);

            expect(unicorn.enjoymentFactor, enjoymentResult);

            await tester.pump(PetBehavior.petThrottleDuration);
          },
        );
      }
    });

    group('has a throttle time', () {
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
            ],
          );
          await game.ensureAdd(unicorn);
        },
        verify: (game, tester) async {
          final unicorn = game.descendants().whereType<Unicorn>().first;

          unicorn.enjoymentFactor = 0.5;

          // Give it the first pet
          await tester.tapAt(Offset.zero);
          expect(unicorn.enjoymentFactor, 0.7);

          // Do not wait full throttle time, pet again
          await tester.pump(
            Duration(
              seconds: (PetBehavior.petThrottleDuration.inSeconds / 2).floor(),
            ),
          );
          await tester.tapAt(Offset.zero);
          expect(unicorn.enjoymentFactor, 0.7);

          // Await for the rest of the hrottle time, pet again
          await tester.pump(
            Duration(
              seconds: (PetBehavior.petThrottleDuration.inSeconds / 2).ceil(),
            ),
          );
          await tester.tapAt(Offset.zero);
          expect(
            unicorn.enjoymentFactor,
            closeTo(0.9, precisionErrorTolerance),
          );

          await tester.pump(PetBehavior.petThrottleDuration);
        },
      );
    });
  });
}
