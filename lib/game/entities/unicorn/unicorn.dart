import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flutter/material.dart';
import 'package:ranch_components/ranch_components.dart';
import 'package:very_good_ranch/game/entities/unicorn/behaviors/behaviors.dart';
import 'package:very_good_ranch/game/entities/unicorn/stages.dart';

class Unicorn extends Entity {
  Unicorn({
    required super.position,
  })  : _unicornComponent = UnicornComponent(size: Vector2.all(32)),
        super(
          size: Vector2.all(32),
          behaviors: [
            PropagatingCollisionBehavior(RectangleHitbox()),
            MovementBehavior(),
            FoodCollisionBehavior(),
            EvolutionBehavior(),
          ],
        );

  /// Creates a Unicorn without any behaviors.
  ///
  /// This can be used for testing each behavior of a unicorn.
  @visibleForTesting
  Unicorn.test({
    required super.position,
  })  : _unicornComponent = UnicornComponent(size: Vector2.all(32)),
        super(
          size: Vector2.all(32),
          behaviors: [
            PropagatingCollisionBehavior(RectangleHitbox()),
          ],
        );

  UnicornStage get currentStage =>
      findBehavior<EvolutionBehavior>()!.currentStage;

  final UnicornComponent _unicornComponent;

  UnicornState? get state => _unicornComponent.current;

  set state(UnicornState? state) => _unicornComponent.current = state;

  @override
  Future<void> onLoad() async {
    await add(_unicornComponent);
  }
}
