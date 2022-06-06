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

  group('FullnessBehavior', () {
    group('decreases fullness', () {
      flameTester.test('for a baby unicorn', (game) async {
        final evolutionBehavior = _MockEvolutionBehavior();
        when(() => evolutionBehavior.currentStage)
            .thenReturn(UnicornStage.baby);

        final fullnessBehavior = FullnessBehavior();
        final unicorn = Unicorn.test(
          position: Vector2.zero(),
          behaviors: [
            evolutionBehavior,
            fullnessBehavior,
          ],
        );
        await game.ensureAdd(unicorn);

        expect(fullnessBehavior.percentage, 1.0);
        game.update(FullnessBehavior.decreaseInterval);
        expect(fullnessBehavior.percentage, 0.9);
      });

      flameTester.test('for a kid unicorn', (game) async {
        final evolutionBehavior = _MockEvolutionBehavior();
        when(() => evolutionBehavior.currentStage)
            .thenReturn(UnicornStage.child);

        final fullnessBehavior = FullnessBehavior();
        final unicorn = Unicorn.test(
          position: Vector2.zero(),
          behaviors: [
            evolutionBehavior,
            fullnessBehavior,
          ],
        );
        await game.ensureAdd(unicorn);

        expect(fullnessBehavior.percentage, 1.0);
        game.update(FullnessBehavior.decreaseInterval);
        expect(fullnessBehavior.percentage, 0.9);
      });

      flameTester.test('for a teenager unicorn', (game) async {
        final evolutionBehavior = _MockEvolutionBehavior();
        when(() => evolutionBehavior.currentStage)
            .thenReturn(UnicornStage.teen);

        final fullnessBehavior = FullnessBehavior();
        final unicorn = Unicorn.test(
          position: Vector2.zero(),
          behaviors: [
            evolutionBehavior,
            fullnessBehavior,
          ],
        );
        await game.ensureAdd(unicorn);

        expect(fullnessBehavior.percentage, 1.0);
        game.update(FullnessBehavior.decreaseInterval);
        expect(fullnessBehavior.percentage, 0.8);
      });

      flameTester.test('for an adult unicorn', (game) async {
        final evolutionBehavior = _MockEvolutionBehavior();
        when(() => evolutionBehavior.currentStage)
            .thenReturn(UnicornStage.adult);

        final fullnessBehavior = FullnessBehavior();
        final unicorn = Unicorn.test(
          position: Vector2.zero(),
          behaviors: [
            evolutionBehavior,
            fullnessBehavior,
          ],
        );
        await game.ensureAdd(unicorn);

        expect(fullnessBehavior.percentage, 1.0);
        game.update(FullnessBehavior.decreaseInterval);
        expect(fullnessBehavior.percentage, 0.7);
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

          final fullnessBehavior = FullnessBehavior();

          final unicorn = Unicorn.test(
            position: Vector2.all(100),
            behaviors: [
              evolutionBehavior,
              leavingBehavior,
              fullnessBehavior,
            ],
          );
          await game.ensureAdd(unicorn);
          fullnessBehavior.percentage = 1.0;
          fullnessBehavior.makeGaugeTemporarilyVisible();
        },
        verify: (game, tester) async {
          await expectLater(
            find.byGame<TestGame>(),
            matchesGoldenFile(
              'golden/fullness/has-gauge.png',
            ),
          );
        },
      );
    });
  });
}
