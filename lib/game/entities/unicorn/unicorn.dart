import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flutter/material.dart';
import 'package:ranch_components/ranch_components.dart';
import 'package:very_good_ranch/game/entities/unicorn/behaviors/behaviors.dart';

enum UnicornStage {
  baby,
  child,
  teen,
  adult,
}

class Unicorn extends Entity {
  Unicorn({
    required super.position,
  }) : super(
          behaviors: [
            EvolutionBehavior(),
            PropagatingCollisionBehavior(RectangleHitbox()),
            MovementBehavior(),
            FoodCollisionBehavior(),
            FullnessBehavior(),
            EnjoymentBehavior(),
            LeavingBehavior(),
            PetBehavior(),
          ],
        ) {
    final unicornComponent = BabyUnicornComponent();
    add(this.unicornComponent = unicornComponent);
  }

  /// Creates a Unicorn without only the passed behaviors and a
  /// [PropagatingCollisionBehavior].
  ///
  /// This can be used for testing each behavior of a unicorn.
  @visibleForTesting
  factory Unicorn.test({
    required Vector2 position,
    Iterable<Behavior<Unicorn>>? behaviors,
  }) {
    final _unicornComponent = BabyUnicornComponent();
    final size = _unicornComponent.size;
    final unicorn = Unicorn._(
      position: position,
      size: size,
      behaviors: behaviors,
      unicornComponent: _unicornComponent,
    );
    unicorn.add(_unicornComponent)?.then((value) {
      unicorn.unicornComponent = _unicornComponent;
    });

    return unicorn;
  }

  Unicorn._({
    required super.position,
    required super.size,
    super.behaviors,
    UnicornComponent? unicornComponent,
  }) : _unicornComponent = unicornComponent;

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

  UnicornComponent? _unicornComponent;

  UnicornComponent get unicornComponent {
    assert(
      _unicornComponent != null,
      'Make sure to access for the unicorn '
      'component after the onLoad phase is complete.',
    );
    return _unicornComponent!;
  }

  set unicornComponent(UnicornComponent value) {
    _unicornComponent = value;
    size = value.size;
  }

  UnicornState? get state => _unicornComponent?.current;

  set state(UnicornState? state) => _unicornComponent?.current = state;
}
