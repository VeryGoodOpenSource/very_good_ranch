import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ranch_components/gen/assets.gen.dart' as components_assets;
import 'package:ranch_flame/ranch_flame.dart';
import 'package:ranch_sounds/ranch_sounds.dart';
import 'package:very_good_ranch/loading/loading.dart';

class MockUnprefixedImages extends Mock implements UnprefixedImages {}

class MockRanchSoundPlayer extends Mock implements RanchSoundPlayer {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('PreloadCubit', () {
    test('can be instantiated', () {
      expect(
        PreloadCubit(
          UnprefixedImages(),
          RanchSoundPlayer(),
        ),
        isA<PreloadCubit>(),
      );
    });
    test('can be instantiated with images', () {
      final images = UnprefixedImages();
      final sounds = RanchSoundPlayer();
      expect(PreloadCubit(images, sounds).images, images);
    });
    test('can be instantiated with initial state', () {
      final prelaodCubit = PreloadCubit(
        UnprefixedImages(),
        RanchSoundPlayer(),
      );
      expect(prelaodCubit.state, const PreloadState.initial());
    });

    group('loadSequentially', () {
      testWidgets('should load assets', (tester) async {
        final images = MockUnprefixedImages();
        when(
          () => images.loadAll(any()),
        ).thenAnswer((Invocation invocation) => Future.value(<Image>[]));

        final sounds = MockRanchSoundPlayer();
        when(sounds.preloadAssets).thenAnswer((Invocation invocation) async {});

        final cubit = PreloadCubit(images, sounds);

        final future = cubit.loadSequentially();

        // Each phase is called in the next tick, so we need to settle first.
        await tester.pumpAndSettle(const Duration(microseconds: 1));

        verify(sounds.preloadAssets).called(1);
        expect(cubit.state.isComplete, false);
        expect(cubit.state.currentLabel, 'sounds');
        await tester.pumpAndSettle(const Duration(milliseconds: 200));

        verify(
          () => images.loadAll(
            [
              components_assets.Assets.background.barn.keyName,
              components_assets.Assets.background.flowerDuo.keyName,
              components_assets.Assets.background.flowerGroup.keyName,
              components_assets.Assets.background.flowerSolo.keyName,
              components_assets.Assets.background.grass.keyName,
              components_assets.Assets.background.shortTree.keyName,
              components_assets.Assets.background.tallTree.keyName,
              components_assets.Assets.background.treeTrio.keyName,
            ],
          ),
        ).called(1);
        expect(cubit.state.isComplete, false);
        expect(cubit.state.currentLabel, 'environment');
        await tester.pumpAndSettle(const Duration(milliseconds: 200));

        verify(
          () => images.loadAll(
            [
              components_assets.Assets.food.icecream.keyName,
              components_assets.Assets.food.cake.keyName,
              components_assets.Assets.food.lollipop.keyName,
              components_assets.Assets.food.pancakes.keyName,
            ],
          ),
        ).called(1);
        expect(cubit.state.isComplete, false);
        expect(cubit.state.currentLabel, 'food');
        await tester.pumpAndSettle(const Duration(milliseconds: 200));

        verify(
          () => images.loadAll(
            [
              components_assets.Assets.animations.adultEat.keyName,
              components_assets.Assets.animations.adultIdle.keyName,
              components_assets.Assets.animations.adultPetted.keyName,
              components_assets.Assets.animations.adultWalkCycle.keyName,
              components_assets.Assets.animations.teenEat.keyName,
              components_assets.Assets.animations.teenIdle.keyName,
              components_assets.Assets.animations.teenPetted.keyName,
              components_assets.Assets.animations.teenWalkCycle.keyName,
              components_assets.Assets.animations.childEat.keyName,
              components_assets.Assets.animations.childIdle.keyName,
              components_assets.Assets.animations.childPetted.keyName,
              components_assets.Assets.animations.childWalkCycle.keyName,
              components_assets.Assets.animations.babyEat.keyName,
              components_assets.Assets.animations.babyIdle.keyName,
              components_assets.Assets.animations.babyPetted.keyName,
              components_assets.Assets.animations.babyWalkCycle.keyName,
            ],
          ),
        ).called(1);
        expect(cubit.state.isComplete, false);
        expect(cubit.state.currentLabel, 'unicorns');
        await tester.pumpAndSettle(const Duration(milliseconds: 200));

        await future;

        expect(cubit.state.isComplete, true);
      });
    });
  });
}
