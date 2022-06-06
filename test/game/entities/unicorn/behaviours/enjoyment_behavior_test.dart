// ignore_for_file: cascade_invocations

import 'package:flame/components.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:very_good_ranch/game/entities/unicorn/behaviors/behaviors.dart';
import 'package:very_good_ranch/game/entities/unicorn/unicorn.dart';

import '../../../../helpers/helpers.dart';

class _MockEvolutionBehavior extends Mock implements EvolutionBehavior {}

class _MockLeavingBehavior extends Mock implements LeavingBehavior {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final flameTester = FlameTester<TestGame>(TestGame.new);

  group('EnjoymentBehavior', () {
    group('decreases enjoyment', () {
      flameTester.test('for a baby unicorn', (game) async {
        final evolutionBehavior = _MockEvolutionBehavior();
        when(() => evolutionBehavior.currentStage)
            .thenReturn(UnicornStage.teenager);

        final enjoymentBehavior = EnjoymentBehavior();
        final unicorn = Unicorn.test(
          position: Vector2.zero(),
          behaviors: [
            evolutionBehavior,
            enjoymentBehavior,
          ],
        );
        await game.ensureAdd(unicorn);

        when(() => evolutionBehavior.currentStage)
            .thenReturn(UnicornStage.baby);

        expect(enjoymentBehavior.percentage, 1.0);
        game.update(EnjoymentBehavior.decreaseInterval);
        expect(enjoymentBehavior.percentage, 0.7);
      });

      flameTester.test('for a kid unicorn', (game) async {
        final evolutionBehavior = _MockEvolutionBehavior();
        when(() => evolutionBehavior.currentStage)
            .thenReturn(UnicornStage.teenager);

        final enjoymentBehavior = EnjoymentBehavior();
        final unicorn = Unicorn.test(
          position: Vector2.zero(),
          behaviors: [
            evolutionBehavior,
            enjoymentBehavior,
          ],
        );
        await game.ensureAdd(unicorn);
        when(() => evolutionBehavior.currentStage).thenReturn(UnicornStage.kid);

        expect(enjoymentBehavior.percentage, 1.0);
        game.update(EnjoymentBehavior.decreaseInterval);
        expect(enjoymentBehavior.percentage, 0.8);
      });

      flameTester.test('for a teenager unicorn', (game) async {
        final evolutionBehavior = _MockEvolutionBehavior();
        when(() => evolutionBehavior.currentStage)
            .thenReturn(UnicornStage.teenager);

        final enjoymentBehavior = EnjoymentBehavior();
        final unicorn = Unicorn.test(
          position: Vector2.zero(),
          behaviors: [
            evolutionBehavior,
            enjoymentBehavior,
          ],
        );
        await game.ensureAdd(unicorn);

        expect(enjoymentBehavior.percentage, 1.0);
        game.update(EnjoymentBehavior.decreaseInterval);
        expect(enjoymentBehavior.percentage, 0.9);
      });

      flameTester.test('for an adult unicorn', (game) async {
        final evolutionBehavior = _MockEvolutionBehavior();
        when(() => evolutionBehavior.currentStage)
            .thenReturn(UnicornStage.adult);

        final enjoymentBehavior = EnjoymentBehavior();
        final unicorn = Unicorn.test(
          position: Vector2.zero(),
          behaviors: [
            evolutionBehavior,
            enjoymentBehavior,
          ],
        );
        await game.ensureAdd(unicorn);

        expect(enjoymentBehavior.percentage, 1.0);
        game.update(EnjoymentBehavior.decreaseInterval);
        expect(enjoymentBehavior.percentage, 0.9);
      });
    });

    group('renders a gauge', () {
      flameTester.testGameWidget(
        'with the right color and size',
        setUp: (game, tester) async {
          final evolutionBehavior = _MockEvolutionBehavior();
          when(() => evolutionBehavior.currentStage)
              .thenReturn(UnicornStage.adult);
          final leavingBehavior = _MockLeavingBehavior();
          when(() => leavingBehavior.isLeaving).thenReturn(false);

          final enjoymentBehavior = EnjoymentBehavior();

          final unicorn = Unicorn.test(
            position: Vector2.all(100),
            behaviors: [
              evolutionBehavior,
              leavingBehavior,
              enjoymentBehavior,
            ],
          );
          await game.ensureAdd(unicorn);
          enjoymentBehavior.percentage = 1.0;
          enjoymentBehavior.makeGaugeTemporarilyVisible();
        },
        verify: (game, tester) async {
          await expectLater(
            find.byGame<TestGame>(),
            matchesGoldenFile(
              'golden/enjoyment/has-gauge.png',
            ),
          );
        },
      );
    });
  });
}
