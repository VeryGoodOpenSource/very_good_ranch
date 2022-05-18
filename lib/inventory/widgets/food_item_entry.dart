import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ranch_components/ranch_components.dart';
import 'package:very_good_ranch/game/bloc/game/game_bloc.dart';
import 'package:very_good_ranch/inventory/bloc/bloc.dart';

class FoodItemEntry extends StatelessWidget {
  const FoodItemEntry({
    Key? key,
    required this.type,
    required this.count,
  }) : super(key: key);

  final FoodType type;

  final int count;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        if (count <= 0) {
          return;
        }
        final inventoryBloc = BlocProvider.of<InventoryBloc>(context);
        final gameBloc = BlocProvider.of<GameBloc>(context);

        inventoryBloc.add(RemoveFoodItem(type));
        gameBloc.add(SpawnFood(type));
      },
      // NOTE: replace with sprite widget when we have sprites.
      child: Container(
        decoration: BoxDecoration(
          color: type.color,
          borderRadius: BorderRadius.circular(100),
        ),
      ),
    );
  }
}
