import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';

class ThresholdDragUpdateInfo implements DragUpdateInfo {
  factory ThresholdDragUpdateInfo(DragUpdateInfo info, EventDelta delta) {
    return ThresholdDragUpdateInfo._(delta, info.eventPosition, info.raw);
  }

  ThresholdDragUpdateInfo._(this.delta, this.eventPosition, this.raw);

  @override
  bool handled = false;

  @override
  final EventDelta delta;

  @override
  final EventPosition eventPosition;

  @override
  final DragUpdateDetails raw;
}

abstract class ThresholdDraggableBehavior<Parent extends Entity,
        TGame extends FlameGame> extends DraggableBehavior<Parent>
    with HasGameRef<TGame> {
  double get threshold;

  DragStartInfo? _dragStartInfo;
  Vector2? _currentPos;

  bool didBreakThreshold = false;

  @override
  @nonVirtual
  bool onDragStart(DragStartInfo info) {
    _dragStartInfo = info;
    return false;
  }

  bool onReallyDragStart(DragStartInfo info) {
    return true;
  }

  bool onReallyDragUpdate(DragUpdateInfo info) {
    return true;
  }

  @override
  @mustCallSuper
  bool onDragUpdate(DragUpdateInfo info) {
    if (didBreakThreshold) {
      return onReallyDragUpdate(info);
    }

    final dragStartInfo = _dragStartInfo!;

    _currentPos ??= dragStartInfo.eventPosition.viewport.clone();
    _currentPos?.add(info.delta.viewport);

    final delta =
        _currentPos!.clone().distanceTo(dragStartInfo.eventPosition.viewport);

    didBreakThreshold = delta > threshold;

    if (didBreakThreshold) {
      onReallyDragStart(dragStartInfo);

      final offset = _currentPos!
        ..sub(dragStartInfo.eventPosition.viewport.clone());

      final thresholdInfo = ThresholdDragUpdateInfo(
        info,
        EventDelta(gameRef, offset.toOffset()),
      );

      return onReallyDragUpdate(thresholdInfo);
    }

    return true;
  }

  @override
  @mustCallSuper
  bool onDragEnd(DragEndInfo info) {
    _dragStartInfo = null;
    _currentPos = null;
    didBreakThreshold = false;
    return super.onDragEnd(info);
  }

  @override
  @mustCallSuper
  bool onDragCancel() {
    _dragStartInfo = null;
    _currentPos = null;
    didBreakThreshold = false;
    return super.onDragCancel();
  }
}
