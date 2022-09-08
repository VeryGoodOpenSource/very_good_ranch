import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flame_steering_behaviors/flame_steering_behaviors.dart';
import 'package:flutter/material.dart';
import 'package:ranch_components/ranch_components.dart';
import 'package:ranch_flame/ranch_flame.dart';
import 'package:very_good_ranch/game/behaviors/behaviors.dart';
import 'package:very_good_ranch/game/entities/entities.dart';
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
  UnicornComponent componentForEvolutionStage(
    UnicornState initialState,
  ) {
    switch (this) {
      case UnicornEvolutionStage.baby:
        return BabyUnicornComponent(initialState: initialState);
      case UnicornEvolutionStage.child:
        return ChildUnicornComponent(initialState: initialState);
      case UnicornEvolutionStage.teen:
        return TeenUnicornComponent(initialState: initialState);
      case UnicornEvolutionStage.adult:
        return AdultUnicornComponent(initialState: initialState);
    }
  }
}

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

  static const double positiveImpactOnEnjoyment = 0.3;
  static const double negativeImpactOnEnjoyment = -0.1;

  @override
  double get maxVelocity => 10;

  bool isGaugeVisible = true;

  /// A state that describes how many times the unicorn ate food.
  int timesFed = 0;

  /// A state that describes if the unicorn is leaving the field due to low
  /// [happiness].
  bool isLeaving = false;

  /// A state that describes the percentage of fullness of the unicorn
  final UnicornPercentage fullness;

  /// A state that describes the percentage of enjoyment of the unicorn
  final UnicornPercentage enjoyment;

  final UnicornGaugeCallback onMountGauge;

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

  set evolutionStage(UnicornEvolutionStage evolutionStage) {
    void updateStage() {
      // preserve walking/idle animation
      final currentState = state;

      _unicornComponent.removeFromParent();
      add(
        _unicornComponent =
            evolutionStage.componentForEvolutionStage(currentState),
      );

      size = _unicornComponent.size;
    }

    // Finish eat/petted animations before evolving
    if (_unicornComponent.isPlayingFiniteAnimation) {
      _unicornComponent.addPostAnimationCycleCallback(updateStage);
    } else {
      updateStage();
    }
  }

  UnicornState get state => _unicornComponent.state;

  void setUnicornState(UnicornState state) {
    _unicornComponent.playAnimation(state);

    if (_unicornComponent.isPlayingFiniteAnimation) {
      _unicornComponent.addPostAnimationCycleCallback(
        () {
          _unicornComponent.playAnimation(UnicornState.idle);
        },
      );
    }
  }

  @override
  Future<void> onLoad() async {
    _wanderBehavior = WanderBehavior(
      circleDistance: 10,
      maximumAngle: 15 * degrees2Radians,
      startingAngle: 0,
      random: gameRef.seed,
    );
    _gaugeComponent = GaugeComponent(
      offset: Vector2(0, 10),
      priority: 10000,
      positionGetter: (gauge) {
        return positionOfAnchor(Anchor.bottomCenter);
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
        ? positiveImpactOnEnjoyment
        : negativeImpactOnEnjoyment;

    enjoyment.increaseBy(impactOnEnjoyment);
    timesFed++;

    food.removeFromParent();
  }

  void startWalking() {
    // Unicorns cannot start to walk when in finite animations (eat/petted)
    if (_unicornComponent.isPlayingFiniteAnimation) {
      return;
    }

    setUnicornState(UnicornState.walking);
    if (!hasBehavior<WanderBehavior>()) {
      add(_wanderBehavior);
    }
  }

  void stopWalking() {
    if (hasBehavior<WanderBehavior>()) {
      _wanderBehavior.removeFromParent();
    }
    setUnicornState(UnicornState.idle);
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
