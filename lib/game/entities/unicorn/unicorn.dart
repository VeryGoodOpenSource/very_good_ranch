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
      enjoyment: UnicornPercentage(1),
      fullness: UnicornPercentage(1),
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
    UnicornPercentage? enjoyment,
    UnicornPercentage? fullness,
  }) {
    final _unicornComponent = unicornComponent ?? BabyUnicornComponent();
    final size = _unicornComponent.size;
    return Unicorn._(
      position: position,
      size: size,
      behaviors: behaviors,
      enjoyment: enjoyment ?? UnicornPercentage(1),
      fullness: fullness ?? UnicornPercentage(1),
      unicornComponent: _unicornComponent,
    );
  }

  Unicorn._({
    required super.position,
    required super.size,
    required UnicornComponent unicornComponent,
    required this.enjoyment,
    required this.fullness,
    super.behaviors,
  })  : _unicornComponent = unicornComponent,
        super(children: [unicornComponent]);

  /// A state that describes how many times the unicorn ate food.
  int timesFed = 0;

  /// A state that describes if the unicorn is leaving the field due to low
  /// [happiness].
  bool isLeaving = false;

  /// A state that describes the percentage of fullness of the unicorn
  final UnicornPercentage fullness;

  /// A state that describes the percentage of enjoyment of the unicorn
  final UnicornPercentage enjoyment;

  /// [enjoyment] and [fullness] composes the overall happiness of
  /// the unicorn which is used to define if it should leave or evolve.
  ///
  /// Too low will cause the unicorn to leace, too high will allow the
  /// unicorn to evolve.
  double get happiness => fullness.value * enjoyment.value;

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

  UnicornState? get state => _unicornComponent.state;

  set state(UnicornState? state) => _unicornComponent.state = state;

  void reset() {
    timesFed = 0;
    fullness.reset();
    enjoyment.reset();
  }
}

/// A mutable state that represents a percentage of a [Unicorn] trait that
/// affects its [Unicorn.happiness]
class UnicornPercentage {
  UnicornPercentage(this.initialPercentage)
      : _value = initialPercentage,
        assert(
          initialPercentage <= 1.0 && initialPercentage >= 0.0,
          'Initial percentage should be between 0 and 1',
        );

  final double initialPercentage;

  double _value;

  double get value => _value;

  set value(double value) => _value = value.clamp(0.0, 1.0);

  void reset() {
    _value = initialPercentage;
  }

  void increaseBy(double amount) {
    value += amount;
  }

  void decreaseBy(double amount) {
    value -= amount;
  }
}
