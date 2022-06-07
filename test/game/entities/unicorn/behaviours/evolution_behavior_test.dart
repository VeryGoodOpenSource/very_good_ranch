// ignore_for_file: cascade_invocations

import 'package:flame/components.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_ranch/game/entities/unicorn/behaviors/behaviors.dart';
import 'package:very_good_ranch/game/entities/unicorn/unicorn.dart';
import 'package:very_good_ranch/game/game.dart';

import '../../../../helpers/helpers.dart';

class _MockEnjoymentBehavior extends Mock implements EnjoymentBehavior {}

class _MockFullnessBehavior extends Mock implements FullnessBehavior {}

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

        expect(evolutionBehavior.currentStage, UnicornStage.baby);
        unicorn.timesFed = EvolutionBehavior.timesThatMustBeFed;
        when(() => enjoymentBehavior.percentage).thenReturn(1);
        when(() => fullnessBehavior.percentage).thenReturn(1);

        game.update(0);

        expect(evolutionBehavior.currentStage, UnicornStage.child);
      });

      flameTester.test('from kid to teenager', (game) async {
        final enjoymentBehavior = _MockEnjoymentBehavior();
        final fullnessBehavior = _MockFullnessBehavior();

        final evolutionBehavior =
            EvolutionBehavior.withInitialStage(UnicornStage.child);

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
        await game.ready();

        expect(evolutionBehavior.currentStage, UnicornStage.child);
        unicorn.timesFed = EvolutionBehavior.timesThatMustBeFed;
        when(() => enjoymentBehavior.percentage).thenReturn(1);
        when(() => fullnessBehavior.percentage).thenReturn(1);

        game.update(0);

        expect(evolutionBehavior.currentStage, UnicornStage.teen);
      });

      flameTester.test('from teenager to adult', (game) async {
        final enjoymentBehavior = _MockEnjoymentBehavior();
        final fullnessBehavior = _MockFullnessBehavior();

        final evolutionBehavior = EvolutionBehavior.withInitialStage(
          UnicornStage.teen,
        );

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
        game.update(5);

        expect(evolutionBehavior.currentStage, UnicornStage.teen);
        unicorn.timesFed = EvolutionBehavior.timesThatMustBeFed;
        when(() => enjoymentBehavior.percentage).thenReturn(1);
        when(() => fullnessBehavior.percentage).thenReturn(1);

        game.update(0);

        expect(evolutionBehavior.currentStage, UnicornStage.adult);
      });

      flameTester.test(
        'stops evolution when reaches the adult stage',
        (game) async {
          final enjoymentBehavior = _MockEnjoymentBehavior();
          final fullnessBehavior = _MockFullnessBehavior();

          final evolutionBehavior =
              EvolutionBehavior.withInitialStage(UnicornStage.adult);

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

          expect(evolutionBehavior.currentStage, UnicornStage.adult);
          unicorn.timesFed = EvolutionBehavior.timesThatMustBeFed;
          when(() => enjoymentBehavior.percentage).thenReturn(1);
          when(() => fullnessBehavior.percentage).thenReturn(1);

          game.update(0);

          expect(evolutionBehavior.currentStage, UnicornStage.adult);
        },
      );

      flameTester.test(
        'stops evolution when the unicorn is not fed enough',
        (game) async {
          final enjoymentBehavior = _MockEnjoymentBehavior();
          final fullnessBehavior = _MockFullnessBehavior();

          final evolutionBehavior =
              EvolutionBehavior.withInitialStage(UnicornStage.child);

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

          expect(evolutionBehavior.currentStage, UnicornStage.child);
          unicorn.timesFed = 0;
          when(() => enjoymentBehavior.percentage).thenReturn(1);
          when(() => fullnessBehavior.percentage).thenReturn(1);

          game.update(0);

          expect(evolutionBehavior.currentStage, UnicornStage.child);
        },
      );

      flameTester.test(
        'stops evolution when the unicorn is not happy enough',
        (game) async {
          final enjoymentBehavior = _MockEnjoymentBehavior();
          final fullnessBehavior = _MockFullnessBehavior();

          final evolutionBehavior =
              EvolutionBehavior.withInitialStage(UnicornStage.child);

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

          expect(evolutionBehavior.currentStage, UnicornStage.child);
          unicorn.timesFed = 1;
          when(() => enjoymentBehavior.percentage).thenReturn(0);
          when(() => fullnessBehavior.percentage).thenReturn(0);

          game.update(0);

          expect(evolutionBehavior.currentStage, UnicornStage.child);
        },
      );
    });

    group('on evolution', () {
      flameTester.test(
        'resets enjoyment and fullness factors to full',
        (game) async {
          final enjoymentBehavior = _MockEnjoymentBehavior();
          final fullnessBehavior = _MockFullnessBehavior();

          final evolutionBehavior =
              EvolutionBehavior.withInitialStage(UnicornStage.child);

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

          expect(evolutionBehavior.currentStage, UnicornStage.child);
          unicorn.timesFed = EvolutionBehavior.timesThatMustBeFed;

          // Setting happiness to above the threshold, but not full
          when(() => enjoymentBehavior.percentage).thenReturn(0.95);
          when(() => fullnessBehavior.percentage).thenReturn(0.95);

          game.update(0);

          expect(evolutionBehavior.currentStage, UnicornStage.teen);
          verify(enjoymentBehavior.reset).called(1);
          verify(fullnessBehavior.reset).called(1);
        },
      );
    });
  });
}
