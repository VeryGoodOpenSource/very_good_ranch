// ignore_for_file: cascade_invocations

import 'package:flame/components.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_ranch/game/entities/unicorn/behaviors/behaviors.dart';
import 'package:very_good_ranch/game/entities/unicorn/unicorn.dart';
import 'package:very_good_ranch/game/game.dart';

import '../../../../helpers/helpers.dart';

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

  group('Evolution Behavior', () {
    group('evolves the unicorn', () {
      flameTester.test('from baby to kid', (game) async {
        final evolutionBehavior = EvolutionBehavior();

        final unicorn = Unicorn.customBehaviors(
          position: Vector2.zero(),
          behaviors: [
            evolutionBehavior,
          ],
        );
        await game.ready();
        await game.ensureAdd(unicorn);

        expect(evolutionBehavior.currentStage, UnicornStage.baby);
        unicorn.timesFed = EvolutionBehavior.timesThatMustBeFed;

        game.update(0);

        expect(evolutionBehavior.currentStage, UnicornStage.kid);
      });

      flameTester.test('from kid to teenager', (game) async {
        final evolutionBehavior =
            EvolutionBehavior.withInitialStage(UnicornStage.kid);

        final unicorn = Unicorn.customBehaviors(
          position: Vector2.zero(),
          behaviors: [
            evolutionBehavior,
          ],
        );
        await game.ready();
        await game.ensureAdd(unicorn);
        await game.ready();

        expect(evolutionBehavior.currentStage, UnicornStage.kid);
        unicorn.timesFed = EvolutionBehavior.timesThatMustBeFed;

        game.update(0);

        expect(evolutionBehavior.currentStage, UnicornStage.teenager);
      });

      flameTester.test('from teenager to adult', (game) async {
        final evolutionBehavior = EvolutionBehavior.withInitialStage(
          UnicornStage.teenager,
        );

        final unicorn = Unicorn.customBehaviors(
          position: Vector2.zero(),
          behaviors: [
            evolutionBehavior,
          ],
        );
        await game.ready();
        await game.ensureAdd(unicorn);
        game.update(5);

        expect(evolutionBehavior.currentStage, UnicornStage.teenager);
        unicorn.timesFed = EvolutionBehavior.timesThatMustBeFed;

        game.update(0);

        expect(evolutionBehavior.currentStage, UnicornStage.adult);
      });

      flameTester.test(
        'stops evolution when reaches the adult stage',
        (game) async {
          final evolutionBehavior =
              EvolutionBehavior.withInitialStage(UnicornStage.adult);

          final unicorn = Unicorn.customBehaviors(
            position: Vector2.zero(),
            behaviors: [
              evolutionBehavior,
            ],
          );
          await game.ready();
          await game.ensureAdd(unicorn);

          expect(evolutionBehavior.currentStage, UnicornStage.adult);
          unicorn.timesFed = EvolutionBehavior.timesThatMustBeFed;

          game.update(0);

          expect(evolutionBehavior.currentStage, UnicornStage.adult);
        },
      );

      flameTester.test(
        'stops evolution when the unicorn is not fed enough',
        (game) async {
          final evolutionBehavior =
              EvolutionBehavior.withInitialStage(UnicornStage.kid);

          final unicorn = Unicorn.customBehaviors(
            position: Vector2.zero(),
            behaviors: [
              evolutionBehavior,
            ],
          );
          await game.ready();
          await game.ensureAdd(unicorn);

          expect(evolutionBehavior.currentStage, UnicornStage.kid);
          unicorn.timesFed = 0;

          game.update(0);

          expect(evolutionBehavior.currentStage, UnicornStage.kid);
        },
      );

      flameTester.test(
        'stops evolution when the unicorn is not happy enough',
        (game) async {
          final evolutionBehavior =
              EvolutionBehavior.withInitialStage(UnicornStage.kid);

          final unicorn = Unicorn.customBehaviors(
            position: Vector2.zero(),
            behaviors: [
              evolutionBehavior,
            ],
          );
          await game.ready();
          await game.ensureAdd(unicorn);

          expect(evolutionBehavior.currentStage, UnicornStage.kid);
          unicorn.timesFed = 1;
          unicorn.enjoymentFactor = 0;

          game.update(0);

          expect(evolutionBehavior.currentStage, UnicornStage.kid);
        },
      );
    });

    group('on evolution', () {
      flameTester.test(
        'resets enjoyment and fullness factors to full',
        (game) async {
          final evolutionBehavior =
              EvolutionBehavior.withInitialStage(UnicornStage.kid);

          final unicorn = Unicorn.customBehaviors(
            position: Vector2.zero(),
            behaviors: [
              evolutionBehavior,
            ],
          );
          await game.ready();
          await game.ensureAdd(unicorn);

          expect(evolutionBehavior.currentStage, UnicornStage.kid);
          unicorn.timesFed = EvolutionBehavior.timesThatMustBeFed;

          // Setting happiness to above the threshold, but not full
          unicorn.enjoymentFactor = 0.95;
          unicorn.fullnessFactor = 0.95;

          game.update(0);

          expect(evolutionBehavior.currentStage, UnicornStage.teenager);
          expect(unicorn.enjoymentFactor, 1.0);
          expect(unicorn.fullnessFactor, 1.0);
        },
      );
    });
  });
}
