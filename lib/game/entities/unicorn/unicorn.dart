import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flutter/material.dart';
import 'package:ranch_components/ranch_components.dart';
import 'package:very_good_ranch/game/entities/unicorn/behaviors/behaviors.dart';

enum UnicornEvolutionStage {
  baby,
  child,
  teen,
  adult;

  factory UnicornEvolutionStage.fromComponent(UnicornComponent component) {
    if (component is BabyUnicornComponent) {
      return baby;
    }
    if (component is ChildUnicornComponent) {
      return child;
    }
    if (component is TeenUnicornComponent) {
      return teen;
    }

    return adult;
  }
}

extension UnicornEvolutionStageX on UnicornEvolutionStage {
  UnicornComponent get componentForEvolutionStage {
    switch (this) {
      case UnicornEvolutionStage.baby:
        return BabyUnicornComponent();
      case UnicornEvolutionStage.child:
        return ChildUnicornComponent();
      case UnicornEvolutionStage.teen:
        return TeenUnicornComponent();
      case UnicornEvolutionStage.adult:
        return AdultUnicornComponent();
    }
  }
}

class Unicorn extends Entity {
  factory Unicorn({
    required Vector2 position,
    UnicornComponent? unicornComponent,
  }) {
    final _unicornComponent = unicornComponent ?? BabyUnicornComponent();
    final size = _unicornComponent.size;
    return Unicorn._(
      position: position,
      size: size,
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
      unicornComponent: _unicornComponent,
    );
  }

  /// Creates a Unicorn without only the passed behaviors and a
  /// [PropagatingCollisionBehavior].
  ///
  /// This can be used for testing each behavior of a unicorn.
  @visibleForTesting
  factory Unicorn.test({
    required Vector2 position,
    Iterable<Behavior<Unicorn>>? behaviors,
    UnicornComponent? unicornComponent,
  }) {
    final _unicornComponent = unicornComponent ?? BabyUnicornComponent();
    final size = _unicornComponent.size;
    return Unicorn._(
      position: position,
      size: size,
      behaviors: behaviors,
      unicornComponent: _unicornComponent,
    );
  }

  Unicorn._({
    required super.position,
    required super.size,
    required UnicornComponent unicornComponent,
    super.behaviors,
  })  : _unicornComponent = unicornComponent,
        super(children: [unicornComponent]);

  /// A state that describes how many times the unicorn ate food.
  int timesFed = 0;

  /// A state that describes the percentage of fullness of the unicorn
  double get fullnessFactor => _fullnessFactor;

  set fullnessFactor(double value) => _fullnessFactor = value.clamp(0.0, 1.0);

  double _fullnessFactor = 1;

  /// A state that describes the percentage of enjoyment of the unicorn
  double get enjoymentFactor => _enjoymentFactor;

  set enjoymentFactor(double value) => _enjoymentFactor = value.clamp(0.0, 1.0);

  double _enjoymentFactor = 1;

  /// [enjoymentFactor] and [fullnessFactor] composes the overall hapiness of
  /// the unicorn which is used to define if it should leave or evolve.
  ///
  /// Too low will cause the unicorn to leace, too high will allow the
  /// unicorn to evolve.
  double get happinessFactor => fullnessFactor * enjoymentFactor;

  UnicornComponent _unicornComponent;

  UnicornComponent get unicornComponent {
    return _unicornComponent;
  }

  UnicornEvolutionStage get evolutionStage {
    return UnicornEvolutionStage.fromComponent(unicornComponent);
  }

  set evolutionStage(UnicornEvolutionStage evolutionStage) {
    _unicornComponent.removeFromParent();
    add(_unicornComponent = evolutionStage.componentForEvolutionStage);
  }

  UnicornState? get state => _unicornComponent.current;

  set state(UnicornState? state) => _unicornComponent.current = state;

  void reset() {
    timesFed = 0;
    fullnessFactor = 1;
    enjoymentFactor = 1;
  }
}
