// ignore_for_file: cascade_invocations

import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ranch_components/ranch_components.dart';

import '../helpers/helpers.dart';

void main() {
  final flameTester = FlameTester(TestGame.new);

  group('FoodComponent', () {
    flameTester.testGameWidget(
      'cupcake',
      setUp: (game, tester) async {
        await game.add(FoodComponent(type: FoodType.cupcake));
      },
      verify: (game, tester) async {
        final food = game.children.whereType<FoodComponent>().first;
        expect(food.type, FoodType.cupcake);

        await expectLater(
          find.byGame<TestGame>(),
          matchesGoldenFile('golden/food_component/types/cupcake.png'),
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
  });
}
