// ignore_for_file: cascade_invocations

import 'package:flame/components.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ranch_components/ranch_components.dart';
import 'package:very_good_ranch/game/entities/entities.dart';
import 'package:very_good_ranch/game/entities/unicorn/behaviors/behaviors.dart';
import 'package:very_good_ranch/game/game.dart';
import 'package:very_good_ranch/l10n/l10n.dart';

import '../../../helpers/helpers.dart';

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

  group('Unicorn', () {
    flameTester.test(
      'loads correctly',
      (game) async {
        final unicorn = Unicorn(position: Vector2.zero());
        await game.ready();
        await game.ensureAdd(unicorn);

        expect(game.contains(unicorn), isTrue);
        expect(unicorn.state, UnicornState.idle);
      },
    );

    group('unicorn state', () {
      flameTester.test(
        'is by default idle',
        (game) async {
          final unicorn = Unicorn(position: Vector2.zero());
          await game.ready();
          await game.ensureAdd(unicorn);

          expect(unicorn.state, UnicornState.idle);
        },
      );

      flameTester.test(
        'can be set',
        (game) async {
          final unicorn = Unicorn(position: Vector2.zero());
          await game.ready();
          await game.ensureAdd(unicorn);

          unicorn.state = UnicornState.walking;

          expect(unicorn.state, UnicornState.walking);
        },
      );
    });

    group('unicorn evolution stage', () {
      flameTester.test(
        'proxies from the behavior',
        (game) async {
          final unicorn = Unicorn(position: Vector2.zero());

          await game.ensureAdd(unicorn);
          await game.ready();

          unicorn.state = UnicornState.idle;

          expect(unicorn.evolutionStage, UnicornEvolutionStage.baby);
          unicorn.timesFed = EvolutionBehavior.timesThatMustBeFed;

          game.update(0);

          expect(unicorn.evolutionStage, UnicornEvolutionStage.child);
        },
      );
    });

    test('reset', () {
      final unicorn = Unicorn(position: Vector2.zero());

      expect(unicorn.timesFed, 0);
      expect(unicorn.fullness.value, 1);
      expect(unicorn.enjoyment.value, 1);

      unicorn.timesFed = 2;
      unicorn.fullness.value = 0.5;
      unicorn.enjoyment.value = 0.5;

      unicorn.reset();

      expect(unicorn.timesFed, 0);
      expect(unicorn.fullness.value, 1);
      expect(unicorn.enjoyment.value, 1);
    });
  });

  group('UnicornPercentage', () {
    group('initial percentage', () {
      test('is set on creation', () {
        final percentage = UnicornPercentage(0.5);
        expect(percentage.value, 0.5);
      });

      test('should be between 0 and 1', () {
        expect(
          () => UnicornPercentage(1.1),
          throwsAssertionError,
        );
        expect(
          () => UnicornPercentage(-0.1),
          throwsAssertionError,
        );
      });
    });

    test('clamps percentage', () {
      final percentage = UnicornPercentage(0.5);
      expect(percentage.value, 0.5);
      percentage.value = -1;
      expect(percentage.value, 0.0);
      percentage.value = 2;
      expect(percentage.value, 1.0);
    });

    group('increase by', () {
      test('increases percentage', () {
        final percentage = UnicornPercentage(0.5);
        expect(percentage.value, 0.5);
        percentage.increaseBy(0.1);
        expect(percentage.value, 0.6);
      });
      test('clamps percentage', () {
        final percentage = UnicornPercentage(0.5);
        expect(percentage.value, 0.5);
        percentage.increaseBy(0.8);
        expect(percentage.value, 1.0);
      });
    });

    group('decrease by', () {
      test('decreases percentage', () {
        final percentage = UnicornPercentage(0.5);
        expect(percentage.value, 0.5);
        percentage.decreaseBy(0.1);
        expect(percentage.value, 0.4);
      });
      test('clamps percentage', () {
        final percentage = UnicornPercentage(0.5);
        expect(percentage.value, 0.5);
        percentage.decreaseBy(0.8);
        expect(percentage.value, 0.0);
      });
    });

    group('reset', () {
      test('resets percentage to initial', () {
        final percentage = UnicornPercentage(0.5);
        percentage.value = 1;
        percentage.reset();
        expect(percentage.value, 0.5);
      });
    });
  });
}
