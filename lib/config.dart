import 'package:flutter/foundation.dart';

class Config {
  /// Unicorn Spawn
  static const unicornSpawnThreshold = 50.0;
  static const unicornInitialSpawnThreshold = 30.0;
  static const unicornVaryThresholdBy = 0.5;

  /// Food Spawn
  static const foodInitialSpawnThreshold = 10.0;
  static const foodSpawnThreshold = 4.0;
  static const foodVaryThresholdBy = 0.2;
  static const foodSpawnDecayRateBaby = 0.1;
  static const foodSpawnDecayRateChild = 0.15;
  static const foodSpawnDecayRateTeen = 0.2;
  static const foodSpawnDecayRateAdult = 0.35;

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
  static const double happinessThresholdToEvolve = 0.6;
  static const int timesThatMustBeFedToEvolve = 1;

  /// Leaving
  static const double happinessThresholdToLeave = 0.1;

  /// Moving
  static const double movingEvaluationCycle = 5;
  static const double probabilityToStartMoving = 0.8;

  /// Wander
  static const double circleDistance = 10;
  static const double maximumAngleDegree = 15;
  static const double startingAngleDegree = 0;

  /// Despawn
  static const double cakeDespawnTime = 30;
  static const double lollipopDespawnTime = 20;
  static const double iceCreamDespawnTime = 15;
  static const double pancakeDespawnTime = 10;
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
