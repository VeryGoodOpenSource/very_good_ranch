// ignore_for_file: cascade_invocations

import 'package:flame_test/flame_test.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ranch_components/ranch_components.dart';
import 'package:very_good_ranch/game/entities/food/behaviors/behaviors.dart';
import 'package:very_good_ranch/game/entities/food/food.dart';
import 'package:very_good_ranch/game/game.dart';
import 'package:very_good_ranch/inventory/inventory.dart';

import '../../../../helpers/helpers.dart';

void main() {
  late GameBloc gameBloc;
  late InventoryBloc inventoryBloc;

  setUp(() {
    gameBloc = MockGameBloc();
    when(() => gameBloc.state).thenReturn(const GameState());

    inventoryBloc = MockInventoryBloc();
    when(() => inventoryBloc.state).thenReturn(InventoryState());
  });

  final flameTester = FlameTester(TestGame.new);

  group('MoveToInventoryBehavior', () {
    flameTester.testGameWidget(
      'move to inventory on double tap',
      setUp: (game, tester) async {
        await game.ensureAdd(
          flameBlocProvider(
            gameBloc: gameBloc,
            inventoryBloc: inventoryBloc,
            child: Food.test(behaviors: [MoveToInventoryBehavior()]),
          ),
        );
        await game.ready();
      },
      verify: (game, tester) async {
        await tester.tapAt(Offset.zero);
        await tester.pump(kDoubleTapMinTime);
        await tester.tapAt(Offset.zero);
        await tester.pump();

        final foundFood = game.descendants().whereType<Food>().length;

        expect(foundFood, equals(0));

        verify(
          () => inventoryBloc.add(const FoodItemAdded(FoodType.cake)),
        ).called(1);

        // flush remaining timers created by the framework
        await tester.pump(kLongPressTimeout);
      },
    );
  });
}
