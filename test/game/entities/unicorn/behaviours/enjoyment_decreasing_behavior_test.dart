// ignore_for_file: cascade_invocations

import 'package:flame/components.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ranch_components/ranch_components.dart';
import 'package:very_good_ranch/game/entities/unicorn/behaviors/behaviors.dart';
import 'package:very_good_ranch/game/entities/unicorn/unicorn.dart';

import '../../../../helpers/helpers.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final flameTester = FlameTester<TestGame>(TestGame.new);

  group('EnjoymentDecreasingBehavior', () {
    group('decreases enjoyment', () {
      flameTester.test('for a baby unicorn', (game) async {
        final enjoymentDecreasingBehavior = EnjoymentDecreasingBehavior();
        final unicorn = Unicorn.test(
          position: Vector2.zero(),
          unicornComponent: BabyUnicornComponent(),
          behaviors: [
            enjoymentDecreasingBehavior,
          ],
        );
        await game.ensureAdd(unicorn);

        expect(unicorn.enjoyment.value, 1.0);
        game.update(EnjoymentDecreasingBehavior.decreaseInterval);
        expect(unicorn.enjoyment.value, 0.7);
      });

      flameTester.test('for a child unicorn', (game) async {
        final enjoymentDecreasingBehavior = EnjoymentDecreasingBehavior();
        final unicorn = Unicorn.test(
          position: Vector2.zero(),
          unicornComponent: ChildUnicornComponent(),
          behaviors: [
            enjoymentDecreasingBehavior,
          ],
        );
        await game.ensureAdd(unicorn);

        expect(unicorn.enjoyment.value, 1.0);
        game.update(EnjoymentDecreasingBehavior.decreaseInterval);
        expect(unicorn.enjoyment.value, 0.8);
      });

      flameTester.test('for a teenager unicorn', (game) async {
        final enjoymentDecreasingBehavior = EnjoymentDecreasingBehavior();
        final unicorn = Unicorn.test(
          position: Vector2.zero(),
          unicornComponent: TeenUnicornComponent(),
          behaviors: [
            enjoymentDecreasingBehavior,
          ],
        );
        await game.ensureAdd(unicorn);

        expect(unicorn.enjoyment.value, 1.0);
        game.update(EnjoymentDecreasingBehavior.decreaseInterval);
        expect(unicorn.enjoyment.value, 0.9);
      });

      flameTester.test('for an adult unicorn', (game) async {
        final enjoymentDecreasingBehavior = EnjoymentDecreasingBehavior();
        final unicorn = Unicorn.test(
          position: Vector2.zero(),
          unicornComponent: AdultUnicornComponent(),
          behaviors: [
            enjoymentDecreasingBehavior,
          ],
        );
        await game.ensureAdd(unicorn);

        expect(unicorn.enjoyment.value, 1.0);
        game.update(EnjoymentDecreasingBehavior.decreaseInterval);
        expect(unicorn.enjoyment.value, 0.9);
      });
    });

    group('renders a gauge', () {
      flameTester.testGameWidget(
        'with the right color and size',
        setUp: (game, tester) async {
          final enjoymentDecreasingBehavior = EnjoymentDecreasingBehavior();

          final unicorn = Unicorn.test(
            position: Vector2.all(100),
            behaviors: [
              enjoymentDecreasingBehavior,
            ],
          );
          await game.ensureAdd(unicorn);
          unicorn.isLeaving = true;
          unicorn.enjoyment.value = 1.0;
          enjoymentDecreasingBehavior.makeGaugeTemporarilyVisible();
        },
        verify: (game, tester) async {
          final enjoymentDecreasingBehavior =
              game.descendants().whereType<EnjoymentDecreasingBehavior>().first;
          final unicorn = game.descendants().whereType<Unicorn>().first;
          expect(
            enjoymentDecreasingBehavior.gaugeComponent.diameter,
            unicorn.size.x + EnjoymentDecreasingBehavior.innerSpacing,
          );
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
