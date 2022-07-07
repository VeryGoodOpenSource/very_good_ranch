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
  adult;

  factory UnicornStage.fromComponent(UnicornComponent component) {
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

extension UnicornStageX on UnicornStage {
  UnicornComponent get componentForStage {
    switch (this) {
      case UnicornStage.baby:
        return BabyUnicornComponent();
      case UnicornStage.child:
        return ChildUnicornComponent();
      case UnicornStage.teen:
        return TeenUnicornComponent();
      case UnicornStage.adult:
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

  double fullnessFactor = 1;
  double enjoymentFactor = 1;

  double get happinessFactor => fullnessFactor * enjoymentFactor;

  UnicornComponent _unicornComponent;

  UnicornComponent get unicornComponent {
    return _unicornComponent;
  }

  UnicornStage get currentStage => UnicornStage.fromComponent(unicornComponent);

  void set currentStage(UnicornStage stage) {
    _unicornComponent.removeFromParent();
    add(_unicornComponent = stage.componentForStage);
  }

  UnicornState? get state => _unicornComponent.current;

  set state(UnicornState? state) => _unicornComponent.current = state;

  void reset() {
    timesFed = 0;
    fullnessFactor = 1;
    enjoymentFactor = 1;
  }
}
