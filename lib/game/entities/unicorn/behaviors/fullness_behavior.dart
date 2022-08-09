import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:ranch_components/ranch_components.dart';
import 'package:very_good_ranch/game/entities/entities.dart';
import 'package:very_good_ranch/game/entities/unicorn/behaviors/behaviors.dart';

class FullnessBehavior extends FactorDecreasingBehavior {
  factory FullnessBehavior() {
    return FullnessBehavior._(
      GaugeComponent(
        position: Vector2.zero(),
        thickness: 20,
        percentage: 1,
        color: Colors.pink,
      ),
      innerSpacing,
    );
  }

  FullnessBehavior._(
    super.gaugeComponent,
    super.innerSpacing,
  );

  static const double decreaseInterval = 7;

  /// The extra spacing the gauge should take from the unicorn size
  static const double innerSpacing = 54;

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
    parent.fullness.decreaseBy(parent.evolutionStage.fullnessDecreaseFactor);
  }

  @override
  double get percentage => parent.fullness.value;
}

extension on UnicornEvolutionStage {
  double get fullnessDecreaseFactor {
    switch (this) {
      case UnicornEvolutionStage.baby:
        return 0.1;
      case UnicornEvolutionStage.child:
        return 0.1;
      case UnicornEvolutionStage.teen:
        return 0.2;
      case UnicornEvolutionStage.adult:
        return 0.3;
    }
  }
}
