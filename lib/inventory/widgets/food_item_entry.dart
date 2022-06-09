import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ranch_components/ranch_components.dart';
import 'package:very_good_ranch/game/bloc/game/game_bloc.dart';
import 'package:very_good_ranch/inventory/bloc/bloc.dart';

class FoodItemEntry extends StatelessWidget {
  const FoodItemEntry({
    super.key,
    required this.type,
    required this.count,
  });

  final FoodType type;

  final int count;

  @override
  Widget build(BuildContext context) {
    final assetGenImage = type.assetGenImage;

    return GestureDetector(
      onDoubleTap: () {
        if (count <= 0) {
          return;
        }
        final inventoryBloc = context.read<InventoryBloc>();
        final gameBloc = context.read<GameBloc>();

        inventoryBloc.add(FoodItemRemoved(type));
        gameBloc.add(FoodSpawned(type));
      },
      // NOTE: replace with sprite widget when we have sprites.
      child: SizedBox.expand(
        child: Stack(
          children: [
            Positioned.fill(
              child: assetGenImage.image(),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Text('$count'),
            ),
          ],
        ),
      ),
    );
  }
}
