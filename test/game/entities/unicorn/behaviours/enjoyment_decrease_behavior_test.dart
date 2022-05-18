// ignore_for_file: cascade_invocations

import 'package:flame/components.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:very_good_ranch/game/entities/unicorn/behaviors/behaviors.dart';
import 'package:very_good_ranch/game/entities/unicorn/unicorn.dart';
import 'package:very_good_ranch/game/very_good_ranch_game.dart';

class _MockEvolutionBehavior extends Mock implements EvolutionBehavior {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final flameTester = FlameTester(VeryGoodRanchGame.new);

  group('EnjoymentDecreaseBehavior', () {
    group('decreases enjoyment', () {
      flameTester.test('for a baby unicorn', (game) async {
        final evolutionBehavior = _MockEvolutionBehavior();
        when(() => evolutionBehavior.currentStage)
            .thenReturn(UnicornStage.teenager);

        final enjoymentDecreaseBehavior = EnjoymentDecreaseBehavior();
        final unicorn = Unicorn.test(
          position: Vector2.zero(),
          evolutionBehavior: evolutionBehavior,
        );
        await game.ensureAdd(unicorn);
        await unicorn.ensureAdd(enjoymentDecreaseBehavior);
        when(() => evolutionBehavior.currentStage)
            .thenReturn(UnicornStage.baby);

        expect(unicorn.enjoymentFactor, 1.0);
        game.update(EnjoymentDecreaseBehavior.decreaseInterval);
        expect(unicorn.enjoymentFactor, 0.7);
      });

      flameTester.test('for a kid unicorn', (game) async {
        final evolutionBehavior = _MockEvolutionBehavior();
        when(() => evolutionBehavior.currentStage)
            .thenReturn(UnicornStage.teenager);

        final enjoymentDecreaseBehavior = EnjoymentDecreaseBehavior();
        final unicorn = Unicorn.test(
          position: Vector2.zero(),
          evolutionBehavior: evolutionBehavior,
        );
        await game.ensureAdd(unicorn);
        await unicorn.ensureAdd(enjoymentDecreaseBehavior);
        when(() => evolutionBehavior.currentStage).thenReturn(UnicornStage.kid);

        expect(unicorn.enjoymentFactor, 1.0);
        game.update(EnjoymentDecreaseBehavior.decreaseInterval);
        expect(unicorn.enjoymentFactor, 0.8);
      });

      flameTester.test('for a teenager unicorn', (game) async {
        final evolutionBehavior = _MockEvolutionBehavior();
        when(() => evolutionBehavior.currentStage)
            .thenReturn(UnicornStage.teenager);

        final enjoymentDecreaseBehavior = EnjoymentDecreaseBehavior();
        final unicorn = Unicorn.test(
          position: Vector2.zero(),
          evolutionBehavior: evolutionBehavior,
        );
        await game.ensureAdd(unicorn);
        await unicorn.ensureAdd(enjoymentDecreaseBehavior);

        expect(unicorn.enjoymentFactor, 1.0);
        game.update(EnjoymentDecreaseBehavior.decreaseInterval);
        expect(unicorn.enjoymentFactor, 0.9);
      });

      flameTester.test('for an adult unicorn', (game) async {
        final evolutionBehavior = _MockEvolutionBehavior();
        when(() => evolutionBehavior.currentStage)
            .thenReturn(UnicornStage.adult);

        final enjoymentDecreaseBehavior = EnjoymentDecreaseBehavior();
        final unicorn = Unicorn.test(
          position: Vector2.zero(),
          evolutionBehavior: evolutionBehavior,
        );
        await game.ensureAdd(unicorn);
        await unicorn.ensureAdd(enjoymentDecreaseBehavior);

        expect(unicorn.enjoymentFactor, 1.0);
        game.update(EnjoymentDecreaseBehavior.decreaseInterval);
        expect(unicorn.enjoymentFactor, 0.9);
      });
    });
  });
}
