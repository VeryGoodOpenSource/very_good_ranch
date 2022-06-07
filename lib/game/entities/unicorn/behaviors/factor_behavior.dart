import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flutter/material.dart';
import 'package:ranch_components/ranch_components.dart';
import 'package:very_good_ranch/game/entities/unicorn/behaviors/behaviors.dart';
import 'package:very_good_ranch/game/entities/unicorn/unicorn.dart';

abstract class FactorBehavior extends Behavior<Unicorn> {
  FactorBehavior(this._gaugeComponent) : super(children: [_gaugeComponent]);

  static double visibilityDuration = 1.5;

  final GaugeComponent _gaugeComponent;

  late final leavingBehavior = parent.findBehavior<LeavingBehavior>();

  final _visibilityTimer = Timer(visibilityDuration, autoStart: false);

  double _percentage = 1;

  double get percentage => _percentage;

  @visibleForTesting
  set percentage(double value) {
    _percentage = value.clamp(0.0, 1.0);
  }

  void increaseBy(double amount) {
    percentage += amount;
    makeGaugeTemporarilyVisible();
  }

  void decreaseBy(double amount) {
    percentage -= amount;
    makeGaugeTemporarilyVisible();
  }

  void reset() {
    percentage = 1;
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
    _visibilityTimer.update(dt);
    _gaugeComponent.percentage = percentage;
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