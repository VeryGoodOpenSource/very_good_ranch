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

  group('FullnessDecreaseBehavior', () {
    group('decreases fullness', () {
      flameTester.test('for a baby unicorn', (game) async {
        final evolutionBehavior = _MockEvolutionBehavior();
        when(() => evolutionBehavior.currentStage)
            .thenReturn(UnicornStage.teenager);

        final fullnessDecreaseBehavior = FullnessDecreaseBehavior();
        final unicorn = Unicorn.customBehaviors(
          position: Vector2.zero(),
          behaviors: [
            evolutionBehavior,
            fullnessDecreaseBehavior,
          ],
        );
        await game.ensureAdd(unicorn);
        when(() => evolutionBehavior.currentStage)
            .thenReturn(UnicornStage.baby);

        expect(unicorn.fullnessFactor, 1.0);
        game.update(FullnessDecreaseBehavior.decreaseInterval);
        expect(unicorn.fullnessFactor, 0.9);
      });

      flameTester.test('for a kid unicorn', (game) async {
        final evolutionBehavior = _MockEvolutionBehavior();
        when(() => evolutionBehavior.currentStage)
            .thenReturn(UnicornStage.teenager);

        final fullnessDecreaseBehavior = FullnessDecreaseBehavior();
        final unicorn = Unicorn.customBehaviors(
          position: Vector2.zero(),
          behaviors: [
            evolutionBehavior,
            fullnessDecreaseBehavior,
          ],
        );
        await game.ensureAdd(unicorn);

        when(() => evolutionBehavior.currentStage).thenReturn(UnicornStage.kid);

        expect(unicorn.fullnessFactor, 1.0);
        game.update(FullnessDecreaseBehavior.decreaseInterval);
        expect(unicorn.fullnessFactor, 0.9);
      });

      flameTester.test('for a teenager unicorn', (game) async {
        final evolutionBehavior = _MockEvolutionBehavior();
        when(() => evolutionBehavior.currentStage)
            .thenReturn(UnicornStage.teenager);

        final fullnessDecreaseBehavior = FullnessDecreaseBehavior();
        final unicorn = Unicorn.customBehaviors(
          position: Vector2.zero(),
          behaviors: [
            evolutionBehavior,
            fullnessDecreaseBehavior,
          ],
        );
        await game.ensureAdd(unicorn);

        expect(unicorn.fullnessFactor, 1.0);
        game.update(FullnessDecreaseBehavior.decreaseInterval);
        expect(unicorn.fullnessFactor, 0.8);
      });

      flameTester.test('for an adult unicorn', (game) async {
        final evolutionBehavior = _MockEvolutionBehavior();
        when(() => evolutionBehavior.currentStage)
            .thenReturn(UnicornStage.adult);

        final fullnessDecreaseBehavior = FullnessDecreaseBehavior();
        final unicorn = Unicorn.customBehaviors(
          position: Vector2.zero(),
          behaviors: [
            evolutionBehavior,
            fullnessDecreaseBehavior,
          ],
        );
        await game.ensureAdd(unicorn);

        expect(unicorn.fullnessFactor, 1.0);
        game.update(FullnessDecreaseBehavior.decreaseInterval);
        expect(unicorn.fullnessFactor, 0.7);
      });
    });
  });
}
