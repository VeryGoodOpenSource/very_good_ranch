import 'dart:async' as async;
import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flutter/gestures.dart';

abstract class DoubleTapBehavior<Parent extends Entity> extends Behavior<Parent>
    with Tappable {
  Vector2? _firstTap;
  async.Timer? _preventFastTapTimer;
  async.Timer? _timeoutTimer;

  @override
  bool onTapDown(TapDownInfo info) {
    if (_preventFastTapTimer != null) {
      return false;
    }

    if (_firstTap == null) {
      //create a timer to prevent fast taps
      _preventFastTapTimer = async.Timer(kDoubleTapMinTime, () {
        _firstTap = info.eventPosition.game;
        _preventFastTapTimer = null;
      });
      // After timeout, act as if first tap never happened
      _timeoutTimer = async.Timer(kDoubleTapTimeout, () {
        _firstTap = null;
        _timeoutTimer = null;
      });
      return true;
    } else {
      _timeoutTimer?.cancel();
      _timeoutTimer = null;
      _firstTap = null;
      return onDoubleTapDown(info);
    }
  }

  bool onDoubleTapDown(TapDownInfo info) {
    return true;
  }

  @override
  bool containsPoint(Vector2 point) {
    return parent.containsPoint(point);
  }
}
