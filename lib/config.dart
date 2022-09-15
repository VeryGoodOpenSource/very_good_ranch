import 'package:flutter/cupertino.dart';

class Config {
  /// Unicorn Spawn
  static const unicornSpawnThreshold = 50.0;
  static const unicornInitialSpawnThreshold = 30.0;
  static const unicornVaryThresholdBy = 0.5;

  /// Food Spawn
  static const foodSpawnThreshold = 15.0;
  static const foodInitialSpawnThreshold = 12.0;
  static const foodVaryThresholdBy = 0.2;
  static const foodSpawnDecayRate = 0.1;

  /// Fullness
  static const fullnessDecreaseInterval = 0.5;
  static const fullnessDecreaseFactor = StageProperty(
    baby: 0.005,
    child: 0.01,
    teen: 0.015,
    adult: 0.02,
  );

  /// Enjoyment
  static const enjoymentDecreaseInterval = 0.5;
  static const enjoymentDecreaseFactor = StageProperty(
    baby: 0.0020,
    child: 0.0015,
    teen: 0.0010,
    adult: 0.0005,
  );
}

@immutable
class StageProperty<T> {
  const StageProperty({
    required this.baby,
    required this.child,
    required this.teen,
    required this.adult,
  });

  final T baby;
  final T child;
  final T teen;
  final T adult;
}
