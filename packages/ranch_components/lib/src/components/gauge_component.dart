import 'dart:math';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flame/effects.dart';

/// {@template gauge_component}
/// A [PositionComponent] that will render a gauge which can represent
/// the progress of something.
/// {@endtemplate}
class GaugeComponent extends PositionComponent {
  /// {macro gauge_component}
  GaugeComponent({
    required Vector2 position,
    required double size,
    required double thickness,
    required Color color,
    double percentage = 0,
  })  : assert(
          percentage >= 0 && percentage <= 1,
          'Percentage has to be between 0 and 1',
        ),
        super(
          position: position,
          size: Vector2.all(size),
          anchor: Anchor.center,
          children: [
            _GaugeIndicator(
              size: size,
              percentage: percentage,
              thickness: thickness,
              color: color,
            ),
          ],
        );

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
    required double size,
    required this.thickness,
    required this.percentage,
    required Color color,
  })  : _radius = size / 2,
        _center = Offset(size / 2, size / 2),
        _color = color,
        super(anchor: Anchor.center, position: Vector2.zero());

  EffectController effectController = CurvedEffectController(
    0.15,
    Curves.easeInOut,
  )..setToEnd();

  late final changeEffect = _GaugeIndicatorChangeEffect(
    percentage,
    effectController,
  );

  final double _radius;
  final Offset _center;
  final double thickness;
  final Color _color;

  double percentage;

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
  double measure() => _to;

  @override
  bool get removeOnFinish => false;
}
