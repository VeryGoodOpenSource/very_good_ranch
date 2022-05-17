import 'package:ranch_components/ranch_components.dart';
import 'package:very_good_ranch/game/entities/entities.dart';

/// A description of the [Unicorn] progression constraints given its
/// [fullnessFactor] and [enjoymentFactor].
abstract class UnicornStage {
  UnicornStage({
    double initialFullnessFactor = 1,
    double initialEnjoymentFactor = 1,
  })  : fullnessFactor = initialFullnessFactor,
        enjoymentFactor = initialEnjoymentFactor;

  /// A state that describes how well fed is the unicorn.
  double fullnessFactor;

  /// A state that describes how many times the unicorn ate a [Food].
  int timesFed = 0;

  /// A state that describes how well treated is the unicorn.
  double enjoymentFactor;

  double get happinessFactor => fullnessFactor * enjoymentFactor;

  FoodType get preferredFoodType;

  bool get shouldEvolve;

  UnicornStage evolve();
}

class BabyUnicornStage extends UnicornStage {
  static const double happinessThresholdToEvolve = 1;
  static const int timesThatMustBeFed = 4;

  @override
  FoodType get preferredFoodType => FoodType.pancake;

  @override
  bool get shouldEvolve =>
      timesFed >= timesThatMustBeFed &&
      happinessFactor >= happinessThresholdToEvolve;

  @override
  KidUnicornStage evolve() {
    return KidUnicornStage();
  }
}

class KidUnicornStage extends UnicornStage {
  static const double happinessThresholdToEvolve = 1;
  static const int timesThatMustBeFed = 8;

  @override
  FoodType get preferredFoodType => FoodType.lollipop;

  @override
  bool get shouldEvolve =>
      timesFed >= timesThatMustBeFed &&
      happinessFactor >= happinessThresholdToEvolve;

  @override
  TeenagerUnicornStage evolve() {
    return TeenagerUnicornStage();
  }
}

class TeenagerUnicornStage extends UnicornStage {
  static double happinessThresholdToEvolve = 1;
  static int timesThatMustBeFed = 12;

  @override
  FoodType get preferredFoodType => FoodType.candy;

  @override
  bool get shouldEvolve =>
      timesFed >= timesThatMustBeFed &&
      happinessFactor >= happinessThresholdToEvolve;

  @override
  AdultUnicornStage evolve() {
    return AdultUnicornStage();
  }
}

class AdultUnicornStage extends UnicornStage {
  @override
  FoodType get preferredFoodType => FoodType.iceCream;

  @override
  bool get shouldEvolve => false;

  @override
  Never evolve() {
    throw StateError('An adult unicorn should never be asked to evolve');
  }
}
