import 'dart:math';

import 'package:flame/components.dart';
import 'package:ranch_components/ranch_components.dart';

class FoodSpawner extends TimerComponent with HasGameRef {
  FoodSpawner({
    required this.seed,
    double spawnThreshold = 60.0,
  }) : super(repeat: true, period: spawnThreshold);

  /// The random number generator for spawning food.
  final Random seed;

  @override
  void onTick() {
    final foodType = FoodType.values[seed.nextInt(FoodType.values.length)];
    final position = Vector2.random(seed)..multiply(gameRef.size);

    switch (foodType) {
      case FoodType.cupcake:
        add(FoodComponent.cupcake(position: position));
        break;
      case FoodType.lollipop:
        add(FoodComponent.lollipop(position: position));
        break;
      case FoodType.pancake:
        add(FoodComponent.pancake(position: position));
        break;
      case FoodType.iceCream:
        add(FoodComponent.iceCream(position: position));
        break;
      case FoodType.candy:
        add(FoodComponent.candy(position: position));
        break;
    }
  }
}
