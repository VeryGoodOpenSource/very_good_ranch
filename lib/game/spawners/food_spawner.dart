import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:ranch_components/ranch_components.dart';
import 'package:ranch_flame/ranch_flame.dart';
import 'package:very_good_ranch/game/entities/entities.dart';
import 'package:very_good_ranch/game/entities/unicorn/behaviors/behaviors.dart';
import 'package:very_good_ranch/game/game.dart';

class FoodSpawner extends Component
    with
        ParentIsA<BackgroundComponent>,
        FlameBlocListenable<GameBloc, GameState> {
  FoodSpawner({
    required this.seed,
    required this.countUnicorns,
    this.initialSpawnThreshold = 15.0,
    this.spawnThreshold = 12.0,
    this.varyThresholdBy = 0.2,
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

  final ValueGetter<int> countUnicorns;

  late Timer _timer;

  int _spawnedFood = 0;

  final RarityList<FoodType> _foodRarity;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    _spawnFood(UnicornEvolutionStage.baby.preferredFoodType);
  }

  @override
  void onNewState(GameState state) {
    if (state.food != null) {
      _spawnFood(state.food);
    }
  }

  /// Decay [spawnThreshold] by 8% for each existing unicorn.
  ///
  /// The decau is only applied to the top 80% of the original
  /// [spawnThreshold] value to prevent the resulting value tending to zero.
  @visibleForTesting
  double get decayedSpawnThreshold {
    final minimalThreshold = spawnThreshold * 0.2;
    return exponentialDecay(
          spawnThreshold - minimalThreshold,
          0.08,
          countUnicorns(),
        ) +
        minimalThreshold;
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
    final pastureField = parent.pastureField;
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
