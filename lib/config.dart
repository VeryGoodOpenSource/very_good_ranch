import 'package:flutter/foundation.dart';

class Config {
  /// Unicorn Spawn
  static const unicornSpawnThreshold = 50.0;
  static const unicornInitialSpawnThreshold = 30.0;
  static const unicornVaryThresholdBy = 0.5;

  /// Food Spawn
  static const foodInitialSpawnThreshold = 10.0;
  static const foodSpawnThreshold = 5.0;
  static const foodVaryThresholdBy = 0.2;
  static const foodSpawnDecayRateBaby = 0.08;
  static const foodSpawnDecayRateChild = 0.12;
  static const foodSpawnDecayRateTeen = 0.16;
  static const foodSpawnDecayRateAdult = 0.30;

  /// Fullness
  static const fullnessDecreaseInterval = 0.5;
  static const fullnessDecreaseFactor = StageProperty(
    baby: 0.0050,
    child: 0.00625,
    teen: 0.0083,
    adult: 0.0125,
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
  static const fullnessFeedFactor = StageProperty(
    baby: 0.45,
    child: 0.25,
    teen: 0.18,
    adult: 0.25,
  );
  static const double positiveImpactOnEnjoyment = 0.6;
  static const double negativeImpactOnEnjoyment = -0.01;

  /// Petting
  static const petEnjoymentIncrease = StageProperty(
    baby: 0.3,
    child: 0.2,
    teen: 0.15,
    adult: 0.1,
  );
  static const petThrottleDuration = 1.0;

  /// Evolving
  static const double happinessThresholdToEvolve = 0.6;
  static const int timesThatMustBeFedToEvolve = 5;

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
  static const double lollipopDespawnTime = 23;
  static const double iceCreamDespawnTime = 16;
  static const double pancakeDespawnTime = 9;
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
