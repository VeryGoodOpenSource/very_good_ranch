// ignore_for_file: cascade_invocations

import 'dart:math';
import 'dart:ui';

import 'package:flame/cache.dart';
import 'package:flame/components.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ranch_components/gen/assets.gen.dart';
import 'package:ranch_components/ranch_components.dart';

import '../../helpers/helpers.dart';

class MockRandom extends Mock implements Random {}

class MockImages extends Mock implements Images {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final flameTester = FlameTester(
    () => TestGame(
      backgroundColor: const Color(0xFF92DED3),
    ),
    gameSize: Vector2(900, 1600),
  );

  group('BackgroundComponent', () {
    group('preloadAssets', () {
      testWidgets('preloads assets', (tester) async {
        final images = MockImages();

        when(
          () => images.loadAll(any()),
        ).thenAnswer((Invocation invocation) => Future.value(<Image>[]));

        await BackgroundComponent.preloadAssets(images);

        verify(
          () => images.loadAll(
            [
              Assets.background.barn.keyName,
              Assets.background.sheep.keyName,
              Assets.background.sheepSmall.keyName,
              Assets.background.cow.keyName,
              Assets.background.flowerDuo.keyName,
              Assets.background.flowerGroup.keyName,
              Assets.background.flowerSolo.keyName,
              Assets.background.grass.keyName,
              Assets.background.shortTree.keyName,
              Assets.background.tallTree.keyName,
              Assets.background.linedTree.keyName,
              Assets.background.linedTreeShort.keyName,
            ],
          ),
        ).called(1);
      });
    });

    flameTester.test('has a pasture field', (game) async {
      final backgroundComponent = BackgroundComponent();
      await game.ensureAdd(backgroundComponent);

      final pastureField = backgroundComponent.pastureField;

      expect(pastureField, const Rect.fromLTRB(42, 220, 858, 1570));
    });

    flameTester.testGameWidget(
      'renders all the elements',
      setUp: (game, tester) async {
        final seed = MockRandom();
        when(seed.nextDouble).thenReturn(0.5);
        when(() => seed.nextInt(any())).thenReturn(0);
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
