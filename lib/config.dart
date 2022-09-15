import 'package:flutter/cupertino.dart';

class Config {
  /// Unicorn Spawn
  static const unicornSpawnThreshold = 50.0;
  static const unicornInitialSpawnThreshold = 30.0;
  static const unicornVaryThresholdBy = 0.5;

  /// Food Spawn
  static const foodSpawnThreshold = 5.0;
  static const foodInitialSpawnThreshold = 10.0;
  static const foodVaryThresholdBy = 0.2;
  static const foodSpawnDecayRate = 0.1;

  /// Fullness
  static const fullnessDecreaseInterval = 0.5;
  static const fullnessDecreaseFactor = StageProperty(
    baby: 0.0050,
    child: 0.010,
    teen: 0.0150,
    adult: 0.020,
  );

  /// Enjoyment
  static const enjoymentDecreaseInterval = 0.5;
  static const enjoymentDecreaseFactor = StageProperty(
    baby: 0.0100,
    child: 0.0050,
    teen: 0.0030,
    adult: 0.0015,
  );

  /// Feeding
  static const wrongFoodImpactOnEnjoyment = StageProperty(
    baby: 0.3,
    child: 0.25,
    teen: 0.2,
    adult: 0.15,
  );

  /// Evolving
  static const double happinessThresholdToEvolve = 0.9;
  static const int timesThatMustBeFedToEvolve = 3;

  /// Leaving
  static const double happinessThresholdToLeave = 0.1;

  /// Moving
  static const double movingEvaluationCycle = 5;
  static const double probabilityToStartMoving = 0.8;

  /// Wander
  static const double circleDistance = 10;
  static const double maximumAngleDegree = 15;
  static const double startingAngleDegree = 0;
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
