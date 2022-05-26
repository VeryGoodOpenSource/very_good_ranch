import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flutter/material.dart';
import 'package:ranch_components/ranch_components.dart';
import 'package:very_good_ranch/game/entities/unicorn/behaviors/behaviors.dart';
import 'package:very_good_ranch/game/entities/unicorn/unicorn.dart';

class GaugeBehavior extends Behavior<Unicorn> {
  @override
  Future<void>? onLoad() {
    add(
      outerGauge = GaugeComponent(
        position: Vector2.zero(),
        size: 87,
        thickness: 10,
        percentage: 1,
        color: Colors.pink,
      ),
    );

    add(
      innerGauge = GaugeComponent(
        position: Vector2.zero(),
        size: 75,
        thickness: 10,
        percentage: 1,
        color: Colors.lightBlue,
      ),
    );
    return null;
  }

  late final GaugeComponent innerGauge;
  late final GaugeComponent outerGauge;
  late final leavingBehavior = parent.findBehavior<LeavingBehavior>();

  @override
  void update(double dt) {
    super.update(dt);
    innerGauge.percentage = parent.enjoymentFactor;
    outerGauge.percentage = parent.fullnessFactor;
  }

  @override
  void renderTree(Canvas canvas) {
    final isLeaving = leavingBehavior?.isLeaving == true;
    if (isLeaving) {
      return;
    }
    super.renderTree(canvas);
  }
}
