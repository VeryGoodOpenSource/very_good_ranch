// ignore_for_file: cascade_invocations

import 'package:flame/components.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:ranch_components/ranch_components.dart';
import 'package:very_good_ranch/game/entities/entities.dart';
import 'package:very_good_ranch/game/entities/unicorn/behaviors/behaviors.dart';

import '../../../../helpers/helpers.dart';

class _MockLeavingBehavior extends Mock implements LeavingBehavior {}

class _TestFactorBehavior extends FactorBehavior {
  factory _TestFactorBehavior() {
    return _TestFactorBehavior._(
      gaugeComponent: GaugeComponent(
        position: Vector2.zero(),
        size: 120,
        thickness: 15,
        percentage: 1,
        color: Colors.lightBlue,
      ),
    );
  }

  _TestFactorBehavior._({
    required super.gaugeComponent,
  });

  double externalPercentage = 1;

  @override
  double getPercentage() => externalPercentage;

  @override
  void setPercentage(double value) => externalPercentage = value;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final flameTester = FlameTester<TestGame>(TestGame.new);

  group('FactorBehavior', () {
    late _MockLeavingBehavior leavingBehavior;
    late Unicorn unicorn;
    late FactorBehavior factorBehavior;

    setUp(() {
      leavingBehavior = _MockLeavingBehavior();
      factorBehavior = _TestFactorBehavior();
      unicorn = Unicorn.test(
        position: Vector2.all(100),
        behaviors: [
          factorBehavior,
          leavingBehavior,
        ],
      )..unicornComponent.current = null;
    });

    group('gauge rendering', () {
      flameTester.testGameWidget(
        'Follows fullness and enjoyment factors: 100%',
        setUp: (game, tester) async {
          when(() => leavingBehavior.isLeaving).thenReturn(false);
          await game.ensureAdd(unicorn);
          factorBehavior.setPercentage(1);
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
          when(() => leavingBehavior.isLeaving).thenReturn(false);

          await game.ensureAdd(unicorn);
          factorBehavior.setPercentage(0.5);
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
          when(() => leavingBehavior.isLeaving).thenReturn(true);
          await game.ensureAdd(unicorn);
          factorBehavior.setPercentage(0);
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
          when(() => leavingBehavior.isLeaving).thenReturn(false);

          await game.ensureAdd(unicorn);
          factorBehavior.setPercentage(1);
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
          'on increase',
          setUp: (game, tester) async {
            when(() => leavingBehavior.isLeaving).thenReturn(false);

            await game.ensureAdd(unicorn);

            factorBehavior.setPercentage(1);
            factorBehavior.increaseBy(0.5);
          },
          verify: (game, tester) async {
            await expectLater(
              find.byGame<TestGame>(),
              matchesGoldenFile('golden/gauge/visibility-on-increase-1.png'),
            );

            game.update(FactorBehavior.visibilityDuration);
            await tester.pump();

            await expectLater(
              find.byGame<TestGame>(),
              matchesGoldenFile('golden/gauge/visibility-on-increase-2.png'),
            );
          },
        );
        flameTester.testGameWidget(
          'on decrease',
          setUp: (game, tester) async {
            when(() => leavingBehavior.isLeaving).thenReturn(false);

            await game.ensureAdd(unicorn);

            factorBehavior.setPercentage(1);
            factorBehavior.increaseBy(0.5);
          },
          verify: (game, tester) async {
            await expectLater(
              find.byGame<TestGame>(),
              matchesGoldenFile('golden/gauge/visibility-on-decrease-1.png'),
            );

            game.update(FactorBehavior.visibilityDuration);
            await tester.pump();

            await expectLater(
              find.byGame<TestGame>(),
              matchesGoldenFile('golden/gauge/visibility-on-decrease-2.png'),
            );
          },
        );
        flameTester.testGameWidget(
          'on reset',
          setUp: (game, tester) async {
            when(() => leavingBehavior.isLeaving).thenReturn(false);

            await game.ensureAdd(unicorn);

            factorBehavior.setPercentage(0.5);
            factorBehavior.reset();
          },
          verify: (game, tester) async {
            await expectLater(
              find.byGame<TestGame>(),
              matchesGoldenFile('golden/gauge/visibility-on-reset-1.png'),
            );

            game.update(FactorBehavior.visibilityDuration);
            await tester.pump();

            await expectLater(
              find.byGame<TestGame>(),
              matchesGoldenFile('golden/gauge/visibility-on-reset-2.png'),
            );
          },
        );
      });
      flameTester.testGameWidget(
        'gauge is visible when percentage is below 25%',
        setUp: (game, tester) async {
          when(() => leavingBehavior.isLeaving).thenReturn(false);

          await game.ensureAdd(unicorn);

          factorBehavior.setPercentage(0.1);
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
    group('percentage change', () {
      test('increase', () {
        final factorBehavior = _TestFactorBehavior();

        factorBehavior.setPercentage(0);
        factorBehavior.increaseBy(0.5);
        expect(factorBehavior.getPercentage(), equals(0.5));
        expect(factorBehavior.externalPercentage, equals(0.5));
      });
      test('decrease', () {
        final factorBehavior = _TestFactorBehavior();

        factorBehavior.setPercentage(1);
        factorBehavior.decreaseBy(0.5);
        expect(factorBehavior.getPercentage(), equals(0.5));
        expect(factorBehavior.externalPercentage, equals(0.5));
      });
      test('reset', () {
        final factorBehavior = _TestFactorBehavior();
        factorBehavior.setPercentage(0.5);
        factorBehavior.reset();
        expect(factorBehavior.getPercentage(), equals(1.0));
        expect(factorBehavior.externalPercentage, equals(1.0));
      });
    });
  });
}
