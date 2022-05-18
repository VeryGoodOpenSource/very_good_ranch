import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flutter/gestures.dart';

abstract class DoubleTapBehavior<Parent extends Entity> extends Behavior<Parent>
    with Tappable {
  Vector2? _previousTap;
  int _timeSinceLastTap = 0;

  @override
  bool onTapDown(TapDownInfo info) {
    if (_previousTap == null) {
      _timeSinceLastTap = DateTime.now().microsecondsSinceEpoch;
      _previousTap = info.eventPosition.game;
    } else {
      final difference =
          DateTime.now().microsecondsSinceEpoch - _timeSinceLastTap;
      if (difference >= kDoubleTapMinTime.inMicroseconds &&
          difference <= kDoubleTapTimeout.inMicroseconds) {
        _previousTap = null;
        return onDoubleTapDown(info);
      }
      _previousTap = null;
    }
    return false;
  }

  bool onDoubleTapDown(TapDownInfo info) {
    return true;
  }

  @override
  bool containsPoint(Vector2 point) {
    return parent.containsPoint(point);
  }
}
