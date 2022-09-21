// ignore_for_file: cascade_invocations

import 'dart:math';

import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:ranch_components/ranch_components.dart';
import 'package:very_good_ranch/game/spawners/food_spawner.dart';

import '../../helpers/helpers.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Random seed;

  setUp(() {
    seed = MockRandom();
    when(() => seed.nextInt(any())).thenReturn(0);
    when(() => seed.nextDouble()).thenReturn(0);
    when(() => seed.nextBool()).thenReturn(false);
  });

  final flameTester = FlameTester<TestGame>(TestGame.new);

  group('FoodSpawner', () {
    flameTester.testGameWidget(
      'spawns a cake',
      setUp: (game, tester) async {
        when(() => seed.nextInt(100)).thenReturn(0);

        await game.ensureAdd(
          BackgroundComponent(
            children: [
              FoodSpawner(seed: seed, countUnicorns: (stage) => 0),
            ],
          ),
        );

        await game.ready();
        game.update(60);
        await game.ready();
      },
      verify: (game, tester) async {
        final foodComponents = game.descendants().whereType<FoodComponent>();
        expect(foodComponents.length, 1);
        expect(foodComponents.first.type, FoodType.cake);
      },
    );

    flameTester.testGameWidget(
      'spawns a lollipop',
      setUp: (game, tester) async {
        when(() => seed.nextInt(100)).thenReturn(60);
        await game.ensureAdd(
          BackgroundComponent(
            children: [
              FoodSpawner(seed: seed, countUnicorns: (stage) => 0),
            ],
          ),
        );

        await game.ready();
        game.update(60);
        await game.ready();
      },
      verify: (game, tester) async {
        final foodComponents = game.descendants().whereType<FoodComponent>();
        expect(foodComponents.length, 1);
        expect(foodComponents.first.type, FoodType.lollipop);
      },
    );

    flameTester.testGameWidget(
      'spawns a pancake',
      setUp: (game, tester) async {
        when(() => seed.nextInt(100)).thenReturn(80);
        await game.ensureAdd(
          BackgroundComponent(
            children: [
              FoodSpawner(seed: seed, countUnicorns: (stage) => 0),
            ],
          ),
        );

        await game.ready();
        game.update(60);
        await game.ready();
      },
      verify: (game, tester) async {
        final foodComponents = game.descendants().whereType<FoodComponent>();

        expect(foodComponents.length, 1);
        expect(foodComponents.first.type, FoodType.pancake);
      },
    );

    flameTester.testGameWidget(
      'spawns a ice cream',
      setUp: (game, tester) async {
        when(() => seed.nextInt(100)).thenReturn(90);
        await game.ensureAdd(
          BackgroundComponent(
            children: [
              FoodSpawner(seed: seed, countUnicorns: (stage) => 0),
            ],
          ),
        );

        await game.ready();
        game.update(60);
        await game.ready();
      },
      verify: (game, tester) async {
        final foodComponents = game.descendants().whereType<FoodComponent>();
        expect(foodComponents.length, 1);
        expect(foodComponents.first.type, FoodType.iceCream);
      },
    );

    flameTester.testGameWidget(
      'spawns food timely',
      setUp: (game, tester) async {
        await game.ensureAdd(
          BackgroundComponent(
            children: [
              FoodSpawner(seed: seed, countUnicorns: (stage) => 0),
            ],
          ),
        );
      },
      verify: (game, tester) async {
        when(() => seed.nextDouble()).thenReturn(0.5);
        int countFoodComponents() {
          return game.descendants().whereType<FoodComponent>().length;
        }

        expect(countFoodComponents(), equals(1));

        game.update(10);
        await tester.pump();
        await tester.pump();

        expect(countFoodComponents(), equals(2));

        game.update(10);
        await tester.pump();
        await tester.pump();

        expect(countFoodComponents(), equals(3));

        game.update(4);
        await tester.pump();
        await tester.pump();

        expect(countFoodComponents(), equals(4));
      },
    );
  });
}
