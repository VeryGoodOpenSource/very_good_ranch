// ignore_for_file: cascade_invocations

import 'package:flame/image_composition.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_ranch/game/entities/unicorn/behaviors/behaviors.dart';
import 'package:very_good_ranch/game/entities/unicorn/unicorn.dart';

import '../../../../helpers/test_game.dart';

class _MockEnjoymentBehavior extends Mock implements EnjoymentBehavior {}

class _MockFullnessBehavior extends Mock implements FullnessBehavior {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final flameTester = FlameTester(TestGame.new);

  group('LeavingBehavior', () {
    flameTester.testGameWidget(
      'Start movement and opacity Effect',
      setUp: (game, tester) async {
        final enjoymentBehavior = _MockEnjoymentBehavior();
        final fullnessBehavior = _MockFullnessBehavior();

        final leavingBehavior = LeavingBehavior();
        final unicorn = Unicorn.test(
          position: game.size / 2 - Vector2.all(16),
          behaviors: [
            enjoymentBehavior,
            leavingBehavior,
            fullnessBehavior,
          ],
        );
        await game.ensureAdd(unicorn);

        when(() => enjoymentBehavior.percentage).thenReturn(0.01);
        when(() => fullnessBehavior.percentage).thenReturn(0.01);
      },
      verify: (game, tester) async {
        final unicorn = game.descendants().whereType<Unicorn>().first;
        final leavingBehavior = unicorn.findBehavior<LeavingBehavior>();

        expect(leavingBehavior.isLeaving, true);
        for (var i = 0; i < 5; i++) {
          await expectLater(
            find.byGame<TestGame>(),
            matchesGoldenFile(
              'golden/leaving_behavior/roaming/frame_$i.png',
            ),
          );
          game.update(.2);
          await tester.pump();
        }
      },
    );

    group('removes from parent when done', () {
      flameTester.test('from baby to kid', (game) async {
        final enjoymentBehavior = _MockEnjoymentBehavior();
        final fullnessBehavior = _MockFullnessBehavior();

        final leavingBehavior = LeavingBehavior();
        final unicorn = Unicorn.test(
          position: game.size / 2 - Vector2.all(16),
          behaviors: [
            enjoymentBehavior,
            leavingBehavior,
            fullnessBehavior,
          ],
        );
        await game.ensureAdd(unicorn);
        when(() => enjoymentBehavior.percentage).thenReturn(0.01);
        when(() => fullnessBehavior.percentage).thenReturn(0.01);
        game.update(LeavingBehavior.leavingAnimationDuration);
        game.update(0); // one extra bump to remove the component
        await game.ready();
        expect(unicorn.isMounted, false);
      });
    });
  });
}
