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

class _TestGaugeBehavior extends GaugeBehavior {
  factory _TestGaugeBehavior() {
    return _TestGaugeBehavior._(
      GaugeComponent(
        position: Vector2.zero(),
        size: 75,
        thickness: 10,
        percentage: 1,
        color: Colors.lightBlue,
      ),
    );
  }

  _TestGaugeBehavior._(super.gauge);

  @override
  double gaugePercentage = 1;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final flameTester = FlameTester<TestGame>(TestGame.new);

  group('GaugeBehavior', () {
    flameTester.testGameWidget(
      'Follows fullness and enjoyment factors: 100%',
      setUp: (game, tester) async {
        final leavingBehavior = _MockLeavingBehavior();
        when(() => leavingBehavior.isLeaving).thenReturn(false);

        final gaugeBehavior = _TestGaugeBehavior();

        final unicorn = Unicorn.test(
          position: Vector2.all(100),
          behaviors: [
            gaugeBehavior,
            leavingBehavior,
          ],
        );
        await game.ensureAdd(unicorn);
        gaugeBehavior.gaugePercentage = 1.0;
      },
      verify: (game, tester) async {
        await expectLater(
          find.byGame<TestGame>(),
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

        final gaugeBehavior = _TestGaugeBehavior();

        final unicorn = Unicorn.test(
          position: Vector2.all(100),
          behaviors: [
            gaugeBehavior,
            leavingBehavior,
          ],
        );
        await game.ensureAdd(unicorn);
        gaugeBehavior.gaugePercentage = 0.5;
      },
      verify: (game, tester) async {
        await expectLater(
          find.byGame<TestGame>(),
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

        final gaugeBehavior = _TestGaugeBehavior();

        final unicorn = Unicorn.test(
          position: Vector2.all(100),
          behaviors: [
            gaugeBehavior,
            leavingBehavior,
          ],
        );
        await game.ensureAdd(unicorn);
        gaugeBehavior.gaugePercentage = 0.0;
        game.update(0.1);
      },
      verify: (game, tester) async {
        await expectLater(
          find.byGame<TestGame>(),
          matchesGoldenFile(
            'golden/gauge/has-half-gauge-leaving.png',
          ),
        );
      },
    );
  });
}
