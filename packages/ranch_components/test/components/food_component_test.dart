// ignore_for_file: cascade_invocations

import 'dart:ui';

import 'package:flame/cache.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ranch_components/gen/assets.gen.dart';
import 'package:ranch_components/ranch_components.dart';

import '../helpers/helpers.dart';

class MockImages extends Mock implements Images {}

void main() {
  final flameTester = FlameTester(TestGame.new);

  group('FoodComponent', () {
    group('preloadAssets', () {
      testWidgets('preloads assets', (tester) async {
        final images = MockImages();

        when(
          () => images.loadAll(any()),
        ).thenAnswer((Invocation invocation) => Future.value(<Image>[]));

        await FoodComponent.preloadAssets(images);

        verify(
          () => images.loadAll(
            [
              Assets.food.icecream.keyName,
              Assets.food.cake.keyName,
              Assets.food.lollipop.keyName,
              Assets.food.pancakes.keyName,
            ],
          ),
        ).called(1);
      });
    });

    flameTester.testGameWidget(
      'cake',
      setUp: (game, tester) async {
        await game.add(FoodComponent.ofType(FoodType.cake));
      },
      verify: (game, tester) async {
        final food = game.children.whereType<FoodComponent>().first;
        expect(food.type, FoodType.cake);

        await expectLater(
          find.byGame<TestGame>(),
          matchesGoldenFile('golden/food_component/types/cake.png'),
        );
      },
    );

    flameTester.testGameWidget(
      'lollipop',
      setUp: (game, tester) async {
        await game.add(FoodComponent.ofType(FoodType.lollipop));
      },
      verify: (game, tester) async {
        final food = game.children.whereType<FoodComponent>().first;
        expect(food.type, FoodType.lollipop);

        await expectLater(
          find.byGame<TestGame>(),
          matchesGoldenFile('golden/food_component/types/lollipop.png'),
        );
      },
    );

    flameTester.testGameWidget(
      'pancake',
      setUp: (game, tester) async {
        await game.add(FoodComponent.ofType(FoodType.pancake));
      },
      verify: (game, tester) async {
        final food = game.children.whereType<FoodComponent>().first;
        expect(food.type, FoodType.pancake);

        await expectLater(
          find.byGame<TestGame>(),
          matchesGoldenFile('golden/food_component/types/pancake.png'),
        );
      },
    );

    flameTester.testGameWidget(
      'iceCream',
      setUp: (game, tester) async {
        await game.add(FoodComponent.ofType(FoodType.iceCream));
      },
      verify: (game, tester) async {
        final food = game.children.whereType<FoodComponent>().first;
        expect(food.type, FoodType.iceCream);

        await expectLater(
          find.byGame<TestGame>(),
          matchesGoldenFile('golden/food_component/types/ice_cream.png'),
        );
      },
    );
  });

  group('FoodType', () {
    test('nutrition', () {
      expect(FoodType.cake.nutrition, 1);
      expect(FoodType.lollipop.nutrition, 2);
      expect(FoodType.pancake.nutrition, 3);
      expect(FoodType.iceCream.nutrition, 4);
    });

    test('rarity', () {
      expect(FoodType.cake.rarity, 40);
      expect(FoodType.lollipop.rarity, 30);
      expect(FoodType.pancake.rarity, 20);
      expect(FoodType.iceCream.rarity, 10);
    });
  });
}
