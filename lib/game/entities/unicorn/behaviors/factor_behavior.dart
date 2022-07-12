import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flutter/material.dart';
import 'package:ranch_components/ranch_components.dart';
import 'package:very_good_ranch/game/entities/unicorn/unicorn.dart';

abstract class FactorBehavior extends Behavior<Unicorn> {
  FactorBehavior({
    required GaugeComponent gaugeComponent,
  })  : _gaugeComponent = gaugeComponent,
        super(children: [gaugeComponent]);

  static double visibilityDuration = 1.5;

  final GaugeComponent _gaugeComponent;

  final _visibilityTimer = Timer(visibilityDuration, autoStart: false);

  @visibleForTesting
  @protected
  double get percentage;

  @visibleForTesting
  void makeGaugeTemporarilyVisible() {
    _visibilityTimer.start();
  }

  bool get _isGaugeVisible => percentage < 0.25 || _visibilityTimer.isRunning();

  @override
  @mustCallSuper
  void update(double dt) {
    super.update(dt);
    final currentPosition = Vector2.copy(_gaugeComponent.position);
    final parentCenter = parent.size / 2;
    if (currentPosition != parentCenter) {
      _gaugeComponent.position = parentCenter;
    }

    _visibilityTimer.update(dt);
    _gaugeComponent.percentage = percentage;
    final isLeaving = parent.isLeaving == true;
    if (isLeaving) {
      removeFromParent();
    }
  }

  @override
  void renderTree(Canvas canvas) {
    if (_isGaugeVisible) {
      super.renderTree(canvas);
    }
  }
}
