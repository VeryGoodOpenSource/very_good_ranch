// ignore_for_file: cascade_invocations

import 'package:flame/components.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_ranch/game/entities/unicorn/behaviors/behaviors.dart';
import 'package:very_good_ranch/game/entities/unicorn/stages.dart';
import 'package:very_good_ranch/game/entities/unicorn/unicorn.dart';
import 'package:very_good_ranch/game/game.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final flameTester = FlameTester(VeryGoodRanchGame.new);

  group('Evolution Behavior', () {
    group('evolves the unicorn every 10 seconds', () {
      flameTester.test('from baby to kid', (game) async {
        final evolutionBehavior = EvolutionBehavior();

        final unicorn = Unicorn.test(position: Vector2.zero());
        await game.ready();
        await game.ensureAdd(unicorn);
        await unicorn.ensureAdd(evolutionBehavior);

        expect(evolutionBehavior.currentStage, isA<BabyUnicornStage>());
        evolutionBehavior.currentStage.timesFed = 100;

        await game.ready();
        game.update(10);
        await game.ready();

        expect(evolutionBehavior.currentStage, isA<KidUnicornStage>());
      });

      flameTester.test('from kid to teenager', (game) async {
        final evolutionBehavior = EvolutionBehavior.withInitialStage(
          KidUnicornStage(),
        );

        final unicorn = Unicorn.test(position: Vector2.zero());
        await game.ready();
        await game.ensureAdd(unicorn);
        await unicorn.ensureAdd(evolutionBehavior);
        await game.ready();

        expect(evolutionBehavior.currentStage, isA<KidUnicornStage>());
        evolutionBehavior.currentStage.timesFed = 100;

        await game.ready();
        game.update(10);
        await game.ready();

        expect(evolutionBehavior.currentStage, isA<TeenagerUnicornStage>());
      });

      flameTester.test('from teenager to adult', (game) async {
        final evolutionBehavior = EvolutionBehavior.withInitialStage(
          TeenagerUnicornStage(),
        );

        final unicorn = Unicorn(position: Vector2.zero());
        await game.ready();
        await game.ensureAdd(unicorn);
        await unicorn.ensureAdd(evolutionBehavior);
        game.update(5);

        expect(evolutionBehavior.currentStage, isA<TeenagerUnicornStage>());
        evolutionBehavior.currentStage.timesFed = 100;

        await game.ready();
        game.update(10);
        await game.ready();

        expect(evolutionBehavior.currentStage, isA<AdultUnicornStage>());
      });

      flameTester.test(
        'stops evolution when reaches the adult stage',
        (game) async {
          final evolutionBehavior = EvolutionBehavior.withInitialStage(
            AdultUnicornStage(),
          );

          final unicorn = Unicorn(position: Vector2.zero());
          await game.ready();
          await game.ensureAdd(unicorn);
          await unicorn.ensureAdd(evolutionBehavior);

          expect(evolutionBehavior.currentStage, isA<AdultUnicornStage>());
          evolutionBehavior.currentStage.timesFed = 100;

          await game.ready();
          game.update(10);
          await game.ready();

          expect(evolutionBehavior.currentStage, isA<AdultUnicornStage>());
        },
      );
    });
  });
}
