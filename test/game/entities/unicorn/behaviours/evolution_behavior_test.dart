// ignore_for_file: cascade_invocations

import 'package:flame/components.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ranch_components/ranch_components.dart';
import 'package:very_good_ranch/game/entities/unicorn/behaviors/behaviors.dart';
import 'package:very_good_ranch/game/entities/unicorn/unicorn.dart';
import 'package:very_good_ranch/game/game.dart';
import 'package:very_good_ranch/l10n/l10n.dart';

import '../../../../helpers/helpers.dart';

class _MockEnjoymentBehavior extends Mock implements EnjoymentBehavior {}

class _MockFullnessBehavior extends Mock implements FullnessBehavior {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late GameBloc gameBloc;
  late AppLocalizations l10n;

  setUp(() {
    gameBloc = MockGameBloc();
    when(() => gameBloc.state).thenReturn(const GameState());

    l10n = MockAppLocalizations();
    when(() => l10n.score).thenReturn('score');
  });

  final flameTester = FlameTester<VeryGoodRanchGame>(
    () => VeryGoodRanchGame(
      gameBloc: gameBloc,
      inventoryBloc: MockInventoryBloc(),
      l10n: l10n,
    ),
  );

  group('Evolution Behavior', () {
    group('evolves the unicorn', () {
      flameTester.test('from baby to kid', (game) async {
        final enjoymentBehavior = _MockEnjoymentBehavior();
        final fullnessBehavior = _MockFullnessBehavior();

        final evolutionBehavior = EvolutionBehavior();

        final unicorn = Unicorn.test(
          position: Vector2.zero(),
          behaviors: [
            enjoymentBehavior,
            fullnessBehavior,
            evolutionBehavior,
          ],
        );
        await game.ready();
        await game.ensureAdd(unicorn);

        expect(unicorn.evolutionStage, UnicornEvolutionStage.baby);
        unicorn.timesFed = EvolutionBehavior.timesThatMustBeFed;

        unicorn.enjoymentFactor = 1;
        unicorn.fullnessFactor = 1;

        game.update(0);

        expect(unicorn.evolutionStage, UnicornEvolutionStage.child);
        expect(unicorn.timesFed, 0);
      });

      flameTester.test('from kid to teenager', (game) async {
        final enjoymentBehavior = _MockEnjoymentBehavior();
        final fullnessBehavior = _MockFullnessBehavior();

        final evolutionBehavior = EvolutionBehavior();

        final unicorn = Unicorn.test(
          position: Vector2.zero(),
          unicornComponent: ChildUnicornComponent(),
          behaviors: [
            evolutionBehavior,
            enjoymentBehavior,
            fullnessBehavior,
          ],
        );
        await game.ready();
        await game.ensureAdd(unicorn);
        await game.ready();

        expect(unicorn.evolutionStage, UnicornEvolutionStage.child);
        unicorn.timesFed = EvolutionBehavior.timesThatMustBeFed;
        unicorn.enjoymentFactor = 1;
        unicorn.fullnessFactor = 1;

        game.update(0);

        expect(unicorn.evolutionStage, UnicornEvolutionStage.teen);
        expect(unicorn.timesFed, 0);
      });

      flameTester.test('from teenager to adult', (game) async {
        final enjoymentBehavior = _MockEnjoymentBehavior();
        final fullnessBehavior = _MockFullnessBehavior();

        final evolutionBehavior = EvolutionBehavior();

        final unicorn = Unicorn.test(
          position: Vector2.zero(),
          unicornComponent: TeenUnicornComponent(),
          behaviors: [
            evolutionBehavior,
            enjoymentBehavior,
            fullnessBehavior,
          ],
        );
        await game.ready();
        await game.ensureAdd(unicorn);
        game.update(5);

        expect(unicorn.evolutionStage, UnicornEvolutionStage.teen);
        unicorn.timesFed = EvolutionBehavior.timesThatMustBeFed;

        unicorn.enjoymentFactor = 1;
        unicorn.fullnessFactor = 1;

        game.update(0);

        expect(unicorn.evolutionStage, UnicornEvolutionStage.adult);
        expect(unicorn.timesFed, 0);
      });

      flameTester.test(
        'stops evolution when reaches the adult stage',
        (game) async {
          final enjoymentBehavior = _MockEnjoymentBehavior();
          final fullnessBehavior = _MockFullnessBehavior();

          final evolutionBehavior = EvolutionBehavior();

          final unicorn = Unicorn.test(
            position: Vector2.zero(),
            unicornComponent: AdultUnicornComponent(),
            behaviors: [
              evolutionBehavior,
              enjoymentBehavior,
              fullnessBehavior,
            ],
          );
          await game.ready();
          await game.ensureAdd(unicorn);

          expect(unicorn.evolutionStage, UnicornEvolutionStage.adult);
          unicorn.timesFed = EvolutionBehavior.timesThatMustBeFed;

          unicorn.enjoymentFactor = 1;
          unicorn.fullnessFactor = 1;

          game.update(0);

          expect(unicorn.evolutionStage, UnicornEvolutionStage.adult);
          expect(unicorn.timesFed, EvolutionBehavior.timesThatMustBeFed);
        },
      );

      flameTester.test(
        'stops evolution when the unicorn is not fed enough',
        (game) async {
          final enjoymentBehavior = _MockEnjoymentBehavior();
          final fullnessBehavior = _MockFullnessBehavior();

          final evolutionBehavior = EvolutionBehavior();

          final unicorn = Unicorn.test(
            position: Vector2.zero(),
            unicornComponent: ChildUnicornComponent(),
            behaviors: [
              evolutionBehavior,
              enjoymentBehavior,
              fullnessBehavior,
            ],
          );
          await game.ready();
          await game.ensureAdd(unicorn);

          expect(unicorn.evolutionStage, UnicornEvolutionStage.child);
          unicorn.timesFed = 0;

          unicorn.enjoymentFactor = 1;
          unicorn.fullnessFactor = 1;

          game.update(0);

          expect(unicorn.evolutionStage, UnicornEvolutionStage.child);
          expect(unicorn.timesFed, 0);
        },
      );

      flameTester.test(
        'stops evolution when the unicorn is not happy enough',
        (game) async {
          final enjoymentBehavior = _MockEnjoymentBehavior();
          final fullnessBehavior = _MockFullnessBehavior();

          final evolutionBehavior = EvolutionBehavior();

          final unicorn = Unicorn.test(
            position: Vector2.zero(),
            unicornComponent: ChildUnicornComponent(),
            behaviors: [
              evolutionBehavior,
              enjoymentBehavior,
              fullnessBehavior,
            ],
          );
          await game.ready();
          await game.ensureAdd(unicorn);

          expect(unicorn.evolutionStage, UnicornEvolutionStage.child);
          unicorn.timesFed = 1;
          unicorn.enjoymentFactor = 0;
          unicorn.fullnessFactor = 0;

          game.update(0);

          expect(unicorn.evolutionStage, UnicornEvolutionStage.child);
          expect(unicorn.timesFed, 1);
        },
      );
    });

    group('on evolution', () {
      flameTester.test(
        'resets enjoyment and fullness factors to full',
        (game) async {
          final enjoymentBehavior = _MockEnjoymentBehavior();
          final fullnessBehavior = _MockFullnessBehavior();

          final evolutionBehavior = EvolutionBehavior();

          final unicorn = Unicorn.test(
            position: Vector2.zero(),
            unicornComponent: ChildUnicornComponent(),
            behaviors: [
              evolutionBehavior,
              enjoymentBehavior,
              fullnessBehavior,
            ],
          );
          await game.ready();
          await game.ensureAdd(unicorn);

          expect(unicorn.evolutionStage, UnicornEvolutionStage.child);
          unicorn.timesFed = EvolutionBehavior.timesThatMustBeFed;

          // Setting happiness to above the threshold, but not full
          unicorn.enjoymentFactor = 0.95;
          unicorn.fullnessFactor = 0.95;

          game.update(0);

          expect(unicorn.evolutionStage, UnicornEvolutionStage.teen);
          expect(unicorn.timesFed, 0);
          expect(unicorn.fullnessFactor, 1);
          expect(unicorn.enjoymentFactor, 1);
        },
      );
    });
  });
}
