import 'dart:math';

import 'package:flame/components.dart';
import 'package:ranch_components/ranch_components.dart';
import 'package:ranch_flame/ranch_flame.dart';
import 'package:very_good_ranch/game/entities/food/food.dart';

class FoodSpawner extends TimerComponent with HasGameRef {
  FoodSpawner({
    required this.seed,
    double spawnThreshold = 60.0,
  })  : _foodRarity = RarityList<FoodType>([
          Rarity(FoodType.candy, FoodType.candy.rarity),
          Rarity(FoodType.lollipop, FoodType.lollipop.rarity),
          Rarity(FoodType.pancake, FoodType.pancake.rarity),
          Rarity(FoodType.iceCream, FoodType.iceCream.rarity),
        ]),
        super(repeat: true, period: spawnThreshold);

  /// The random number generator for spawning food.
  final Random seed;

  final RarityList<FoodType> _foodRarity;

  @override
  void onTick() {
    final foodType = _foodRarity.getRandom(seed);
    final position = Vector2.random(seed)..multiply(gameRef.size);

    switch (foodType) {
      case FoodType.lollipop:
        add(Food.lollipop(position: position));
        break;
      case FoodType.pancake:
        add(Food.pancake(position: position));
        break;
      case FoodType.iceCream:
        add(Food.iceCream(position: position));
        break;
      case FoodType.candy:
        add(Food.candy(position: position));
        break;
    }
  }
}
