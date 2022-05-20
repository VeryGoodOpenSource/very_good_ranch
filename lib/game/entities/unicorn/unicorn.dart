import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flutter/material.dart';
import 'package:ranch_components/ranch_components.dart';
import 'package:very_good_ranch/game/entities/unicorn/behaviors/behaviors.dart';

enum UnicornStage {
  baby,
  kid,
  teenager,
  adult,
}

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
            FullnessDecreaseBehavior(),
            EnjoymentDecreaseBehavior(),
          ],
        );

  /// Creates a Unicorn without only the passed [behaviors] and a
  /// [PropagatingCollisionBehavior].
  ///
  /// This can be used for testing each behavior of a unicorn.
  @visibleForTesting
  Unicorn.customBehaviors({
    required super.position,
    Iterable<Behavior>? behaviors,
  })  : _unicornComponent = UnicornComponent(size: Vector2.all(32)),
        super(
          size: Vector2.all(32),
          behaviors: [
            PropagatingCollisionBehavior(RectangleHitbox()),
            ...?behaviors,
          ],
        );

  /// A state that describes how many times the unicorn ate food.
  int timesFed = 0;

  /// A state that describes how well fed the unicorn is.
  double get fullnessFactor => _fullnessFactor;

  set fullnessFactor(double value) {
    _fullnessFactor = value.clamp(0.0, 1.0);
  }

  double _fullnessFactor = 1;

  /// A state that describes how well treated the unicorn is.
  double get enjoymentFactor => _enjoymentFactor;

  set enjoymentFactor(double value) {
    _enjoymentFactor = value.clamp(0.0, 1.0);
  }

  double _enjoymentFactor = 1;

  double get happinessFactor => fullnessFactor * enjoymentFactor;

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
