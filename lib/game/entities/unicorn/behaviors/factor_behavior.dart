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

  late final leavingBehavior = parent.findBehavior<LeavingBehavior>();

  final _visibilityTimer = Timer(visibilityDuration, autoStart: false);

  @visibleForTesting
  @protected
  void setPercentage(double value);

  @visibleForTesting
  @protected
  double getPercentage();

  double get _percentage => getPercentage();

  set _percentage(double value) {
    setPercentage(value.clamp(0.0, 1.0));
  }

  void increaseBy(double amount) {
    _percentage += amount;
    makeGaugeTemporarilyVisible();
  }

  void decreaseBy(double amount) {
    _percentage -= amount;
    makeGaugeTemporarilyVisible();
  }

  void reset() {
    _percentage = 1;
    makeGaugeTemporarilyVisible();
  }

  @visibleForTesting
  void makeGaugeTemporarilyVisible() {
    _visibilityTimer.start();
  }

  bool get _isGaugeVisible =>
      _percentage < 0.25 || _visibilityTimer.isRunning();

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
    _gaugeComponent.percentage = _percentage;
    final isLeaving = leavingBehavior?.isLeaving == true;
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
