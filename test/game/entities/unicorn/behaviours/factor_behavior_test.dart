// ignore_for_file: cascade_invocations

import 'package:flame/components.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ranch_components/ranch_components.dart';
import 'package:very_good_ranch/game/entities/entities.dart';
import 'package:very_good_ranch/game/entities/unicorn/behaviors/behaviors.dart';

import '../../../../helpers/helpers.dart';

class _TestFactorBehavior extends FactorBehavior {
  factory _TestFactorBehavior() {
    return _TestFactorBehavior._(
      gaugeComponent: GaugeComponent(
        position: Vector2.zero(),
        diameter: 0,
        thickness: 20,
        percentage: 1,
        color: Colors.lightBlue,
      ),
    );
  }

  _TestFactorBehavior._({
    required GaugeComponent gaugeComponent,
  }) : super(gaugeComponent, 0);

  double externalPercentage = 1;

  @override
  double get percentage => externalPercentage;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final flameTester = FlameTester<TestGame>(TestGame.new);

  group('FactorBehavior', () {
    late Unicorn unicorn;
    late _TestFactorBehavior factorBehavior;

    setUp(() {
      factorBehavior = _TestFactorBehavior();
      unicorn = Unicorn.test(
        position: Vector2.all(100),
        behaviors: [
          factorBehavior,
        ],
      )..unicornComponent.current = null;
    });

    group('gauge rendering', () {
      flameTester.testGameWidget(
        'Follows fullness and enjoyment factors: 100%',
        setUp: (game, tester) async {
          await game.ensureAdd(unicorn);
          factorBehavior.externalPercentage = 1;
          factorBehavior.makeGaugeTemporarilyVisible();
        },
        verify: (game, tester) async {
          await expectLater(
            find.byGame<TestGame>(),
            matchesGoldenFile('golden/gauge/has-full-gauge.png'),
          );
        },
      );

      flameTester.testGameWidget(
        'Follows fullness and enjoyment factors: 50%',
        setUp: (game, tester) async {
          await game.ensureAdd(unicorn);
          factorBehavior.externalPercentage = 0.5;
          factorBehavior.makeGaugeTemporarilyVisible();
          game.update(GaugeComponent.animationDuration);
        },
        verify: (game, tester) async {
          await expectLater(
            find.byGame<TestGame>(),
            matchesGoldenFile('golden/gauge/has-half-gauge-50.png'),
          );
        },
      );

      flameTester.testGameWidget(
        'Do not render gauge when leaving',
        setUp: (game, tester) async {
          unicorn.isLeaving = true;
          await game.ensureAdd(unicorn);
          factorBehavior.externalPercentage = 0;
          factorBehavior.makeGaugeTemporarilyVisible();
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
          factorBehavior.externalPercentage = 1;
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

            factorBehavior.externalPercentage = 1;
            factorBehavior.makeGaugeTemporarilyVisible();
          },
          verify: (game, tester) async {
            await expectLater(
              find.byGame<TestGame>(),
              matchesGoldenFile('golden/gauge/temporary-visibility-1.png'),
            );

            game.update(FactorBehavior.visibilityDuration);
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

          factorBehavior.externalPercentage = 0.1;
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
