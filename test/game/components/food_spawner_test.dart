// ignore_for_file: cascade_invocations

import 'dart:math';

import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:ranch_components/ranch_components.dart';
import 'package:very_good_ranch/game/game.dart';

import '../../helpers/helpers.dart';

void main() {
  late Random seed;

  setUp(() {
    seed = MockRandom();
    when(() => seed.nextInt(any())).thenReturn(0);
    when(seed.nextDouble).thenReturn(0);
    when(seed.nextBool).thenReturn(false);
  });

  final flameTester = FlameTester<VeryGoodRanchGame>(
    () => VeryGoodRanchGame(seed: seed),
  );

  group('FoodSpawner', () {
    flameTester.testGameWidget(
      'spawns a cupcake',
      setUp: (game, tester) async {
        when(() => seed.nextInt(any())).thenReturn(0);

        await game.ready();
        game.update(60);
        await tester.pump();
      },
      verify: (game, tester) async {
        final foodComponents = game.descendants().whereType<FoodComponent>();
        expect(foodComponents.length, 1);
        expect(foodComponents.first.type, FoodType.cupcake);
      },
    );

    flameTester.testGameWidget(
      'spawns a lolipop',
      setUp: (game, tester) async {
        when(() => seed.nextInt(any())).thenReturn(1);

        await game.ready();
        game.update(60);
        await tester.pump();
      },
      verify: (game, tester) async {
        final foodComponents = game.descendants().whereType<FoodComponent>();
        expect(foodComponents.length, 1);
        expect(foodComponents.first.type, FoodType.lolipop);
      },
    );

    flameTester.testGameWidget(
      'spawns a pancake',
      setUp: (game, tester) async {
        when(() => seed.nextInt(any())).thenReturn(2);

        await game.ready();
        game.update(60);
        await tester.pump();
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
        when(() => seed.nextInt(any())).thenReturn(3);

        await game.ready();
        game.update(60);
        await tester.pump();
      },
      verify: (game, tester) async {
        final foodComponents = game.descendants().whereType<FoodComponent>();
        expect(foodComponents.length, 1);
        expect(foodComponents.first.type, FoodType.iceCream);
      },
    );

    flameTester.testGameWidget(
      'spawns a candy',
      setUp: (game, tester) async {
        when(() => seed.nextInt(any())).thenReturn(4);

        await game.ready();
        game.update(60);
        await tester.pump();
      },
      verify: (game, tester) async {
        final foodComponents = game.descendants().whereType<FoodComponent>();
        expect(foodComponents.length, 1);
        expect(foodComponents.first.type, FoodType.candy);
      },
    );
  });
}
