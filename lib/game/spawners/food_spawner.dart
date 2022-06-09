import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:ranch_components/ranch_components.dart';
import 'package:ranch_flame/ranch_flame.dart';
import 'package:very_good_ranch/game/components/components.dart';
import 'package:very_good_ranch/game/entities/food/food.dart';
import 'package:very_good_ranch/game/game.dart';

class FoodSpawner extends TimerComponent
    with ParentIsA<PastureField>, FlameBlocListenable<GameBloc, GameState> {
  FoodSpawner({
    required this.seed,
    double spawnThreshold = 60.0,
  })  : _foodRarity = RarityList<FoodType>([
          Rarity(FoodType.cake, FoodType.cake.rarity),
          Rarity(FoodType.lollipop, FoodType.lollipop.rarity),
          Rarity(FoodType.pancake, FoodType.pancake.rarity),
          Rarity(FoodType.iceCream, FoodType.iceCream.rarity),
        ]),
        super(repeat: true, period: spawnThreshold);

  /// The random number generator for spawning food.
  final Random seed;

  final RarityList<FoodType> _foodRarity;

  @override
  void onNewState(GameState state) {
    if (state.food != null) {
      _spawnFood(state.food!);
    }
  }

  @override
  void onTick() {
    final foodType = _foodRarity.getRandom(seed);
    _spawnFood(foodType);
  }

  void _spawnFood(FoodType type) {
    final position = Vector2.random(seed)
      ..multiply(parent.size)
      ..sub(type.size);

    switch (type) {
      case FoodType.lollipop:
        add(Food.lollipop(position: position));
        break;
      case FoodType.pancake:
        add(Food.pancake(position: position));
        break;
      case FoodType.iceCream:
        add(Food.iceCream(position: position));
        break;
      case FoodType.cake:
        add(Food.cake(position: position));
        break;
    }
  }
}
