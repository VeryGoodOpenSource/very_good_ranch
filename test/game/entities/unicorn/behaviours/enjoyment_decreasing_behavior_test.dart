// ignore_for_file: cascade_invocations

import 'package:flame/components.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ranch_components/ranch_components.dart';
import 'package:very_good_ranch/config.dart';
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
        game.update(Config.enjoymentDecreaseInterval);
        expect(unicorn.enjoyment.value, 0.99);
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
        game.update(Config.enjoymentDecreaseInterval);
        expect(unicorn.enjoyment.value, 0.995);
      });

      flameTester.test('for a teen unicorn', (game) async {
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
        game.update(Config.enjoymentDecreaseInterval);
        expect(unicorn.enjoyment.value, 0.997);
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
        game.update(Config.enjoymentDecreaseInterval);
        expect(unicorn.enjoyment.value, 0.9985);
      });
    });
  });
}
