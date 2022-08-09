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

  group('FullnessDecreasingBehavior', () {
    group('decreases fullness', () {
      flameTester.test('for a baby unicorn', (game) async {
        final fullnessDecreasingBehavior = FullnessDecreasingBehavior();
        final unicorn = Unicorn.test(
          position: Vector2.zero(),
          unicornComponent: BabyUnicornComponent(),
          behaviors: [
            fullnessDecreasingBehavior,
          ],
        );
        await game.ensureAdd(unicorn);

        expect(unicorn.fullness.value, 1.0);
        game.update(FullnessDecreasingBehavior.decreaseInterval);
        expect(unicorn.fullness.value, 0.9);
      });

      flameTester.test('for a child unicorn', (game) async {
        final fullnessDecreasingBehavior = FullnessDecreasingBehavior();
        final unicorn = Unicorn.test(
          position: Vector2.zero(),
          unicornComponent: ChildUnicornComponent(),
          behaviors: [
            fullnessDecreasingBehavior,
          ],
        );
        await game.ensureAdd(unicorn);

        expect(unicorn.fullness.value, 1.0);
        game.update(FullnessDecreasingBehavior.decreaseInterval);
        expect(unicorn.fullness.value, 0.9);
      });

      flameTester.test('for a teenager unicorn', (game) async {
        final fullnessDecreasingBehavior = FullnessDecreasingBehavior();
        final unicorn = Unicorn.test(
          position: Vector2.zero(),
          unicornComponent: TeenUnicornComponent(),
          behaviors: [
            fullnessDecreasingBehavior,
          ],
        );
        await game.ensureAdd(unicorn);

        expect(unicorn.fullness.value, 1.0);
        game.update(FullnessDecreasingBehavior.decreaseInterval);
        expect(unicorn.fullness.value, 0.8);
      });

      flameTester.test('for an adult unicorn', (game) async {
        final fullnessDecreasingBehavior = FullnessDecreasingBehavior();
        final unicorn = Unicorn.test(
          position: Vector2.zero(),
          unicornComponent: AdultUnicornComponent(),
          behaviors: [
            fullnessDecreasingBehavior,
          ],
        );
        await game.ensureAdd(unicorn);

        expect(unicorn.fullness.value, 1.0);
        game.update(FullnessDecreasingBehavior.decreaseInterval);
        expect(unicorn.fullness.value, 0.7);
      });
    });

    group('renders a gauge', () {
      flameTester.testGameWidget(
        'with the right color and size',
        setUp: (game, tester) async {
          final fullnessDecreasingBehavior = FullnessDecreasingBehavior();

          final unicorn = Unicorn.test(
            position: Vector2.all(100),
            behaviors: [
              fullnessDecreasingBehavior,
            ],
          );
          await game.ensureAdd(unicorn);
          unicorn.fullness.value = 1.0;
          fullnessDecreasingBehavior.makeGaugeTemporarilyVisible();
        },
        verify: (game, tester) async {
          final fullnessDecreasingBehavior =
              game.descendants().whereType<FullnessDecreasingBehavior>().first;
          final unicorn = game.descendants().whereType<Unicorn>().first;
          expect(
            fullnessDecreasingBehavior.gaugeComponent.diameter,
            unicorn.size.x + FullnessDecreasingBehavior.innerSpacing,
          );
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
