import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:ranch_components/ranch_components.dart';
import 'package:very_good_ranch/game/entities/unicorn/behaviors/behaviors.dart';

class Unicorn extends PositionComponent {
  Unicorn({
    required Vector2 position,
  })  : _unicornComponent = UnicornComponent(size: Vector2.all(32)),
        super(
          position: position,
          size: Vector2.all(32),
          children: [CollisionBehavior(), MovementBehavior()],
        );

  /// Creates a Unicorn without any children.
  ///
  /// This can be used for testing each behavior of a unicorn.
  @visibleForTesting
  Unicorn.test({
    required Vector2 position,
  })  : _unicornComponent = UnicornComponent(size: Vector2.all(32)),
        super(
          position: position,
          size: Vector2.all(32),
        );

  final UnicornComponent _unicornComponent;

  UnicornState? get state => _unicornComponent.current;
  set state(UnicornState? state) => _unicornComponent.current = state;

  @override
  Future<void> onLoad() async {
    await add(_unicornComponent);
  }
}
