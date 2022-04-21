import 'package:flame/components.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ranch_components/ranch_components.dart';
import 'package:very_good_ranch/game/entities/food/food.dart';

import '../../../helpers/helpers.dart';

void main() {
  final flameTester = FlameTester(TestGame.new);

  group('Food', () {
    group('cupcake', () {
      flameTester.testGameWidget(
        'renders correctly',
        setUp: (game, tester) async {
          await game.add(
            Food.cupcake(position: Vector2.zero()),
          );
        },
        verify: (game, tester) async {
          final food = game.children.whereType<Food>().first;
          expect(food.type, FoodType.cupcake);
          expect(food.saturation, 2.5);

          await expectLater(
            find.byGame<TestGame>(),
            matchesGoldenFile('golden/food/types/cupcake.png'),
          );
        },
      );
    });

    group('lollipop', () {
      flameTester.testGameWidget(
        'renders correctly',
        setUp: (game, tester) async {
          await game.add(
            Food.lollipop(position: Vector2.zero()),
          );
        },
        verify: (game, tester) async {
          final food = game.children.whereType<Food>().first;
          expect(food.type, FoodType.lollipop);
          expect(food.saturation, 1.5);

          await expectLater(
            find.byGame<TestGame>(),
            matchesGoldenFile('golden/food/types/lollipop.png'),
          );
        },
      );
    });

    group('pancake', () {
      flameTester.testGameWidget(
        'renders correctly',
        setUp: (game, tester) async {
          await game.add(
            Food.pancake(position: Vector2.zero()),
          );
        },
        verify: (game, tester) async {
          final food = game.children.whereType<Food>().first;
          expect(food.type, FoodType.pancake);
          expect(food.saturation, 3);

          await expectLater(
            find.byGame<TestGame>(),
            matchesGoldenFile('golden/food/types/pancake.png'),
          );
        },
      );
    });

    group('iceCream', () {
      flameTester.testGameWidget(
        'renders correctly',
        setUp: (game, tester) async {
          await game.add(Food.iceCream(position: Vector2.zero()));
        },
        verify: (game, tester) async {
          final food = game.children.whereType<Food>().first;
          expect(food.type, FoodType.iceCream);
          expect(food.saturation, 2);

          await expectLater(
            find.byGame<TestGame>(),
            matchesGoldenFile('golden/food/types/iceCream.png'),
          );
        },
      );
    });

    group('candy', () {
      flameTester.testGameWidget(
        'renders correctly',
        setUp: (game, tester) async {
          await game.add(Food.candy(position: Vector2.zero()));
        },
        verify: (game, tester) async {
          final food = game.children.whereType<Food>().first;
          expect(food.type, FoodType.candy);
          expect(food.saturation, 1);

          await expectLater(
            find.byGame<TestGame>(),
            matchesGoldenFile('golden/food/types/candy.png'),
          );
        },
      );
    });
  });
}
