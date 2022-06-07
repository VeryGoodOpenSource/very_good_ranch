import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:ranch_components/ranch_components.dart';
import 'package:very_good_ranch/game/entities/unicorn/behaviors/behaviors.dart';
import 'package:very_good_ranch/game/entities/unicorn/unicorn.dart';

class EnjoymentBehavior extends FactorBehavior {
  factory EnjoymentBehavior() {
    return EnjoymentBehavior._(
      GaugeComponent(
        position: Vector2.zero(),
        size: 120,
        thickness: 20,
        percentage: 1,
        color: Colors.lightBlue,
      ),
    );
  }

  EnjoymentBehavior._(super.gauge);

  static double decreaseInterval = 8;

  @override
  Future<void> onLoad() async {
    await add(
      TimerComponent(
        period: decreaseInterval,
        repeat: true,
        onTick: _decreaseEnjoyment,
      ),
    );
  }

  void _decreaseEnjoyment() {
    decreaseBy(parent.currentStage.enjoymentDecreaseFactor);
  }
}

extension on UnicornStage {
  /// Percentage that of enjoyment lost every
  /// [EnjoymentBehavior.decreaseInterval].
  double get enjoymentDecreaseFactor {
    switch (this) {
      case UnicornStage.baby:
        return 0.3;
      case UnicornStage.child:
        return 0.2;
      case UnicornStage.teen:
        return 0.1;
      case UnicornStage.adult:
        return 0.1;
    }
  }
}
