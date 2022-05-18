import 'dart:math';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

/// {@template gauge_component}
/// A [PositionComponent] that will render a gauge which can represent
/// a progress of something.
/// {@endtemplate}
class GaugeComponent extends PositionComponent {
  /// {macro gauge_component}
  GaugeComponent({
    required Vector2 position,
    required double size,
    double percent = 0,
  }) : super(
          position: position,
          size: Vector2.all(size),
          anchor: Anchor.center,
          children: [
            CircleComponent(
              radius: size / 2,
              paint: Paint()..color = Colors.brown,
            ),
            _GaugeIndicator(
              size: size,
              percent: percent,
            ),
          ],
        );

  /// returns the current percent of the gauge
  double get percent => firstChild<_GaugeIndicator>()?.percent ?? 0;

  /// sets a new value for the gauge
  set percent(double value) {
    final indicator = firstChild<_GaugeIndicator>();
    indicator?.percent = value;
    indicator?._buildPath();
  }
}

class _GaugeIndicator extends PositionComponent with HasPaint {
  _GaugeIndicator({
    required double size,
    required this.percent,
  })  : _size = size,
        super(anchor: Anchor.center, position: Vector2.zero());

  final double _size;
  double percent;

  late Path _path;

  final _tween = Tween<double>(
    begin: 0,
    end: 6.28319,
  );

  @override
  Future<void> onLoad() async {
    paint = Paint()..color = Colors.pink;
    _buildPath();
  }

  void _buildPath() {
    final radius = _size / 2;
    if (percent == 1) {
      _path = Path()
        ..addOval(
          Rect.fromCenter(
            center: Offset(radius, radius),
            width: _size,
            height: _size,
          ),
        );
    } else {
      final radians = _tween.transform(percent);
      _path = Path()
        ..moveTo(radius, radius)
        ..lineTo(radius + cos(0) * radius, radius + sin(0) * radius)
        ..arcToPoint(
          Offset(
            radius + cos(radians) * radius,
            radius + sin(radians) * radius,
          ),
          radius: Radius.circular(radius),
          largeArc: percent > 0.5,
        )
        ..lineTo(radius, radius)
        ..close();
    }
  }

  @override
  void render(Canvas canvas) {
    canvas.drawPath(_path, paint);
  }
}
