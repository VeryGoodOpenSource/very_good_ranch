// ignore_for_file: cascade_invocations

import 'package:flame/extensions.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:very_good_ranch/game/bloc/game/game_bloc.dart';
import 'package:very_good_ranch/game/components/unicorn_counter.dart';
import 'package:very_good_ranch/game/entities/entities.dart';
import 'package:very_good_ranch/game/entities/unicorn/behaviors/behaviors.dart';
import 'package:very_good_ranch/game/very_good_ranch_game.dart';
import 'package:very_good_ranch/l10n/l10n.dart';

import '../../helpers/helpers.dart';

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

  group('UnicornCounter', () {
    flameTester.testGameWidget(
      'counts each evolution stage of a unicorn',
      setUp: (game, tester) async {
        await game.add(UnicornCounter(position: Vector2(game.size.x, 0)));
        await game.background.addAll(
          UnicornEvolutionStage.values.map(
            (e) => Unicorn.test(
              unicornComponent: e.componentForEvolutionStage,
              position: Vector2.zero(),
              behaviors: [EvolutionBehavior()],
            ),
          ),
        );

        await game.ready();
      },
      verify: (game, tester) async {
        final counter = game.firstChild<UnicornCounter>()!;

        expect(counter.unicorns.length, equals(4));
        expect(
          counter.children.length,
          equals(UnicornEvolutionStage.values.length),
        );
      },
    );
  });
}
