// ignore_for_file: cascade_invocations

import 'package:flame/components.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:very_good_ranch/game/bloc/game/game_bloc.dart';
import 'package:very_good_ranch/game/entities/entities.dart';
import 'package:very_good_ranch/game/entities/unicorn/behaviors/behaviors.dart';
import 'package:very_good_ranch/game/very_good_ranch_game.dart';

import '../../../../helpers/helpers.dart';

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

  group('GaugeBehavior', () {
    flameTester.testGameWidget(
      'Follows fullness and enjoyment factors: 100%',
      setUp: (game, tester) async {
        final leavingBehavior = _MockLeavingBehavior();
        when(() => leavingBehavior.isLeaving).thenReturn(false);

        final gaugeBehavior = GaugeBehavior();

        final unicorn = Unicorn.test(
          position: Vector2.all(100),
          behaviors: [
            gaugeBehavior,
            leavingBehavior,
          ],
        );
        await game.ensureAdd(unicorn);
        unicorn.fullnessFactor = 1.0;
        unicorn.enjoymentFactor = 1.0;
      },
      verify: (game, tester) async {
        await expectLater(
          find.byGame<VeryGoodRanchGame>(),
          matchesGoldenFile(
            'golden/gauge/has-full-gauge.png',
          ),
        );
      },
    );

    flameTester.testGameWidget(
      'Follows fullness and enjoyment factors: 50%',
      setUp: (game, tester) async {
        final leavingBehavior = _MockLeavingBehavior();
        when(() => leavingBehavior.isLeaving).thenReturn(false);

        final gaugeBehavior = GaugeBehavior();

        final unicorn = Unicorn.test(
          position: Vector2.all(100),
          behaviors: [
            gaugeBehavior,
            leavingBehavior,
          ],
        );
        await game.ensureAdd(unicorn);
        unicorn.fullnessFactor = 0.5;
        unicorn.enjoymentFactor = 0.5;
      },
      verify: (game, tester) async {
        await expectLater(
          find.byGame<VeryGoodRanchGame>(),
          matchesGoldenFile(
            'golden/gauge/has-half-gauge-50.png',
          ),
        );
      },
    );

    flameTester.testGameWidget(
      'Do not render gauge when leaving',
      setUp: (game, tester) async {
        final leavingBehavior = _MockLeavingBehavior();
        when(() => leavingBehavior.isLeaving).thenReturn(true);

        final gaugeBehavior = GaugeBehavior();

        final unicorn = Unicorn.test(
          position: Vector2.all(100),
          behaviors: [
            gaugeBehavior,
            leavingBehavior,
          ],
        );
        await game.ensureAdd(unicorn);
        unicorn.fullnessFactor = 0.5;
        unicorn.enjoymentFactor = 0.5;
        game.update(0.1);
      },
      verify: (game, tester) async {
        await expectLater(
          find.byGame<VeryGoodRanchGame>(),
          matchesGoldenFile(
            'golden/gauge/has-half-gauge-leaving.png',
          ),
        );
      },
    );
  });
}
