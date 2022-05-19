// ignore_for_file: prefer_const_constructors,
// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:ranch_components/ranch_components.dart';
import 'package:very_good_ranch/game/bloc/game/game_bloc.dart';
import 'package:very_good_ranch/inventory/inventory.dart';
import 'package:very_good_ranch/inventory/widgets/widgets.dart';
import 'package:very_good_ranch/l10n/l10n.dart';

import '../../helpers/helpers.dart';

void main() {
  group('InventoryDialog', () {
    late InventoryBloc inventoryBloc;
    late GameBloc gameBloc;

    setUp(() {
      inventoryBloc = MockInventoryBloc();
      when(() => inventoryBloc.state).thenReturn(InventoryState());

      gameBloc = MockGameBloc();
      when(() => gameBloc.state).thenReturn(GameState());
    });

    testWidgets('renders correctly', (tester) async {
      final l10n = await AppLocalizations.delegate.load(Locale('en'));
      when(() => inventoryBloc.state).thenReturn(
        InventoryState(
          foodItems: [
            FoodType.candy,
            FoodType.lollipop,
            FoodType.pancake,
            FoodType.iceCream,
          ],
        ),
      );
      await tester.pumpApp(InventoryDialog(), inventoryBloc: inventoryBloc);

      expect(find.byType(Text), findsNWidgets(1));
      expect(find.byType(FoodItemEntry), findsNWidgets(4));
      expect(find.text(l10n.inventory), findsOneWidget);
    });

    testWidgets('removes food item correctly', (tester) async {
      when(() => inventoryBloc.state).thenReturn(
        InventoryState(foodItems: [FoodType.candy]),
      );
      await tester.pumpApp(
        InventoryDialog(),
        inventoryBloc: inventoryBloc,
        gameBloc: gameBloc,
      );

      await tester.tap(find.byKey(const Key('food_item_0')));
      await tester.pump(kDoubleTapMinTime);
      await tester.tap(find.byKey(const Key('food_item_0')));
      await tester.pumpAndSettle();

      verify(() => inventoryBloc.add(FoodItemRemoved(FoodType.candy)))
          .called(1);
      verify(() => gameBloc.add(FoodSpawned(FoodType.candy))).called(1);
    });
  });
}
