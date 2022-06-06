import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flutter/foundation.dart';
import 'package:ranch_components/ranch_components.dart';
import 'package:very_good_ranch/game/entities/entities.dart';
import 'package:very_good_ranch/game/entities/unicorn/behaviors/behaviors.dart';

class EvolutionBehavior extends Behavior<Unicorn> {
  factory EvolutionBehavior() {
    return EvolutionBehavior.withInitialStage(UnicornStage.baby);
  }

  @visibleForTesting
  EvolutionBehavior.withInitialStage(this._currentStage);

  static const double happinessThresholdToEvolve = 0.9;
  static const int timesThatMustBeFed = 4;

  UnicornStage get currentStage => _currentStage;
  UnicornStage _currentStage;

  @override
  Future<void> onLoad() async {
    final unicornComponent = _currentStage.componentForStage;
    await parent.add(parent.unicornComponent = unicornComponent);
  }

  @override
  void update(double dt) {
    if (!shouldEvolve) {
      return;
    }
    final nextStage = getNextStage();
    _currentStage = nextStage;

    parent.findBehavior<FullnessBehavior>()?.reset();
    parent.findBehavior<EnjoymentBehavior>()?.reset();
  }

  bool get shouldEvolve {
    if (currentStage == UnicornStage.adult) {
      return false;
    }
    return parent.timesFed >= timesThatMustBeFed &&
        parent.happinessFactor >= happinessThresholdToEvolve;
  }

  UnicornStage getNextStage() {
    final currentStage = this.currentStage;
    if (currentStage == UnicornStage.baby) {
      return UnicornStage.child;
    }
    if (currentStage == UnicornStage.child) {
      return UnicornStage.teen;
    }
    if (currentStage == UnicornStage.teen) {
      return UnicornStage.adult;
    }
    return currentStage;
  }
}

extension on UnicornStage {
  UnicornComponent get componentForStage {
    switch (this) {
      case UnicornStage.baby:
        return BabyUnicornComponent();
      case UnicornStage.child:
        return ChildUnicornComponent();
      case UnicornStage.teen:
        return TeenUnicornComponent();
      case UnicornStage.adult:
        return AdultUnicornComponent();
    }
  }
}
