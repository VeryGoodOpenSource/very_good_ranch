import 'dart:math';

import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/foundation.dart';
import 'package:very_good_ranch/game/components/food_spawner.dart';

class VeryGoodRanchGame extends FlameGame
    with TapDetector, HasDraggables, HasCollisionDetection {
  VeryGoodRanchGame({
    Random? seed,
  }) : seed = seed ?? Random();

  /// The random number generator for this game, allowing it to be seed-able.
  final Random seed;

  @override
  bool get debugMode => kDebugMode;

  @override
  Color backgroundColor() => const Color(0xFFFFFFFF);

  @override
  Future<void>? onLoad() {
    add(FoodSpawner(seed: seed));
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
