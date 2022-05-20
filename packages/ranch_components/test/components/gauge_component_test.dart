// ignore_for_file: cascade_invocations

import 'package:flame/components.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ranch_components/ranch_components.dart';

import '../helpers/helpers.dart';

void main() {
  group('GaugeComponent', () {
    final flameTester = FlameTester(TestGame.new);

    group('percentage', () {
      flameTester.test(
        'has percentage value',
        (game) async {
          await game.ensureAdd(
            GaugeComponent(
              position: Vector2.zero(),
              size: 100,
              percentage: 0.4,
              thickness: 20,
              color: Colors.pink,
            ),
          );
          final gauge = game.firstChild<GaugeComponent>()!;

          expect(gauge.percentage, equals(0.4));
        },
      );
      flameTester.test(
        'throws assertion with to high or small value',
        (game) async {
          expect(
            () => GaugeComponent(
              position: Vector2.zero(),
              size: 100,
              percentage: -0.1,
              thickness: 20,
              color: Colors.pink,
            ),
            failsAssert('Percentage has to be between 0 and 1'),
          );

          expect(
            () => GaugeComponent(
              position: Vector2.zero(),
              size: 100,
              percentage: 1.1,
              thickness: 20,
              color: Colors.pink,
            ),
            failsAssert('Percentage has to be between 0 and 1'),
          );
        },
      );

      flameTester.test(
        'clamps percentage value',
        (game) async {
          game.camera.followVector2(Vector2.zero());
          await game.ensureAdd(
            GaugeComponent(
              position: Vector2.zero(),
              size: 100,
              percentage: 0.4,
              thickness: 20,
              color: Colors.pink,
            ),
          );
          final gauge = game.firstChild<GaugeComponent>()!;
          gauge.percentage = 2;

          expect(gauge.percentage, equals(1));
        },
      );
    });

    group('when smaller than 1', () {
      flameTester.testGameWidget(
        'renders correctly',
        setUp: (game, tester) async {
          game.camera.followVector2(Vector2.zero());
          await game.ensureAdd(
            GaugeComponent(
              position: Vector2.zero(),
              size: 100,
              percentage: 0.4,
              thickness: 20,
              color: Colors.pink,
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
              percentage: 1,
              thickness: 20,
              color: Colors.pink,
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
              thickness: 20,
              color: Colors.pink,
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
            thickness: 20,
            color: Colors.pink,
          ),
        );
      },
      verify: (game, tester) async {
        await expectLater(
          find.byGame<TestGame>(),
          matchesGoldenFile('golden/gauge_component/changing/before.png'),
        );

        game.firstChild<GaugeComponent>()?.percentage = 0.5;
        await tester.pump();
        await expectLater(
          find.byGame<TestGame>(),
          matchesGoldenFile('golden/gauge_component/changing/after.png'),
        );
      },
    );
  });
}
