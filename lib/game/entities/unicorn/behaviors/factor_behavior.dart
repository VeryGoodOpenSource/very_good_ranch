import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flutter/material.dart';
import 'package:ranch_components/ranch_components.dart';
import 'package:very_good_ranch/game/entities/unicorn/behaviors/behaviors.dart';
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
  set percentage(double value);

  @visibleForTesting
  @protected
  double get percentage;

  void increaseBy(double amount) {
    percentage += amount;
    makeGaugeTemporarilyVisible();
  }

  void decreaseBy(double amount) {
    percentage -= amount;
    makeGaugeTemporarilyVisible();
  }

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
    if (parent.hasBehavior<LeavingBehavior>()) {
      final leavingBehavior = parent.findBehavior<LeavingBehavior>();
      if (leavingBehavior.isLeaving == true) {
        removeFromParent();
      }
    }
  }

  @override
  void renderTree(Canvas canvas) {
    if (_isGaugeVisible) {
      super.renderTree(canvas);
    }
  }
}
