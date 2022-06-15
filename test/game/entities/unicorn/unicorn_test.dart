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

          unicorn.state = UnicornState.roaming;

          expect(unicorn.state, UnicornState.roaming);
        },
      );
    });

    group('unicorn stage', () {
      flameTester.test(
        'proxies from the behavior',
        (game) async {
          final unicorn = Unicorn(position: Vector2.zero());

          await game.ensureAdd(unicorn);
          await game.ready();

          unicorn.state = UnicornState.idle;

          expect(unicorn.currentStage, UnicornStage.baby);
          unicorn.timesFed = EvolutionBehavior.timesThatMustBeFed;

          game.update(0);

          expect(unicorn.currentStage, UnicornStage.child);
        },
      );
    });
  });
}
