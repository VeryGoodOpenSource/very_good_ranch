// ignore_for_file: prefer_const_constructors

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:ranch_components/ranch_components.dart';
import 'package:very_good_ranch/game/game.dart';
import 'package:very_good_ranch/inventory/inventory.dart';
import 'package:very_good_ranch/inventory/widgets/widgets.dart';

import '../../helpers/helpers.dart';

void main() {
  group('FoodItemEntry', () {
    late InventoryBloc inventoryBloc;
    late GameBloc gameBloc;

    setUp(() {
      inventoryBloc = MockInventoryBloc();
      when(() => inventoryBloc.state).thenReturn(InventoryState());

      gameBloc = MockGameBloc();
      when(() => gameBloc.state).thenReturn(GameState());
    });

    testWidgets('renders correctly', (tester) async {
      await tester.pumpApp(FoodItemEntry(type: FoodType.candy, count: 1));

      expect(find.byType(Container), findsNWidgets(1));
    });

    // TODO(wolfen): if there are none of the food item, it should not be displayed

    testWidgets('removes food item correctly', (tester) async {
      when(() => inventoryBloc.state).thenReturn(
        InventoryState(foodItems: const [FoodType.candy]),
      );

      await tester.pumpApp(
        FoodItemEntry(type: FoodType.candy, count: 1),
        inventoryBloc: inventoryBloc,
        gameBloc: gameBloc,
      );

      await tester.tap(find.byType(Container));
      await tester.pump(kDoubleTapMinTime);
      await tester.tap(find.byType(Container));
      await tester.pumpAndSettle();

      verify(() => inventoryBloc.add(RemoveFoodItem(FoodType.candy))).called(1);
      verify(() => gameBloc.add(SpawnFood(FoodType.candy))).called(1);
    });

    testWidgets('does not remove food if it doesnt have any', (tester) async {
      when(() => inventoryBloc.state).thenReturn(
        InventoryState(foodItems: const [FoodType.candy]),
      );

      await tester.pumpApp(
        FoodItemEntry(type: FoodType.candy, count: 0),
        inventoryBloc: inventoryBloc,
        gameBloc: gameBloc,
      );

      await tester.tap(find.byType(Container));
      await tester.pump(kDoubleTapMinTime);
      await tester.tap(find.byType(Container));
      await tester.pumpAndSettle();

      verifyNever(() => inventoryBloc.add(RemoveFoodItem(FoodType.candy)));
      verifyNever(() => gameBloc.add(SpawnFood(FoodType.candy)));
    });
  });
}
