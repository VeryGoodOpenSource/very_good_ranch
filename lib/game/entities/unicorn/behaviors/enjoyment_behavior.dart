import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:ranch_components/ranch_components.dart';
import 'package:very_good_ranch/game/entities/unicorn/behaviors/behaviors.dart';
import 'package:very_good_ranch/game/entities/unicorn/unicorn.dart';

class EnjoymentBehavior extends FactorBehavior {
  factory EnjoymentBehavior() {
    return EnjoymentBehavior._(
      gaugeComponent: GaugeComponent(
        position: Vector2.zero(),
        diameter: 0,
        thickness: 20,
        percentage: 1,
        color: Colors.lightBlue,
      ),
    );
  }

  EnjoymentBehavior._({
    required super.gaugeComponent,
  });

  static double decreaseInterval = 8;

  @override
  final double innerSpacing = 34;

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
    parent.enjoyment.decreaseBy(parent.evolutionStage.enjoymentDecreaseFactor);
  }

  @override
  double get percentage => parent.enjoyment.value;
}

extension on UnicornEvolutionStage {
  /// Percentage that of enjoyment lost every
  /// [EnjoymentBehavior.decreaseInterval].
  double get enjoymentDecreaseFactor {
    switch (this) {
      case UnicornEvolutionStage.baby:
        return 0.3;
      case UnicornEvolutionStage.child:
        return 0.2;
      case UnicornEvolutionStage.teen:
        return 0.1;
      case UnicornEvolutionStage.adult:
        return 0.1;
    }
  }
}
