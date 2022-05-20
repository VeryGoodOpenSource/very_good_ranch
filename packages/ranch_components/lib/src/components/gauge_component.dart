import 'dart:math';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

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
    indicator?.percentage = value.clamp(0, 1);
    indicator?._buildPath();
  }
}

class _GaugeIndicator extends PositionComponent with HasPaint {
  _GaugeIndicator({
    required double size,
    required this.thickness,
    required this.percentage,
    required Color color,
  })  : _size = size,
        _radius = size / 2,
        _center = Offset(size / 2, size / 2),
        _color = color,
        super(anchor: Anchor.center, position: Vector2.zero());

  final double _size;
  final double _radius;
  final Offset _center;
  final double thickness;
  final Color _color;
  final Paint _blendPaint = Paint()..blendMode = BlendMode.dstOut;

  double percentage;

  late Path _path;

  final _tween = Tween<double>(
    begin: 0,
    end: pi * 2,
  );

  @override
  Future<void> onLoad() async {
    paint = Paint()..color = _color;
    _buildPath();
  }

  void _buildPath() {
    // Because of float rounding errors, we can't check for "1"
    if (percentage >= 0.999) {
      _path = Path()
        ..addOval(
          Rect.fromCenter(
            center: _center,
            width: _size,
            height: _size,
          ),
        );
    } else {
      final radians = _tween.transform(percentage);
      _path = Path()
        ..moveTo(_center.dx, _center.dy)
        ..lineTo(_center.dx + cos(0) * _radius, _center.dy + sin(0) * _radius)
        ..arcToPoint(
          Offset(
            _center.dx + cos(radians) * _radius,
            _center.dy + sin(radians) * _radius,
          ),
          radius: Radius.circular(_radius),
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
      ..drawCircle(_center, _radius - thickness / 2, _blendPaint)
      ..restore();
  }
}
