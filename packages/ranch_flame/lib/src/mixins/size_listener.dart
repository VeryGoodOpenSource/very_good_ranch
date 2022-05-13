import 'package:flame/components.dart';
import 'package:flutter/material.dart';

/// A mixin that listens to the size of this component.
mixin SizeListener on PositionComponent {
  @override
  @mustCallSuper
  void onMount() {
    super.onMount();
    size.addListener(onSizeChanged);
  }

  @override
  @mustCallSuper
  void onRemove() {
    size.removeListener(onSizeChanged);
    super.onRemove();
  }

  @override
  @mustCallSuper
  Future<void>? onLoad() {
    onSizeChanged();
    return super.onLoad();
  }

  /// Called when the size of this component changes.
  void onSizeChanged();
}
