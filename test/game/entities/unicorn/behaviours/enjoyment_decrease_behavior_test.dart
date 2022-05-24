// ignore_for_file: cascade_invocations

import 'package:flame/components.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:very_good_ranch/game/entities/unicorn/behaviors/behaviors.dart';
import 'package:very_good_ranch/game/entities/unicorn/unicorn.dart';
import 'package:very_good_ranch/game/game.dart';

import '../../../../helpers/helpers.dart';

class _MockEvolutionBehavior extends Mock implements EvolutionBehavior {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late GameBloc gameBloc;

  setUp(() {
    gameBloc = MockGameBloc();
    when(() => gameBloc.state).thenReturn(const GameState());
  });

  final flameTester = FlameTester<VeryGoodRanchGame>(
    () => VeryGoodRanchGame(
      gameBloc: gameBloc,
      inventoryBloc: MockInventoryBloc(),
    ),
  );

  group('EnjoymentDecreaseBehavior', () {
    group('decreases enjoyment', () {
      flameTester.test('for a baby unicorn', (game) async {
        final evolutionBehavior = _MockEvolutionBehavior();
        when(() => evolutionBehavior.currentStage)
            .thenReturn(UnicornStage.teenager);

        final enjoymentDecreaseBehavior = EnjoymentDecreaseBehavior();
        final unicorn = Unicorn.test(
          position: Vector2.zero(),
          behaviors: [
            evolutionBehavior,
            enjoymentDecreaseBehavior,
          ],
        );
        await game.ensureAdd(unicorn);

        when(() => evolutionBehavior.currentStage)
            .thenReturn(UnicornStage.baby);

        expect(unicorn.enjoymentFactor, closeTo(1.0, precisionErrorTolerance));
        game.update(EnjoymentDecreaseBehavior.decreaseInterval);
        expect(unicorn.enjoymentFactor, closeTo(0.7, precisionErrorTolerance));
      });

      flameTester.test('for a kid unicorn', (game) async {
        final evolutionBehavior = _MockEvolutionBehavior();
        when(() => evolutionBehavior.currentStage)
            .thenReturn(UnicornStage.teenager);

        final enjoymentDecreaseBehavior = EnjoymentDecreaseBehavior();
        final unicorn = Unicorn.test(
          position: Vector2.zero(),
          behaviors: [
            evolutionBehavior,
            enjoymentDecreaseBehavior,
          ],
        );
        await game.ensureAdd(unicorn);
        when(() => evolutionBehavior.currentStage).thenReturn(UnicornStage.kid);

        expect(unicorn.enjoymentFactor, closeTo(1.0, precisionErrorTolerance));
        game.update(EnjoymentDecreaseBehavior.decreaseInterval);
        expect(unicorn.enjoymentFactor, closeTo(0.8, precisionErrorTolerance));
      });

      flameTester.test('for a teenager unicorn', (game) async {
        final evolutionBehavior = _MockEvolutionBehavior();
        when(() => evolutionBehavior.currentStage)
            .thenReturn(UnicornStage.teenager);

        final enjoymentDecreaseBehavior = EnjoymentDecreaseBehavior();
        final unicorn = Unicorn.test(
          position: Vector2.zero(),
          behaviors: [
            evolutionBehavior,
            enjoymentDecreaseBehavior,
          ],
        );
        await game.ensureAdd(unicorn);

        expect(unicorn.enjoymentFactor, closeTo(1.0, precisionErrorTolerance));
        game.update(EnjoymentDecreaseBehavior.decreaseInterval);
        expect(unicorn.enjoymentFactor, closeTo(0.9, precisionErrorTolerance));
      });

      flameTester.test('for an adult unicorn', (game) async {
        final evolutionBehavior = _MockEvolutionBehavior();
        when(() => evolutionBehavior.currentStage)
            .thenReturn(UnicornStage.adult);

        final enjoymentDecreaseBehavior = EnjoymentDecreaseBehavior();
        final unicorn = Unicorn.test(
          position: Vector2.zero(),
          behaviors: [
            evolutionBehavior,
            enjoymentDecreaseBehavior,
          ],
        );
        await game.ensureAdd(unicorn);

        expect(unicorn.enjoymentFactor, closeTo(1.0, precisionErrorTolerance));
        game.update(EnjoymentDecreaseBehavior.decreaseInterval);
        expect(unicorn.enjoymentFactor, closeTo(0.9, precisionErrorTolerance));
      });
    });
  });
}
