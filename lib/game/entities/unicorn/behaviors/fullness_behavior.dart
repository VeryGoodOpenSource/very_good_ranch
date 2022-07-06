import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:ranch_components/ranch_components.dart';
import 'package:very_good_ranch/game/entities/entities.dart';
import 'package:very_good_ranch/game/entities/unicorn/behaviors/behaviors.dart';

class FullnessBehavior extends FactorBehavior {
  factory FullnessBehavior() {
    return FullnessBehavior._(
      GaugeComponent(
        position: Vector2.zero(),
        diameter: 0,
        thickness: 20,
        percentage: 1,
        color: Colors.pink,
      ),
    );
  }

  FullnessBehavior._(super.gaugeComponent);

  static double decreaseInterval = 7;

  @override
  final double innerSpacing = 54;

  @override
  Future<void> onLoad() async {
    await add(
      TimerComponent(
        period: decreaseInterval,
        repeat: true,
        onTick: _decreaseFullness,
      ),
    );
  }

  void _decreaseFullness() {
    decreaseBy(parent.currentStage.fullnessDecreaseFactor);
  }
}

extension on UnicornStage {
  double get fullnessDecreaseFactor {
    switch (this) {
      case UnicornStage.baby:
        return 0.1;
      case UnicornStage.child:
        return 0.1;
      case UnicornStage.teen:
        return 0.2;
      case UnicornStage.adult:
        return 0.3;
    }
  }
}
