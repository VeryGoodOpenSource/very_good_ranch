// ignore_for_file: cascade_invocations

import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ranch_components/ranch_components.dart';

import '../../helpers/helpers.dart';

class MockRandom extends Mock implements Random {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final flameTester = FlameTester(
    () => TestGame(const Color(0xFF52C1B1)),
    gameSize: Vector2(900, 1600),
  );

  group('BackgroundComponent', () {
    flameTester.test('has a pasture field', (game) async {
      final backgroundComponent = BackgroundComponent();
      await game.ensureAdd(backgroundComponent);

      final pastureField = backgroundComponent.pastureField;

      expect(pastureField, const Rect.fromLTRB(30, 170, 870, 1570));
    });

    flameTester.testGameWidget(
      'renders all the elements',
      setUp: (game, tester) async {
        final seed = MockRandom();
        when(seed.nextDouble).thenReturn(0.5);
        final backgroundComponent = BackgroundComponent(
          getDelegate: (pastureField) =>
              BackgroundPositionDelegate(seed, pastureField),
        );

        await game.ensureAdd(backgroundComponent);
      },
      verify: (game, tester) async {
        await expectLater(
          find.byGame<TestGame>(),
          matchesGoldenFile('golden/background/all_elements.png'),
        );
      },
    );
  });
}