// ignore_for_file: cascade_invocations

import 'package:flame/extensions.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_ranch/game/components/unicorn_counter.dart';
import 'package:very_good_ranch/game/entities/entities.dart';
import 'package:very_good_ranch/game/entities/unicorn/behaviors/behaviors.dart';

import '../../helpers/helpers.dart';

void main() {
  final flameTester = FlameTester<TestGame>(TestGame.new);

  group('UnicornCounter', () {
    flameTester.testGameWidget(
      'counts each stage of a unicorn',
      setUp: (game, tester) async {
        await game.add(UnicornCounter(position: Vector2(game.size.x, 0)));
        await game.addAll(
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
        await expectLater(
          find.byGame<TestGame>(),
          matchesGoldenFile('golden/unicorn_counter/all_unicorns.png'),
        );
      },
    );
  });
}
