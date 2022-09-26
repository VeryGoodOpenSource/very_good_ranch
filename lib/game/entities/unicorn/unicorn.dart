import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flame_steering_behaviors/flame_steering_behaviors.dart';
import 'package:flutter/material.dart';
import 'package:ranch_components/ranch_components.dart';
import 'package:ranch_flame/ranch_flame.dart';
import 'package:very_good_ranch/config.dart';
import 'package:very_good_ranch/game/behaviors/behaviors.dart';
import 'package:very_good_ranch/game/entities/entities.dart';
import 'package:very_good_ranch/game/entities/unicorn/behaviors/behaviors.dart';

/// A type signature for callbacks that are invoked during a lifecycle method
/// of [Unicorn] that triggers the attachment or detachment of a gauge from the
/// component tree.
typedef UnicornGaugeCallback = void Function(GaugeComponent gauge);

class Unicorn extends Entity with Steerable, HasGameRef<SeedGame> {
  factory Unicorn({
    required Vector2 position,
    UnicornComponent? unicornComponent,
    required UnicornGaugeCallback onMountGauge,
    required UnicornGaugeCallback onUnmountGauge,
  }) {
    final _unicornComponent = unicornComponent ?? BabyUnicornComponent();
    final size = _unicornComponent.size;
    return Unicorn._(
      position: position,
      size: size,
      behaviors: [
        DraggingBehavior(),
        EvolvingBehavior(),
        PropagatingCollisionBehavior(RectangleHitbox()),
        MovingBehavior(),
        FoodCollidingBehavior(),
        FullnessDecreasingBehavior(),
        EnjoymentDecreasingBehavior(),
        LeavingBehavior(),
        PettingBehavior(),
        PositionalPriorityBehavior(anchor: Anchor.bottomCenter),
      ],
      enjoyment: UnicornPercentage(1),
      fullness: UnicornPercentage(1),
      unicornComponent: _unicornComponent,
      onMountGauge: onMountGauge,
      onUnmountGauge: onUnmountGauge,
    );
  }

  /// Creates a Unicorn without only the passed behaviors and a
  /// [PropagatingCollisionBehavior].
  ///
  /// This can be used for testing each behavior of a unicorn.
  @visibleForTesting
  factory Unicorn.test({
    required Vector2 position,
    Iterable<Behavior>? behaviors,
    UnicornComponent? unicornComponent,
    UnicornPercentage? enjoyment,
    UnicornPercentage? fullness,
    UnicornGaugeCallback? onMountGauge,
    UnicornGaugeCallback? onUnmountGauge,
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
      onMountGauge: onMountGauge ?? (_) {},
      onUnmountGauge: onUnmountGauge ?? (_) {},
    );
  }

  Unicorn._({
    required super.position,
    required super.size,
    required UnicornComponent unicornComponent,
    required this.enjoyment,
    required this.fullness,
    required this.onMountGauge,
    required this.onUnmountGauge,
    super.behaviors,
  })  : _unicornComponent = unicornComponent,
        super(children: [unicornComponent]);

  @override
  double get maxVelocity => 10;

  bool isGaugeVisible = true;

  bool beingDragged = false;

  int? overridePriority;

  @override
  int get priority => overridePriority ?? super.priority;

  /// A state that describes how many times the unicorn ate food.
  int timesFed = 0;

  /// A state that describes if the unicorn is leaving the field due to low
  /// [happiness].
  bool isLeaving = false;

  /// A state that describes the percentage of fullness of the unicorn
  final UnicornPercentage fullness;

  /// A state that describes the percentage of enjoyment of the unicorn
  final UnicornPercentage enjoyment;

  /// Callback that should take care of adding the gauge in the component
  /// tree in such a way it occludes all relevant elements.
  final UnicornGaugeCallback onMountGauge;

  /// Callback that should take care of removing the gauge from the component
  /// tree, after added by [onMountGauge].
  final UnicornGaugeCallback onUnmountGauge;

  late final WanderBehavior _wanderBehavior;

  /// [enjoyment] and [fullness] composes the overall happiness of
  /// the unicorn which is used to define if it should leave or evolve.
  ///
  /// Too low will cause the unicorn to leace, too high will allow the
  /// unicorn to evolve.
  double get happiness => fullness.value * enjoyment.value;

  UnicornComponent _unicornComponent;
  late GaugeComponent _gaugeComponent;

  UnicornComponent get unicornComponent {
    return _unicornComponent;
  }

  UnicornEvolutionStage get evolutionStage {
    return UnicornEvolutionStage.fromComponent(unicornComponent);
  }

  /// Indicates if [setEvolutionStage] scheduled a evolution to happen after
  /// the current [unicornComponent] animation cycle finishes.
  bool waitingCurrentAnimationToEvolve = false;

  /// Evolve the unicorn by substituting [unicornComponent].
  ///
  /// Waits for any current "finite" animation, such as "eating" or "petted" to
  /// finish.
  Future<void> setEvolutionStage(UnicornEvolutionStage evolutionStage) {
    final completer = Completer<void>();
    waitingCurrentAnimationToEvolve = true;
    void updateStage() {
      final nextUnicorn = evolutionStage.componentForEvolutionStage();

      _stopMoving();
      add(
        Evolution(
          from: unicornComponent,
          to: nextUnicorn,
          onFinish: () {
            waitingCurrentAnimationToEvolve = false;
            _unicornComponent = nextUnicorn;
            completer.complete();
          },
        ),
      );

      reset();
    }

    // Finish eat/petted animations before evolving
    if (_unicornComponent.isPlayingFiniteAnimation) {
      _unicornComponent
        ..cancelPostAnimationCycleCallbacks()
        ..addPostAnimationCycleCallback(updateStage);
    } else {
      updateStage();
    }

    return completer.future;
  }

  UnicornState get state => _unicornComponent.state;

  void setUnicornState(UnicornState state) {
    // While it is waiting to evolve, no new animations should be triggered
    if (waitingCurrentAnimationToEvolve) {
      return;
    }

    // Setting any state besides "walking" should stop the unicorn
    if (state == UnicornState.walking) {
      _startMoving();
    } else {
      _stopMoving();
    }

    _unicornComponent.playAnimation(state);

    if (_unicornComponent.isPlayingFiniteAnimation) {
      _unicornComponent.addPostAnimationCycleCallback(
        () {
          _stopMoving();
          _unicornComponent.playAnimation(UnicornState.idle);
        },
      );
    }
  }

  @override
  Future<void> onLoad() async {
    _wanderBehavior = WanderBehavior(
      circleDistance: Config.circleDistance,
      maximumAngle: Config.maximumAngleDegree * degrees2Radians,
      startingAngle: Config.startingAngleDegree * degrees2Radians,
      random: gameRef.seed,
    );
    _gaugeComponent = GaugeComponent(
      offset: Vector2(0, 10),
      priority: 10000,
      positionGetter: (gauge) {
        return positionOfAnchor(Anchor.bottomCenter);
      },
      visibilityPredicate: () {
        return isGaugeVisible;
      },
      percentages: [
        () => enjoyment.value,
        () => fullness.value,
      ],
    );
  }

  @override
  void onMount() {
    super.onMount();
    onMountGauge(_gaugeComponent);
  }

  @override
  void onRemove() {
    super.onRemove();
    onUnmountGauge(_gaugeComponent);
  }

  void reset() {
    timesFed = 0;
    fullness.reset();
    enjoyment.reset();
  }

  void feed(Food food) {
    final currentStage = evolutionStage;
    final fullnessFeedFactor = currentStage.fullnessFeedFactor;
    fullness.increaseBy(fullnessFeedFactor);

    final preferredFoodType = currentStage.preferredFoodType;
    final impactOnEnjoyment = preferredFoodType == food.type
        ? Config.positiveImpactOnEnjoyment
        : Config.negativeImpactOnEnjoyment;

    enjoyment.increaseBy(impactOnEnjoyment);
    timesFed++;
    food.removeFromParent();

    setUnicornState(UnicornState.eating);
  }

  void _startMoving() {
    if (!hasBehavior<WanderBehavior>() && !_wanderBehavior.isLoading) {
      _wanderBehavior.addToParent(this);
    }
  }

  void _stopMoving() {
    if (hasBehavior<WanderBehavior>() || _wanderBehavior.isLoading) {
      _wanderBehavior.removeFromParent();
    }
  }
}

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
  UnicornComponent componentForEvolutionStage() {
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
