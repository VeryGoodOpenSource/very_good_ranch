import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/rendering.dart';

///
typedef GaugeForegroundColorGetter = Color Function(double percentage);

typedef GaugePositionGetter = Vector2 Function(GaugeComponent component);

///
Color defaultGaugeForegroundColorGetter(double percentage) {
  if (percentage > 0.66) return const Color(0xFF46B2A0);
  if (percentage > 0.33) return const Color(0xFFFFD645);
  return const Color(0xFFFF5045);
}

Vector2 defaultGaugePositionGetter(GaugeComponent thisGauge) {
  return thisGauge.parent.parentToLocal(
    thisGauge.parent.positionOfAnchor(thisGauge.anchorOnParent),
  );
}

bool defaultVisibilityPredicate() => true;

///
class GaugeComponent extends PositionComponent
    with HasPaint<String>, ParentIsA<PositionComponent> {
  ///
  GaugeComponent({
    required this.percentages,
    GaugeForegroundColorGetter? foregroundColorGetter,
    Color backgroundColor = const Color(0xFF107161),
    Color inactiveForegroundColor = const Color(0x33FFFFFF),
    this.marginSize = 1,
    this.gaugeHeight = 3,
    this.overallWidth = 56,
    this.borderRadius = 0.5,
    this.anchorOnParent = Anchor.bottomCenter,
    Vector2? offset,
    super.position,
    super.scale,
    super.angle,
    super.anchor = Anchor.topCenter,
    super.children,
    super.priority = -10000,
    ValueGetter<bool>? visibilityPredicate,
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

  Anchor anchorOnParent;
  Vector2 offset;

  final GaugePositionGetter positionGetter;
  final ValueGetter<bool> visibilityPredicate;
  final List<ValueGetter<double>> percentages;
  final GaugeForegroundColorGetter foregroundColorGetter;

  double marginSize;
  double gaugeHeight;
  double overallWidth;
  double borderRadius;

  void recomputeSize() {
    final x = max(overallWidth, marginSize * 2);
    final gaugeAmount = percentages.length;
    final marginsInBetween = gaugeAmount - 1;
    final y = marginSize * (2 + marginsInBetween) + gaugeAmount * gaugeHeight;
    size = NotifyingVector2(x, y);
  }

  Color get backgroundColor => getPaint('backgroundColor').color;

  set backgroundColor(Color value) {
    setPaint('backgroundColor', Paint()..color = value);
  }

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
    final xStart = marginSize;
    final yStart = marginSize * (index + 1) + index * gaugeHeight;

    final xSize = size.x - marginSize * 2;
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
