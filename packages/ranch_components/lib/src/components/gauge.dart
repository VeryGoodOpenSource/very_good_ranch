import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/rendering.dart';

/// Type signature for callbacks that returns a [Color] given a [percentage]
/// value. Defaults to [defaultGaugeForegroundColorGetter].
typedef GaugeForegroundColorGetter = Color Function(double percentage);

/// Default [GaugeForegroundColorGetter] for
/// [GaugeComponent.foregroundColorGetter].
Color defaultGaugeForegroundColorGetter(double percentage) {
  if (percentage > 0.66) return const Color(0xFF46B2A0);
  if (percentage > 0.33) return const Color(0xFFFFD645);
  return const Color(0xFFFF5045);
}

/// Type signature for callbacks that returns a [Vector2] position for a
/// [GaugeComponent] at a given moment.
/// Defaults to [defaultGaugePositionGetter]
typedef GaugePositionGetter = Vector2 Function(GaugeComponent component);

/// Default [GaugePositionGetter] for [GaugeComponent.positionGetter].
Vector2 defaultGaugePositionGetter(GaugeComponent thisGauge) {
  return thisGauge.parent.parentToLocal(
    thisGauge.parent.positionOfAnchor(Anchor.bottomCenter),
  );
}

/// Type signature for callbacks that defines if a [GaugeComponent]
/// should be visible or not.
typedef GaugeVisibilityPredicate = ValueGetter<bool>;

/// Default [GaugeVisibilityPredicate] for [GaugeComponent.visibilityPredicate].
bool defaultVisibilityPredicate() => true;

/// {@template gauge_component}
/// A component that that shows a set of gauges give some [percentages].
///
/// For each percentage, it will show a gauge.
/// {@endtemplate}
class GaugeComponent extends PositionComponent
    with HasPaint<String>, ParentIsA<PositionComponent> {
  /// {@macro gauge_component}
  GaugeComponent({
    required this.percentages,
    GaugeForegroundColorGetter? foregroundColorGetter,
    Color backgroundColor = const Color(0xFF107161),
    Color inactiveForegroundColor = const Color(0x33FFFFFF),
    this.marginExtent = 1,
    this.gaugeHeight = 3,
    this.overallWidth = 56,
    this.borderRadius = 0.5,
    Vector2? offset,
    super.position,
    super.scale,
    super.angle,
    super.anchor = Anchor.topCenter,
    super.children,
    super.priority = -10000,
    GaugeVisibilityPredicate? visibilityPredicate,
    GaugePositionGetter? positionGetter,
  })  : foregroundColorGetter =
            foregroundColorGetter ?? defaultGaugeForegroundColorGetter,
        offset = offset ?? Vector2.zero(),
        visibilityPredicate = visibilityPredicate ?? defaultVisibilityPredicate,
        positionGetter = positionGetter ?? defaultGaugePositionGetter,
        assert(
          percentages.isNotEmpty,
          'Pass at least one percentage measurement',
        ) {
    setPaint('backgroundColor', Paint()..color = backgroundColor);
    setPaint(
      'inactiveForegroundColor',
      Paint()..color = inactiveForegroundColor,
    );
    recomputeSize();
  }

  /// An offset that the compoennt will take from the position returned
  /// by [positionGetter]
  Vector2 offset;

  /// A callback that is called on every update to figure out the positions of
  /// the gauge.
  ///
  /// Defaults to [defaultGaugePositionGetter].
  final GaugePositionGetter positionGetter;

  /// A callback that is called on every render that defines if the component
  /// should be visible or not.
  final GaugeVisibilityPredicate visibilityPredicate;

  /// A callback that defines the color of each gauge given
  /// its percentage value.
  final GaugeForegroundColorGetter foregroundColorGetter;

  /// A list of [ValueGetter] for the percentages of each gauge,
  /// specify at lest one.
  final List<ValueGetter<double>> percentages;

  /// The amount of pixels between gauges.
  double marginExtent;

  /// The height of each gauge.
  double gaugeHeight;

  /// The max overall width of the gauge area.
  double overallWidth;

  /// The border radius for gauges and the bounding box.
  double borderRadius;

  /// Compute the size of the component. To be called manually if any relevant
  /// size parameter is changed.
  void recomputeSize() {
    final x = max(overallWidth, marginExtent * 2);
    final gaugeAmount = percentages.length;
    final marginsInBetween = gaugeAmount - 1;
    final y = marginExtent * (2 + marginsInBetween) + gaugeAmount * gaugeHeight;
    size = NotifyingVector2(x, y);
  }

  /// The current background color.
  Color get backgroundColor => getPaint('backgroundColor').color;

  set backgroundColor(Color value) {
    setPaint('backgroundColor', Paint()..color = value);
  }

  /// The current background of the not filled parts of each gauge.
  Color get inactiveForegroundColor =>
      getPaint('inactiveForegroundColor').color;

  set inactiveForegroundColor(Color value) {
    setPaint('inactiveForegroundColor', Paint()..color = value);
  }

  @override
  void update(double dt) {
    super.update(dt);
    position = positionGetter(this) + offset;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    final shouldBeVisible = visibilityPredicate();
    if (!shouldBeVisible) {
      return;
    }
    _renderBackground(canvas);
    for (final i in Iterable<int>.generate(percentages.length)) {
      _renderGauge(canvas, i);
    }
  }

  void _renderBackground(Canvas canvas) {
    final backgroundRect = Vector2.zero().toOffset() & size.toSize();
    final radius = Radius.circular(borderRadius);
    canvas.drawRRect(
      RRect.fromRectAndRadius(backgroundRect, radius),
      getPaint('backgroundColor'),
    );
  }

  void _renderGauge(Canvas canvas, int index) {
    final xStart = marginExtent;
    final yStart = marginExtent * (index + 1) + index * gaugeHeight;

    final xSize = size.x - marginExtent * 2;
    final ySize = gaugeHeight;

    final backgroundGaugeRect = Offset(xStart, yStart) & Size(xSize, ySize);
    final radius = Radius.circular(borderRadius);
    canvas.drawRRect(
      RRect.fromRectAndRadius(backgroundGaugeRect, radius),
      getPaint('inactiveForegroundColor'),
    );

    // foreground
    final percentage = percentages[index]();
    final foregroundColor = foregroundColorGetter(percentage);
    final paint = Paint()..color = foregroundColor;
    final percentageXSize = xSize * percentage;
    final gaugeRect = Offset(xStart, yStart) & Size(percentageXSize, ySize);
    canvas.drawRRect(RRect.fromRectAndRadius(gaugeRect, radius), paint);
  }
}
