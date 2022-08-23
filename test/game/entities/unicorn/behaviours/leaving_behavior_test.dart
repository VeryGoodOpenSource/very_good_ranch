// ignore_for_file: cascade_invocations

import 'package:flame/image_composition.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_ranch/game/entities/unicorn/behaviors/behaviors.dart';
import 'package:very_good_ranch/game/entities/unicorn/unicorn.dart';
import 'package:very_good_ranch/game/game.dart';

import '../../../../helpers/helpers.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final flameTester = FlameTester(TestGame.new);
  late BlessingBloc blessingBloc;
  setUp(() {
    blessingBloc = MockBlessingBloc();
  });
  group('LeavingBehavior', () {
    flameTester.testGameWidget(
      'Start movement and opacity Effect',
      setUp: (game, tester) async {
        final leavingBehavior = LeavingBehavior();
        final unicorn = Unicorn.test(
          position: game.size / 2 - Vector2.all(16),
          behaviors: [
            leavingBehavior,
          ],
        )
          ..enjoyment.value = 0.01
          ..fullness.value = 0.01;
        await game.ensureAdd(
          flameBlocProvider(
            blessingBloc: blessingBloc,
            child: unicorn,
          ),
        );
      },
      verify: (game, tester) async {
        final unicorn = game.descendants().whereType<Unicorn>().first;

        expect(unicorn.isLeaving, true);
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
      flameTester.test('removing', (game) async {
        final leavingBehavior = LeavingBehavior();
        final unicorn = Unicorn.test(
          position: game.size / 2 - Vector2.all(16),
          behaviors: [
            leavingBehavior,
          ],
        )
          ..enjoyment.value = 0.01
          ..fullness.value = 0.01;

        expect(unicorn.isLeaving, false);
        await game.ensureAdd(
          flameBlocProvider(
            blessingBloc: blessingBloc,
            child: unicorn,
          ),
        );

        game.update(0); // one extra bump to remove the component
        expect(unicorn.isLeaving, true);
        game.update(LeavingBehavior.leavingAnimationDuration);
        await game.ready();
        expect(unicorn.isMounted, false);
      });
    });
  });
}
