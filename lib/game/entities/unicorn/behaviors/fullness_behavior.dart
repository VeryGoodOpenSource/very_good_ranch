import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:ranch_components/ranch_components.dart';
import 'package:very_good_ranch/game/entities/entities.dart';
import 'package:very_good_ranch/game/entities/unicorn/behaviors/behaviors.dart';

class FullnessBehavior extends FactorBehavior {
  factory FullnessBehavior() {
    return FullnessBehavior._(
      gaugeComponent: GaugeComponent(
        position: Vector2.zero(),
        size: UnicornComponent.dimensions.x + 34,
        thickness: 20,
        percentage: 1,
        color: Colors.pink,
      ),
    );
  }

  FullnessBehavior._({
    required super.gaugeComponent,
  });

  static double decreaseInterval = 7;

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

  @override
  double get percentage => parent.fullnessFactor;

  @override
  set percentage(double value) => parent.fullnessFactor = value.clamp(0.0, 1.0);
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
