// ignore_for_file: cascade_invocations

import 'package:flame/components.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ranch_components/ranch_components.dart';

import '../helpers/helpers.dart';

void main() {
  group('GaugeComponent', () {
    final flameTester = FlameTester(TestGame.new);

    group('when smaller than 1', () {
      flameTester.testGameWidget(
        'renders correctly',
        setUp: (game, tester) async {
          game.camera.followVector2(Vector2.zero());
          await game.ensureAdd(
            GaugeComponent(
              position: Vector2.zero(),
              size: 100,
              percent: 0.4,
            ),
          );
        },
        verify: (game, tester) async {
          await expectLater(
            find.byGame<TestGame>(),
            matchesGoldenFile('golden/gauge_component/smaller_than_1.png'),
          );
        },
      );
    });

    group('when equals to 1', () {
      flameTester.testGameWidget(
        'renders correctly',
        setUp: (game, tester) async {
          game.camera.followVector2(Vector2.zero());
          await game.ensureAdd(
            GaugeComponent(
              position: Vector2.zero(),
              size: 100,
              percent: 1,
            ),
          );
        },
        verify: (game, tester) async {
          await expectLater(
            find.byGame<TestGame>(),
            matchesGoldenFile('golden/gauge_component/equals_to_1.png'),
          );
        },
      );
    });

    group('when equals to 0', () {
      flameTester.testGameWidget(
        'renders correctly',
        setUp: (game, tester) async {
          game.camera.followVector2(Vector2.zero());
          await game.ensureAdd(
            GaugeComponent(
              position: Vector2.zero(),
              size: 100,
            ),
          );
        },
        verify: (game, tester) async {
          await expectLater(
            find.byGame<TestGame>(),
            matchesGoldenFile('golden/gauge_component/equals_to_0.png'),
          );
        },
      );
    });

    flameTester.testGameWidget(
      'can be changed at runtime',
      setUp: (game, tester) async {
        game.camera.followVector2(Vector2.zero());
        await game.ensureAdd(
          GaugeComponent(
            position: Vector2.zero(),
            size: 100,
          ),
        );
      },
      verify: (game, tester) async {
        await expectLater(
          find.byGame<TestGame>(),
          matchesGoldenFile('golden/gauge_component/changing/before.png'),
        );

        game.firstChild<GaugeComponent>()?.percent = 0.5;
        await tester.pump();
        await expectLater(
          find.byGame<TestGame>(),
          matchesGoldenFile('golden/gauge_component/changing/after.png'),
        );
      },
    );
  });
}
