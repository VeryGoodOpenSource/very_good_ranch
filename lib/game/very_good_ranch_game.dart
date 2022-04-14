import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/foundation.dart';
import 'package:ranch_components/ranch_components.dart';

class VeryGoodRanchGame extends FlameGame
    with TapDetector, HasDraggables, HasCollisionDetection {
  VeryGoodRanchGame({
    Random? seed,
  }) : seed = seed ?? Random();

  /// The random number generator for this game, allowing it to be seed-able.
  final Random seed;

  /// The food spawn time threshold, in seconds.
  final foodSpawnThreshold = 60.0;

  @override
  bool get debugMode => kDebugMode;

  @override
  Color backgroundColor() => const Color(0xFFFFFFFF);

  @override
  Future<void>? onLoad() {
    add(
      TimerComponent(
        period: foodSpawnThreshold,
        repeat: true,
        onTick: () {
          final foodType =
              FoodType.values[seed.nextInt(FoodType.values.length)];
          final position = Vector2.random(seed)..multiply(size);

          switch (foodType) {
            case FoodType.cupcake:
              add(FoodComponent.cupcake(position: position));
              break;
            case FoodType.lolipop:
              add(FoodComponent.lolipop(position: position));
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
        },
      ),
    );
    return null;
  }

  @override
  void onTapUp(TapUpInfo info) {
    if (overlays.value.isNotEmpty) {
      overlays.clear();
    }
    return super.onTapUp(info);
  }
}
