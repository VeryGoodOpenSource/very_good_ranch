// ignore_for_file: prefer_const_constructors

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:ranch_components/ranch_components.dart';
import 'package:very_good_ranch/game/game.dart';
import 'package:very_good_ranch/inventory/inventory.dart';

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
      await tester.pumpApp(FoodItemEntry(type: FoodType.cake, count: 1));

      expect(find.byType(DecoratedBox), findsNWidgets(1));
    });

    testWidgets('removes food item correctly', (tester) async {
      when(() => inventoryBloc.state).thenReturn(
        InventoryState(foodItems: const [FoodType.cake]),
      );

      await tester.pumpApp(
        FoodItemEntry(type: FoodType.cake, count: 1),
        inventoryBloc: inventoryBloc,
        gameBloc: gameBloc,
      );

      await tester.tap(find.byType(DecoratedBox));
      await tester.pump(kDoubleTapMinTime);
      await tester.tap(find.byType(DecoratedBox));
      await tester.pumpAndSettle();

      verify(() => inventoryBloc.add(FoodItemRemoved(FoodType.cake))).called(1);
      verify(() => gameBloc.add(FoodSpawned(FoodType.cake))).called(1);
    });

    testWidgets('does not remove food if it does not have any', (tester) async {
      when(() => inventoryBloc.state).thenReturn(
        InventoryState(foodItems: const [FoodType.cake]),
      );

      await tester.pumpApp(
        FoodItemEntry(type: FoodType.cake, count: 0),
        inventoryBloc: inventoryBloc,
        gameBloc: gameBloc,
      );

      await tester.tap(find.byType(DecoratedBox));
      await tester.pump(kDoubleTapMinTime);
      await tester.tap(find.byType(DecoratedBox));
      await tester.pumpAndSettle();

      verifyNever(() => inventoryBloc.add(FoodItemRemoved(FoodType.cake)));
      verifyNever(() => gameBloc.add(FoodSpawned(FoodType.cake)));
    });
  });
}
