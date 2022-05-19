// ignore_for_file: cascade_invocations

import 'dart:math';

import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:ranch_components/ranch_components.dart';
import 'package:very_good_ranch/game/bloc/game/game_bloc.dart';
import 'package:very_good_ranch/game/spawners/food_spawner.dart';
import 'package:very_good_ranch/inventory/inventory.dart';

import '../../helpers/helpers.dart';

void main() {
  late Random seed;
  late GameBloc gameBloc;
  late InventoryBloc inventoryBloc;

  setUp(() {
    seed = MockRandom();
    when(() => seed.nextInt(any())).thenReturn(0);
    when(() => seed.nextDouble()).thenReturn(0);
    when(() => seed.nextBool()).thenReturn(false);

    gameBloc = MockGameBloc();
    when(() => gameBloc.state).thenReturn(const GameState());

    inventoryBloc = MockInventoryBloc();
    when(() => inventoryBloc.state).thenReturn(InventoryState());
  });

  final flameTester = FlameTester<TestGame>(TestGame.new);

  group('FoodSpawner', () {
    flameTester.testGameWidget(
      'spawns a candy',
      setUp: (game, tester) async {
        when(() => seed.nextInt(100)).thenReturn(0);
        await game.ensureAdd(
          flameBlocProvider(
            gameBloc: gameBloc,
            inventoryBloc: inventoryBloc,
            child: FoodSpawner(seed: seed),
          ),
        );

        await game.ready();
        game.update(60);
        await game.ready();
      },
      verify: (game, tester) async {
        final foodComponents = game.descendants().whereType<FoodComponent>();
        expect(foodComponents.length, 1);
        expect(foodComponents.first.type, FoodType.candy);
      },
    );

    flameTester.testGameWidget(
      'spawns a lollipop',
      setUp: (game, tester) async {
        when(() => seed.nextInt(100)).thenReturn(60);
        await game.ensureAdd(
          flameBlocProvider(
            gameBloc: gameBloc,
            inventoryBloc: inventoryBloc,
            child: FoodSpawner(seed: seed),
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
          flameBlocProvider(
            gameBloc: gameBloc,
            inventoryBloc: inventoryBloc,
            child: FoodSpawner(seed: seed),
          ),
        );

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
        when(() => seed.nextInt(100)).thenReturn(90);
        await game.ensureAdd(
          flameBlocProvider(
            gameBloc: gameBloc,
            inventoryBloc: inventoryBloc,
            child: FoodSpawner(seed: seed),
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
      'spawn food when game state changes',
      setUp: (game, tester) async {
        final gameBloc = GameBloc();
        await game.ensureAdd(
          flameBlocProvider(
            gameBloc: gameBloc,
            inventoryBloc: inventoryBloc,
            child: FoodSpawner(seed: seed),
          ),
        );

        await game.ready();
        gameBloc.add(const FoodSpawned(FoodType.candy));
        await game.ready();
      },
      verify: (game, tester) async {
        final foodComponents = game.descendants().whereType<FoodComponent>();
        expect(foodComponents.length, 1);
        expect(foodComponents.first.type, FoodType.candy);
      },
    );
  });
}
