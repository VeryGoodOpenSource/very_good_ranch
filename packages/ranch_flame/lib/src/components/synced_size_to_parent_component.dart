import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:ranch_flame/src/mixins/has_parent.dart';

/// {@template synced_size_to_parent_component}
/// Component that syncs the size of the component with the size of the parent.
/// {@endtemplate}
abstract class SyncedSizeToParentComponent<T extends PositionComponent>
    extends PositionComponent with HasParent<T> {
  /// {@macro synced_size_to_parent_component}
  SyncedSizeToParentComponent({
    Vector2? position,
    Vector2? size,
    Vector2? scale,
    double? angle,
    Anchor? anchor,
    Iterable<Component>? children,
    int? priority,
  }) : super(
          position: position,
          size: size,
          scale: scale,
          angle: angle,
          anchor: anchor,
          children: children,
          priority: priority,
        );

  @override
  @mustCallSuper
  void onMount() {
    super.onMount();
    parent.size.addListener(_onParentResize);
  }

  @override
  @mustCallSuper
  void onRemove() {
    parent.size.removeListener(_onParentResize);
    super.onRemove();
  }

  void _onParentResize() => size = parent.size;
}
