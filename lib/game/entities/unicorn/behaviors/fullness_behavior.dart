import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:ranch_components/ranch_components.dart';
import 'package:very_good_ranch/game/entities/entities.dart';
import 'package:very_good_ranch/game/entities/unicorn/behaviors/behaviors.dart';

class FullnessBehavior extends GaugeBehavior {
  factory FullnessBehavior() {
    return FullnessBehavior._(
      GaugeComponent(
        position: Vector2.zero(),
        size: 87,
        thickness: 10,
        percentage: 1,
        color: Colors.pink,
      ),
    );
  }

  FullnessBehavior._(super.gauge);

  static double decreaseInterval = 7;

  @override
  double get gaugePercentage => parent.fullnessFactor;

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
    parent.fullnessFactor -= parent.currentStage.fullnessDecreaseFactor;
  }
}

extension on UnicornStage {
  double get fullnessDecreaseFactor {
    switch (this) {
      case UnicornStage.baby:
        return 0.1;
      case UnicornStage.kid:
        return 0.1;
      case UnicornStage.teenager:
        return 0.2;
      case UnicornStage.adult:
        return 0.3;
    }
  }
}
