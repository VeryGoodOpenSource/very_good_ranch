import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';

/// {@template gauge_component}
/// A [PositionComponent] that will render a gauge which can represent
/// the progress of something.
/// {@endtemplate}
class GaugeComponent extends PositionComponent {
  /// {macro gauge_component}
  GaugeComponent({
    required Vector2 position,
    required double thickness,
    required Color color,
    double diameter = 0,
    double percentage = 0,
  })  : assert(
          percentage >= 0 && percentage <= 1,
          'Percentage has to be between 0 and 1',
        ),
        super(
          position: position,
          size: Vector2.all(diameter),
          anchor: Anchor.center,
          children: [
            _GaugeIndicator(
              radius: diameter / 2,
              percentage: percentage,
              thickness: thickness,
              color: color,
            ),
          ],
        );

  /// The animation duration in seconds for intrinsic animations.
  static const double animationDuration = 0.15;

  /// The diameter of the gauge in pixels
  double get diameter => size.x;

  set diameter(double value) {
    if (diameter == value) {
      return;
    }

    final indicator = firstChild<_GaugeIndicator>();

    if (indicator == null) {
      return;
    }

    size = Vector2.all(value);
    indicator.radius = value / 2;
  }

  /// returns the current percent of the gauge
  double get percentage => firstChild<_GaugeIndicator>()?.percentage ?? 0;

  /// sets a new value for the gauge
  set percentage(double value) {
    final indicator = firstChild<_GaugeIndicator>();

    if (indicator == null) {
      return;
    }
    indicator.changeEffect
      ..go(to: value)
      ..reset();
  }
}

class _GaugeIndicator extends PositionComponent with HasPaint {
  _GaugeIndicator({
    required double radius,
    required this.thickness,
    required this.percentage,
    required Color color,
  })  : _radius = radius,
        _center = Offset(radius, radius),
        _color = color,
        super(anchor: Anchor.center, position: Vector2.zero());

  final effectController = CurvedEffectController(
    GaugeComponent.animationDuration,
    Curves.easeInOut,
  )..setToEnd();

  late final changeEffect = _GaugeIndicatorChangeEffect(
    percentage,
    effectController,
  );

  final double thickness;
  final Color _color;

  Offset _center;
  double _radius;
  double percentage;

  double get radius => _radius;

  set radius(double value) {
    _radius = value;
    _center = Offset(radius, radius);
    _buildPath();
  }

  late Path _path;

  final _tween = Tween<double>(
    begin: 0,
    end: pi * 2,
  );

  @override
  Future<void> onLoad() async {
    paint = Paint()..color = _color;
    await add(changeEffect);
    _buildPath();
  }

  void _buildPath() {
    final externalPath = _buildPathSection(_radius);
    final internalPath = _buildPathSection(_radius - thickness / 2);

    _path = Path()
      ..fillType = PathFillType.evenOdd
      ..addPath(externalPath, Offset.zero)
      ..addPath(internalPath, Offset.zero);
  }

  Path _buildPathSection(double radius) {
    // Because of float rounding errors, we can't check for "1"
    if (percentage >= 0.999) {
      return Path()
        ..addOval(
          Rect.fromCircle(
            center: _center,
            radius: radius,
          ),
        );
    } else {
      final radians = _tween.transform(percentage);
      return Path()
        ..moveTo(_center.dx, _center.dy)
        ..lineTo(_center.dx + cos(0) * radius, _center.dy + sin(0) * radius)
        ..arcToPoint(
          Offset(
            _center.dx + cos(radians) * radius,
            _center.dy + sin(radians) * radius,
          ),
          radius: Radius.circular(radius),
          largeArc: percentage > 0.5,
        )
        ..lineTo(_center.dx, _center.dy)
        ..close();
    }
  }

  @override
  void render(Canvas canvas) {
    canvas
      ..save()
      ..drawPath(_path, paint)
      ..restore();
  }
}

class _GaugeIndicatorChangeEffect extends Effect
    with EffectTarget<_GaugeIndicator> {
  _GaugeIndicatorChangeEffect(this._to, super.controller)
      : assert(
          _to >= 0.0 && _to <= 1.0,
          'Percentage should be set between 0.0 and 1.0',
        );

  @override
  void onMount() {
    super.onMount();
    _from = target.percentage;
  }

  double _to;
  late double _from;

  void go({
    required double to,
  }) {
    assert(isMounted, 'Tried to change an effect that is not mounted');
    _to = to;
    _from = target.percentage;
  }

  @override
  void apply(double progress) {
    final dPercentage = _to - _from;
    final percentage = (_from + dPercentage * progress).clamp(0.0, 1.0);

    target
      ..percentage = percentage
      .._buildPath();
  }

  @override
  bool get removeOnFinish => false;
}
