// ignore_for_file: cascade_invocations

import 'package:flame/components.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:very_good_ranch/game/entities/unicorn/behaviors/behaviors.dart';
import 'package:very_good_ranch/game/entities/unicorn/unicorn.dart';
import 'package:very_good_ranch/game/game.dart';

import '../../../../helpers/helpers.dart';

class _MockEvolutionBehavior extends Mock implements EvolutionBehavior {}

class _MockLeavingBehavior extends Mock implements LeavingBehavior {}

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
      debugMode: false,
    ),
  );

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

        expect(unicorn.enjoymentFactor, 1.0);
        game.update(EnjoymentBehavior.decreaseInterval);
        expect(unicorn.enjoymentFactor, 0.7);
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

        expect(unicorn.enjoymentFactor, 1.0);
        game.update(EnjoymentBehavior.decreaseInterval);
        expect(unicorn.enjoymentFactor, 0.8);
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

        expect(unicorn.enjoymentFactor, 1.0);
        game.update(EnjoymentBehavior.decreaseInterval);
        expect(unicorn.enjoymentFactor, 0.9);
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

        expect(unicorn.enjoymentFactor, 1.0);
        game.update(EnjoymentBehavior.decreaseInterval);
        expect(unicorn.enjoymentFactor, 0.9);
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
          unicorn.fullnessFactor = 1.0;
        },
        verify: (game, tester) async {
          await expectLater(
            find.byGame<VeryGoodRanchGame>(),
            matchesGoldenFile(
              'golden/enjoyment/has-gauge.png',
            ),
          );
        },
      );
    });
  });
}
