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

import '../../helpers/helpers.dart';

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

  group('UnicornCounter', () {
    flameTester.testGameWidget(
      'counts each stage of a unicorn',
      setUp: (game, tester) async {
        await game.add(UnicornCounter(position: Vector2(game.size.x, 0)));
        await game.background.addAll(
          UnicornStage.values.map(
            (e) => Unicorn.test(
              position: Vector2.zero(),
              behaviors: [EvolutionBehavior.withInitialStage(e)],
            ),
          ),
        );

        await game.ready();
      },
      verify: (game, tester) async {
        final counter = game.firstChild<UnicornCounter>()!;

        expect(counter.unicorns.length, equals(4));
        expect(counter.children.length, equals(UnicornStage.values.length));
      },
    );
  });
}
