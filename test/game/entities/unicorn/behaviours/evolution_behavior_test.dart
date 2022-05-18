// ignore_for_file: cascade_invocations

import 'package:flame/components.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_ranch/game/entities/unicorn/behaviors/behaviors.dart';
import 'package:very_good_ranch/game/entities/unicorn/unicorn.dart';
import 'package:very_good_ranch/game/game.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final flameTester = FlameTester(VeryGoodRanchGame.new);

  group('Evolution Behavior', () {
    group('evolves the unicorn', () {
      flameTester.test('from baby to kid', (game) async {
        final evolutionBehavior = EvolutionBehavior();

        final unicorn = Unicorn.test(position: Vector2.zero());
        await game.ready();
        await game.ensureAdd(unicorn);
        await unicorn.ensureAdd(evolutionBehavior);

        expect(evolutionBehavior.currentStage, UnicornStage.baby);
        unicorn.timesFed = 100;

        await game.ready();
        game.update(10);
        await game.ready();

        expect(evolutionBehavior.currentStage, UnicornStage.kid);
      });

      flameTester.test('from kid to teenager', (game) async {
        final evolutionBehavior =
            EvolutionBehavior.withInitialStage(UnicornStage.kid);

        final unicorn = Unicorn.test(position: Vector2.zero());
        await game.ready();
        await game.ensureAdd(unicorn);
        await unicorn.ensureAdd(evolutionBehavior);
        await game.ready();

        expect(evolutionBehavior.currentStage, UnicornStage.kid);
        unicorn.timesFed = 100;

        await game.ready();
        game.update(10);
        await game.ready();

        expect(evolutionBehavior.currentStage, UnicornStage.teenager);
      });

      flameTester.test('from teenager to adult', (game) async {
        final evolutionBehavior =
            EvolutionBehavior.withInitialStage(UnicornStage.teenager);

        final unicorn = Unicorn(position: Vector2.zero());
        await game.ready();
        await game.ensureAdd(unicorn);
        await unicorn.ensureAdd(evolutionBehavior);
        game.update(5);

        expect(evolutionBehavior.currentStage, UnicornStage.teenager);
        unicorn.timesFed = 100;

        await game.ready();
        game.update(10);
        await game.ready();

        expect(evolutionBehavior.currentStage, UnicornStage.adult);
      });

      flameTester.test(
        'stops evolution when reaches the adult stage',
        (game) async {
          final evolutionBehavior =
              EvolutionBehavior.withInitialStage(UnicornStage.adult);

          final unicorn = Unicorn(position: Vector2.zero());
          await game.ready();
          await game.ensureAdd(unicorn);
          await unicorn.ensureAdd(evolutionBehavior);

          expect(evolutionBehavior.currentStage, UnicornStage.adult);
          unicorn.timesFed = 100;

          await game.ready();
          game.update(10);
          await game.ready();

          expect(evolutionBehavior.currentStage, UnicornStage.adult);
        },
      );

      flameTester.test(
        'stops evolution when the unicorn is not fed enough',
        (game) async {
          final evolutionBehavior =
              EvolutionBehavior.withInitialStage(UnicornStage.kid);

          final unicorn = Unicorn(position: Vector2.zero());
          await game.ready();
          await game.ensureAdd(unicorn);
          await unicorn.ensureAdd(evolutionBehavior);

          expect(evolutionBehavior.currentStage, UnicornStage.kid);
          unicorn.timesFed = 0;

          await game.ready();
          game.update(10);
          await game.ready();

          expect(evolutionBehavior.currentStage, UnicornStage.kid);
        },
      );

      flameTester.test(
        'stops evolution when the unicorn is not happy enough',
        (game) async {
          final evolutionBehavior =
              EvolutionBehavior.withInitialStage(UnicornStage.kid);

          final unicorn = Unicorn(position: Vector2.zero());
          await game.ready();
          await game.ensureAdd(unicorn);
          await unicorn.ensureAdd(evolutionBehavior);

          expect(evolutionBehavior.currentStage, UnicornStage.kid);
          unicorn.timesFed = 1;
          unicorn.enjoymentFactor = 0;

          await game.ready();
          game.update(10);
          await game.ready();

          expect(evolutionBehavior.currentStage, UnicornStage.kid);
        },
      );
    });
  });
}
