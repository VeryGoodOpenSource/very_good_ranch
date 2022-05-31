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
  })  : unicornComponent = UnicornComponent(size: Vector2.all(32)),
        super(
          size: Vector2.all(32),
          behaviors: [
            PropagatingCollisionBehavior(RectangleHitbox()),
            MovementBehavior(),
            FoodCollisionBehavior(),
            EvolutionBehavior(),
            FullnessBehavior(),
            EnjoymentBehavior(),
            LeavingBehavior(),
            PetBehavior(),
          ],
        );

  /// Creates a Unicorn without only the passed behaviors and a
  /// [PropagatingCollisionBehavior].
  ///
  /// This can be used for testing each behavior of a unicorn.
  @visibleForTesting
  Unicorn.test({
    required super.position,
    super.behaviors,
  })  : unicornComponent = UnicornComponent(size: Vector2.all(32)),
        super(size: Vector2.all(32));

  /// A state that describes how many times the unicorn ate food.
  int timesFed = 0;

  late final FullnessBehavior fullnessBehavior =
      findBehavior<FullnessBehavior>()!;

  late final EnjoymentBehavior enjoymentBehavior =
      findBehavior<EnjoymentBehavior>()!;

  double get happinessFactor =>
      fullnessBehavior.percentage * enjoymentBehavior.percentage;

  UnicornStage get currentStage =>
      findBehavior<EvolutionBehavior>()!.currentStage;

  final UnicornComponent unicornComponent;

  UnicornState? get state => unicornComponent.current;

  set state(UnicornState? state) => unicornComponent.current = state;

  @override
  Future<void> onLoad() async {
    await add(unicornComponent);
  }
}
