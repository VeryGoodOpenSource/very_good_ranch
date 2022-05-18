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
      await tester.pumpApp(FoodItemEntry(item: FoodItem(type: FoodType.candy)));

      expect(find.byType(Container), findsNWidgets(1));
    });

    testWidgets('removes food item correctly', (tester) async {
      final foodItem = FoodItem(type: FoodType.candy);
      when(() => inventoryBloc.state).thenReturn(
        InventoryState(foodItems: {foodItem}),
      );

      await tester.pumpApp(
        FoodItemEntry(item: FoodItem(type: FoodType.candy)),
        inventoryBloc: inventoryBloc,
        gameBloc: gameBloc,
      );

      await tester.tap(find.byType(Container));
      await tester.pump(kDoubleTapMinTime);
      await tester.tap(find.byType(Container));
      await tester.pumpAndSettle();

      verify(() => inventoryBloc.add(RemoveFoodItem(foodItem))).called(1);
      verify(() => gameBloc.add(SpawnFood(foodItem.type))).called(1);
    });
  });
}
