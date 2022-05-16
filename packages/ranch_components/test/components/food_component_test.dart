// ignore_for_file: cascade_invocations

import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ranch_components/ranch_components.dart';

import '../helpers/helpers.dart';

void main() {
  final flameTester = FlameTester(TestGame.new);

  group('FoodComponent', () {
    flameTester.testGameWidget(
      'candy',
      setUp: (game, tester) async {
        await game.add(FoodComponent(type: FoodType.candy));
      },
      verify: (game, tester) async {
        final food = game.children.whereType<FoodComponent>().first;
        expect(food.type, FoodType.candy);

        await expectLater(
          find.byGame<TestGame>(),
          matchesGoldenFile('golden/food_component/types/candy.png'),
        );
      },
    );

    flameTester.testGameWidget(
      'lollipop',
      setUp: (game, tester) async {
        await game.add(FoodComponent(type: FoodType.lollipop));
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
        await game.add(FoodComponent(type: FoodType.pancake));
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
        await game.add(FoodComponent(type: FoodType.iceCream));
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
      expect(FoodType.candy.nutrition, 1);
      expect(FoodType.lollipop.nutrition, 2);
      expect(FoodType.pancake.nutrition, 3);
      expect(FoodType.iceCream.nutrition, 4);
    });

    test('rarity', () {
      expect(FoodType.candy.rarity, 40);
      expect(FoodType.lollipop.rarity, 30);
      expect(FoodType.pancake.rarity, 20);
      expect(FoodType.iceCream.rarity, 10);
    });
  });
}
