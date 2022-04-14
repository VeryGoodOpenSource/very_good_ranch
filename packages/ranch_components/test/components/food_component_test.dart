// ignore_for_file: cascade_invocations

import 'package:flame/game.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ranch_components/ranch_components.dart';

import '../helpers/helpers.dart';

void main() {
  final flameTester = FlameTester(TestGame.new);

  group('FoodComponent', () {
    flameTester.test(
      'loads correctly',
      (game) async {
        final food = FoodComponent(
          position: Vector2.zero(),
          saturation: 0,
          type: FoodType.candy,
        );
        await game.ready();
        await game.ensureAdd(food);

        expect(game.contains(food), isTrue);
      },
    );

    flameTester.testGameWidget(
      'is draggable',
      setUp: (game, tester) async {
        await game.add(
          FoodComponent(
            position: Vector2.zero(),
            saturation: 0,
            type: FoodType.candy,
          ),
        );
      },
      verify: (game, tester) async {
        await tester.dragFrom(
          Offset.zero,
          const Offset(100, 100),
        );
        await tester.pump();

        await expectLater(
          find.byGame<TestGame>(),
          matchesGoldenFile('golden/food_component/dragged.png'),
        );
      },
    );

    group('cupcake', () {
      flameTester.testGameWidget(
        'renders correctly',
        setUp: (game, tester) async {
          await game.add(
            FoodComponent.cupcake(position: Vector2.zero()),
          );
        },
        verify: (game, tester) async {
          final food = game.children.whereType<FoodComponent>().first;
          expect(food.type, FoodType.cupcake);
          expect(food.saturation, 2.5);

          await expectLater(
            find.byGame<TestGame>(),
            matchesGoldenFile('golden/food_component/types/cupcake.png'),
          );
        },
      );
    });

    group('lolipop', () {
      flameTester.testGameWidget(
        'renders correctly',
        setUp: (game, tester) async {
          await game.add(
            FoodComponent.lolipop(position: Vector2.zero()),
          );
        },
        verify: (game, tester) async {
          final food = game.children.whereType<FoodComponent>().first;
          expect(food.type, FoodType.lolipop);
          expect(food.saturation, 1.5);

          await expectLater(
            find.byGame<TestGame>(),
            matchesGoldenFile('golden/food_component/types/lolipop.png'),
          );
        },
      );
    });

    group('pancake', () {
      flameTester.testGameWidget(
        'renders correctly',
        setUp: (game, tester) async {
          await game.add(
            FoodComponent.pancake(position: Vector2.zero()),
          );
        },
        verify: (game, tester) async {
          final food = game.children.whereType<FoodComponent>().first;
          expect(food.type, FoodType.pancake);
          expect(food.saturation, 3);

          await expectLater(
            find.byGame<TestGame>(),
            matchesGoldenFile('golden/food_component/types/pancake.png'),
          );
        },
      );
    });

    group('iceCream', () {
      flameTester.testGameWidget(
        'renders correctly',
        setUp: (game, tester) async {
          await game.add(FoodComponent.iceCream(position: Vector2.zero()));
        },
        verify: (game, tester) async {
          final food = game.children.whereType<FoodComponent>().first;
          expect(food.type, FoodType.iceCream);
          expect(food.saturation, 2);

          await expectLater(
            find.byGame<TestGame>(),
            matchesGoldenFile('golden/food_component/types/iceCream.png'),
          );
        },
      );
    });

    group('candy', () {
      flameTester.testGameWidget(
        'renders correctly',
        setUp: (game, tester) async {
          await game.add(FoodComponent.candy(position: Vector2.zero()));
        },
        verify: (game, tester) async {
          final food = game.children.whereType<FoodComponent>().first;
          expect(food.type, FoodType.candy);
          expect(food.saturation, 1);

          await expectLater(
            find.byGame<TestGame>(),
            matchesGoldenFile('golden/food_component/types/candy.png'),
          );
        },
      );
    });
  });
}
