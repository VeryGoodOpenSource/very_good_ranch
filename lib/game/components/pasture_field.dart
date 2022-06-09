import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/painting.dart';

/// Defines the area in which unicorns will appear, roam about and eat.
class PastureField extends PositionComponent with HasGameRef {
  PastureField({super.children});

  static const padding = EdgeInsets.only(
    top: 150,
    left: 30,
    right: 30,
    bottom: 30,
  );

  @override
  Future<void> onLoad() async {
    final gameSize = gameRef.camera.viewport.effectiveSize;
    final paddingDeflection = Vector2(padding.horizontal, padding.vertical);
    final paddingPosition = Vector2(padding.left, padding.top);
    size = gameSize - paddingDeflection;
    position = paddingPosition;
  }
}
