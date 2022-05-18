import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ranch_components/ranch_components.dart';
import 'package:very_good_ranch/game/bloc/game/game_bloc.dart';
import 'package:very_good_ranch/inventory/bloc/bloc.dart';

class FoodItemEntry extends StatelessWidget {
  const FoodItemEntry({Key? key, required this.item}) : super(key: key);

  final FoodItem item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        final inventoryBloc = BlocProvider.of<InventoryBloc>(context);
        final gameBloc = BlocProvider.of<GameBloc>(context);

        inventoryBloc.add(RemoveFoodItem(item));
        gameBloc.add(SpawnFood(item.type));
      },
      // NOTE: replace with sprite widget when we have sprites.
      child: Container(
        decoration: BoxDecoration(
          color: item.type.color,
          borderRadius: BorderRadius.circular(100),
        ),
      ),
    );
  }
}
