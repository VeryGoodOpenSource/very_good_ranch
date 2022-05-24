// ignore_for_file: cascade_invocations

import 'package:flame/components.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ranch_components/ranch_components.dart';
import 'package:very_good_ranch/game/entities/food/behaviors/behaviors.dart';
import 'package:very_good_ranch/game/entities/food/food.dart';

import '../../../helpers/helpers.dart';

class _MockDraggableFoodBehavior extends Mock implements DraggableFoodBehavior {
}

void main() {
  final flameTester = FlameTester(TestGame.new);

  group('Food', () {
    flameTester.testGameWidget(
      'candy',
      setUp: (game, tester) async {
        await game.add(Food.candy(position: Vector2.zero()));
      },
      verify: (game, tester) async {
        await tester.pump();

        final food = game.children.whereType<Food>().first;
        expect(food.type, FoodType.candy);
        expect(food.nutrition, FoodType.candy.nutrition);

        await expectLater(
          find.byGame<TestGame>(),
          matchesGoldenFile('golden/food/types/candy.png'),
        );
      },
    );

    flameTester.testGameWidget(
      'lollipop',
      setUp: (game, tester) async {
        await game.add(Food.lollipop(position: Vector2.zero()));
      },
      verify: (game, tester) async {
        await tester.pump();

        final food = game.children.whereType<Food>().first;
        expect(food.type, FoodType.lollipop);
        expect(food.nutrition, FoodType.lollipop.nutrition);

        await expectLater(
          find.byGame<TestGame>(),
          matchesGoldenFile('golden/food/types/lollipop.png'),
        );
      },
    );

    flameTester.testGameWidget(
      'pancake',
      setUp: (game, tester) async {
        await game.add(Food.pancake(position: Vector2.zero()));
      },
      verify: (game, tester) async {
        await tester.pump();

        final food = game.children.whereType<Food>().first;
        expect(food.type, FoodType.pancake);
        expect(food.nutrition, FoodType.pancake.nutrition);

        await expectLater(
          find.byGame<TestGame>(),
          matchesGoldenFile('golden/food/types/pancake.png'),
        );
      },
    );

    flameTester.testGameWidget(
      'iceCream',
      setUp: (game, tester) async {
        await game.add(Food.iceCream(position: Vector2.zero()));
      },
      verify: (game, tester) async {
        await tester.pump();

        final food = game.children.whereType<Food>().first;
        expect(food.type, FoodType.iceCream);
        expect(food.nutrition, FoodType.iceCream.nutrition);

        await expectLater(
          find.byGame<TestGame>(),
          matchesGoldenFile('golden/food/types/ice_cream.png'),
        );
      },
    );
  });

  group('food beingDragged', () {
    flameTester.test(
      'proxies from the behavior',
      (game) async {
        final draggableFoodBehavior = _MockDraggableFoodBehavior();

        final food = Food.test(behaviors: [draggableFoodBehavior]);
        await game.ensureAdd(food);
        await game.ready();

        when(() => draggableFoodBehavior.beingDragged).thenReturn(true);
        expect(food.beingDragged, true);
        when(() => draggableFoodBehavior.beingDragged).thenReturn(false);
        expect(food.beingDragged, false);
      },
    );
  });
}
