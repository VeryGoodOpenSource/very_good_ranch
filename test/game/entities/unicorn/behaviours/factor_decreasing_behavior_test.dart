// ignore_for_file: cascade_invocations

import 'package:flame/components.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ranch_components/ranch_components.dart';
import 'package:very_good_ranch/game/entities/entities.dart';
import 'package:very_good_ranch/game/entities/unicorn/behaviors/behaviors.dart';

import '../../../../helpers/helpers.dart';

class _TestFactorDecreasingBehavior extends FactorDecreasingBehavior {
  factory _TestFactorDecreasingBehavior() {
    return _TestFactorDecreasingBehavior._(
      gaugeComponent: GaugeComponent(
        position: Vector2.zero(),
        thickness: 20,
        percentage: 1,
        color: Colors.lightBlue,
      ),
    );
  }

  _TestFactorDecreasingBehavior._({
    required GaugeComponent gaugeComponent,
  }) : super(gaugeComponent, 0);

  double externalPercentage = 1;

  @override
  double get percentage => externalPercentage;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final flameTester = FlameTester<TestGame>(TestGame.new);

  group('FactorDecreasingBehavior', () {
    late Unicorn unicorn;
    late _TestFactorDecreasingBehavior factorDecreasingBehavior;

    setUp(() {
      factorDecreasingBehavior = _TestFactorDecreasingBehavior();
      unicorn = Unicorn.test(
        position: Vector2.all(100),
        behaviors: [
          factorDecreasingBehavior,
        ],
      )..unicornComponent.spriteComponent.current = null;
    });

    group('gauge rendering', () {
      flameTester.testGameWidget(
        'Follows fullness and enjoyment factors: 100%',
        setUp: (game, tester) async {
          await game.ensureAdd(unicorn);
          factorDecreasingBehavior.externalPercentage = 1;
          factorDecreasingBehavior.makeGaugeTemporarilyVisible();
        },
        verify: (game, tester) async {
          await expectLater(
            find.byGame<TestGame>(),
            matchesGoldenFile('golden/gauge/has-full-gauge.png'),
          );
        },
      );

      flameTester.testGameWidget(
        'Follows fullness and enjoyment factors: 40%',
        setUp: (game, tester) async {
          await game.ensureAdd(unicorn);
          factorDecreasingBehavior.externalPercentage = 0.4;
          factorDecreasingBehavior.makeGaugeTemporarilyVisible();
          game.update(GaugeComponent.animationDuration);
        },
        verify: (game, tester) async {
          await expectLater(
            find.byGame<TestGame>(),
            matchesGoldenFile('golden/gauge/has-half-gauge-40.png'),
          );
        },
      );

      flameTester.testGameWidget(
        'Do not render gauge when leaving',
        setUp: (game, tester) async {
          unicorn.isLeaving = true;
          await game.ensureAdd(unicorn);
          factorDecreasingBehavior.externalPercentage = 0;
          factorDecreasingBehavior.makeGaugeTemporarilyVisible();
          game.update(0.1);
        },
        verify: (game, tester) async {
          await expectLater(
            find.byGame<TestGame>(),
            matchesGoldenFile('golden/gauge/has-half-gauge-leaving.png'),
          );
        },
      );
    });
    group('gauge visibility', () {
      flameTester.testGameWidget(
        'gauge is not visible on start',
        setUp: (game, tester) async {
          await game.ensureAdd(unicorn);
          factorDecreasingBehavior.externalPercentage = 1;
        },
        verify: (game, tester) async {
          await expectLater(
            find.byGame<TestGame>(),
            matchesGoldenFile('golden/gauge/visibility-start.png'),
          );
        },
      );
      group('gauge becomes temporarily visible', () {
        flameTester.testGameWidget(
          'on makeGaugeTemporarilyVisible',
          setUp: (game, tester) async {
            await game.ensureAdd(unicorn);

            factorDecreasingBehavior.externalPercentage = 1;
            factorDecreasingBehavior.makeGaugeTemporarilyVisible();
          },
          verify: (game, tester) async {
            await expectLater(
              find.byGame<TestGame>(),
              matchesGoldenFile('golden/gauge/temporary-visibility-1.png'),
            );

            game.update(FactorDecreasingBehavior.visibilityDuration);
            await tester.pump();

            await expectLater(
              find.byGame<TestGame>(),
              matchesGoldenFile('golden/gauge/temporary-visibility-2.png'),
            );
          },
        );
      });
      flameTester.testGameWidget(
        'gauge is visible when percentage is below 25%',
        setUp: (game, tester) async {
          await game.ensureAdd(unicorn);

          factorDecreasingBehavior.externalPercentage = 0.1;
          game.update(GaugeComponent.animationDuration);
        },
        verify: (game, tester) async {
          await expectLater(
            find.byGame<TestGame>(),
            matchesGoldenFile('golden/gauge/visibility-low-percentage.png'),
          );
        },
      );
    });
  });
}
