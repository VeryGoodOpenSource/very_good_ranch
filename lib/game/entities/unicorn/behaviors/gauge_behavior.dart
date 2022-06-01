import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flutter/material.dart';
import 'package:ranch_components/ranch_components.dart';
import 'package:very_good_ranch/game/entities/unicorn/behaviors/behaviors.dart';
import 'package:very_good_ranch/game/entities/unicorn/unicorn.dart';

abstract class GaugeBehavior extends Behavior<Unicorn> {
  GaugeBehavior(this.gauge) : super(children: [gauge]);

  final GaugeComponent gauge;

  late final leavingBehavior = parent.findBehavior<LeavingBehavior>();

  double get gaugePercentage;

  @override
  @mustCallSuper
  void update(double dt) {
    super.update(dt);
    gauge.percentage = gaugePercentage;
    final isLeaving = leavingBehavior?.isLeaving == true;
    if (isLeaving) {
      removeFromParent();
    }
  }
}
