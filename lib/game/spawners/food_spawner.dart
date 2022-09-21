import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:ranch_components/ranch_components.dart';
import 'package:ranch_flame/ranch_flame.dart';
import 'package:very_good_ranch/config.dart';
import 'package:very_good_ranch/game/entities/entities.dart';
import 'package:very_good_ranch/game/entities/unicorn/behaviors/behaviors.dart';

typedef UnicornCount = int Function(UnicornEvolutionStage stage);

class FoodSpawner extends Component with ParentIsA<BackgroundComponent> {
  FoodSpawner({
    required this.seed,
    required this.countUnicorns,
    this.initialSpawnThreshold = Config.foodInitialSpawnThreshold,
    this.spawnThreshold = Config.foodSpawnThreshold,
    this.varyThresholdBy = Config.foodVaryThresholdBy,
  }) : _foodRarity = RarityList<FoodType>([
          Rarity(FoodType.cake, FoodType.cake.rarity),
          Rarity(FoodType.lollipop, FoodType.lollipop.rarity),
          Rarity(FoodType.pancake, FoodType.pancake.rarity),
          Rarity(FoodType.iceCream, FoodType.iceCream.rarity),
        ]);

  /// The random number generator for spawning food.
  final Random seed;

  final double spawnThreshold;
  final double initialSpawnThreshold;
  final double varyThresholdBy;

  final UnicornCount countUnicorns;

  late Timer _timer;

  int _spawnedFood = 0;

  final RarityList<FoodType> _foodRarity;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    _spawnFood(UnicornEvolutionStage.baby.preferredFoodType);
  }

  /// Decay [spawnThreshold] by 8% for each existing unicorn.
  ///
  /// The decay is only applied to the top 80% of the original
  /// [spawnThreshold] value to prevent the resulting value tending to zero.
  @visibleForTesting
  double get decayedSpawnThreshold {
    final minimalThreshold = spawnThreshold * 0.15;

    // Decay by baby unicorns

    final decayedByBaby = exponentialDecay(
      spawnThreshold - minimalThreshold,
      Config.foodSpawnDecayRateBaby,
      countUnicorns(UnicornEvolutionStage.baby),
    );

    final decayedByChild = exponentialDecay(
      decayedByBaby,
      Config.foodSpawnDecayRateChild,
      countUnicorns(UnicornEvolutionStage.child),
    );

    final decayedByTeen = exponentialDecay(
      decayedByChild,
      Config.foodSpawnDecayRateTeen,
      countUnicorns(UnicornEvolutionStage.teen),
    );

    final decayedByAdult = exponentialDecay(
      decayedByTeen,
      Config.foodSpawnDecayRateAdult,
      countUnicorns(UnicornEvolutionStage.adult),
    );

    return decayedByAdult + minimalThreshold;
  }

  void _scheduleNextFood() {
    final double nextLimit;
    if (_spawnedFood < 3) {
      nextLimit = initialSpawnThreshold;
    } else {
      final decayedSpawnThreshold = this.decayedSpawnThreshold;
      final variation = varyThresholdBy * decayedSpawnThreshold;
      nextLimit =
          decayedSpawnThreshold + exponentialDistribution(seed) * variation;
    }
    _timer = Timer(nextLimit, onTick: _spawnFood);
  }

  void _spawnFood([FoodType? foodType]) {
    _spawnedFood++;

    final type = foodType ?? _foodRarity.getRandom(seed);
    final pastureField = parent.pastureField.deflate(50);
    final position = Vector2.random(seed)
      ..multiply(pastureField.size.toVector2())
      ..add(pastureField.topLeft.toVector2())
      ..sub(type.size);

    switch (type) {
      case FoodType.lollipop:
        parent.add(Food.lollipop(position: position));
        break;
      case FoodType.pancake:
        parent.add(Food.pancake(position: position));
        break;
      case FoodType.iceCream:
        parent.add(Food.iceCream(position: position));
        break;
      case FoodType.cake:
        parent.add(Food.cake(position: position));
        break;
    }

    _scheduleNextFood();
  }

  @override
  void update(double dt) {
    super.update(dt);
    _timer.update(dt);
  }
}
