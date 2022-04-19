// ignore_for_file: cascade_invocations

import 'package:flame/components.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ranch_components/ranch_components.dart';

import '../helpers/helpers.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final flameTester = FlameTester(TestGame.new);

  group('UnicornComponent', () {
    flameTester.test(
      'loads correctly',
      (game) async {
        final unicorn = UnicornComponent(position: Vector2.zero());
        await game.ready();
        await game.ensureAdd(unicorn);

        expect(unicorn.current, UnicornState.idle);
        expect(game.contains(unicorn), isTrue);
      },
    );

    flameTester.testGameWidget(
      'has idle animation',
      setUp: (game, tester) async {
        final unicorn = UnicornComponent(position: Vector2.zero());
        await game.add(unicorn);
      },
      verify: (game, tester) async {
        game.update(.3);
        await tester.pump();

        await expectLater(
          find.byGame<TestGame>(),
          matchesGoldenFile('golden/unicorn_component/idle/frame0.png'),
        );
      },
    );

    flameTester.testGameWidget(
      'has roaming animation',
      setUp: (game, tester) async {
        final unicorn = UnicornComponent(position: Vector2.zero());
        unicorn.current = UnicornState.roaming;
        await game.add(unicorn);
      },
      verify: (game, tester) async {
        for (var i = 0; i < 3; i++) {
          game.update(.3);
          await tester.pump();
          await expectLater(
            find.byGame<TestGame>(),
            matchesGoldenFile('golden/unicorn_component/roaming/frame$i.png'),
          );
        }
      },
    );
  });
}
