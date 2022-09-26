import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flutter/widgets.dart';
import 'package:ranch_components/ranch_components.dart';
import 'package:very_good_ranch/config.dart';
import 'package:very_good_ranch/game/entities/entities.dart';

class PettingBehavior extends TappableBehavior<Unicorn> {
  late final TimerComponent _throttlingTimer;

  @override
  Future<void> onLoad() async {
    await add(
      _throttlingTimer = TimerComponent(
        period: Config.petThrottleDuration,
        autoStart: false,
      ),
    );
  }

  @override
  bool onTapDown(TapDownInfo info) {
    if (info.handled || _throttlingTimer.timer.isRunning()) {
      return true;
    }

    _throttlingTimer.timer.start();

    parent
      ..enjoyment.increaseBy(parent.evolutionStage.petEnjoymentIncrease)
      ..setUnicornState(UnicornState.petted);

    return false;
  }
}

@visibleForTesting
extension PetBehaviorIncreasePerStage on UnicornEvolutionStage {
  double get petEnjoymentIncrease {
    switch (this) {
      case UnicornEvolutionStage.baby:
        return Config.petEnjoymentIncrease.baby;
      case UnicornEvolutionStage.child:
        return Config.petEnjoymentIncrease.child;
      case UnicornEvolutionStage.teen:
        return Config.petEnjoymentIncrease.teen;
      case UnicornEvolutionStage.adult:
        return Config.petEnjoymentIncrease.adult;
    }
  }
}
