import 'dart:async';

import 'package:flame/cache.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/material.dart';
import 'package:ranch_components/gen/assets.gen.dart';

/// The animation state of the unicorn.
enum UnicornState {
  /// The unicorn is idle.
  idle,

  /// The unicorn is walking.
  walking,

  /// The unicorn is eating something (nice)
  eating,

  /// The unicorn is being petted
  petted,
}

/// {@template unicorn_component}
/// A component that represents a cute baby unicorn.
/// {@endtemplate}
class BabyUnicornComponent extends UnicornComponent {
  /// {@macro unicorn_component}
  BabyUnicornComponent({
    UnicornState? initialState,
  }) : super(
          spritePadding: const EdgeInsets.only(
            top: 136,
            left: 45,
            right: 55,
            bottom: 33,
          ),
          spriteComponent: UnicornSpriteComponent(
            initialState: initialState,
            eatAnimationData: UnicornAnimationData(
              columnsAmount: 10,
              frameAmount: 90,
              filePath: Assets.animations.babyEat.keyName,
            ),
            idleAnimationData: UnicornAnimationData(
              columnsAmount: 10,
              frameAmount: 50,
              filePath: Assets.animations.babyIdle.keyName,
            ),
            pettedAnimationData: UnicornAnimationData(
              columnsAmount: 10,
              frameAmount: 90,
              filePath: Assets.animations.babyPetted.keyName,
            ),
            walkAnimationData: UnicornAnimationData(
              columnsAmount: 7,
              frameAmount: 34,
              filePath: Assets.animations.babyWalkCycle.keyName,
            ),
          ),
        );
}

/// {@template child_unicorn_component}
/// A component that represents a brace face child unicorn.
/// {@endtemplate}
class ChildUnicornComponent extends UnicornComponent {
  /// {@macro child_unicorn_component}
  ChildUnicornComponent({
    UnicornState? initialState,
  }) : super(
          spritePadding: const EdgeInsets.only(
            top: 95,
            left: 40,
            right: 48,
            bottom: 33,
          ),
          spriteComponent: UnicornSpriteComponent(
            initialState: initialState,
            eatAnimationData: UnicornAnimationData(
              columnsAmount: 10,
              frameAmount: 90,
              filePath: Assets.animations.childEat.keyName,
            ),
            idleAnimationData: UnicornAnimationData(
              columnsAmount: 10,
              frameAmount: 50,
              filePath: Assets.animations.childIdle.keyName,
            ),
            pettedAnimationData: UnicornAnimationData(
              columnsAmount: 10,
              frameAmount: 90,
              filePath: Assets.animations.childPetted.keyName,
            ),
            walkAnimationData: UnicornAnimationData(
              columnsAmount: 7,
              frameAmount: 34,
              filePath: Assets.animations.childWalkCycle.keyName,
            ),
          ),
        );
}

/// {@template teen_unicorn_component}
/// A component that represents a tenacious teen unicorn.
/// {@endtemplate}
class TeenUnicornComponent extends UnicornComponent {
  /// {@macro teen_unicorn_component}
  TeenUnicornComponent({
    UnicornState? initialState,
  }) : super(
          spritePadding: const EdgeInsets.only(
            top: 72,
            left: 34,
            right: 34,
            bottom: 33,
          ),
          spriteComponent: UnicornSpriteComponent(
            initialState: initialState,
            eatAnimationData: UnicornAnimationData(
              columnsAmount: 10,
              frameAmount: 90,
              filePath: Assets.animations.teenEat.keyName,
            ),
            idleAnimationData: UnicornAnimationData(
              columnsAmount: 10,
              frameAmount: 50,
              filePath: Assets.animations.teenIdle.keyName,
            ),
            pettedAnimationData: UnicornAnimationData(
              columnsAmount: 10,
              frameAmount: 90,
              filePath: Assets.animations.teenPetted.keyName,
            ),
            walkAnimationData: UnicornAnimationData(
              columnsAmount: 7,
              frameAmount: 34,
              filePath: Assets.animations.teenWalkCycle.keyName,
            ),
          ),
        );
}

/// {@template adult_unicorn_component}
/// A component that represents a magnificent adult unicorn.
/// {@endtemplate}
class AdultUnicornComponent extends UnicornComponent {
  /// {@macro adult_unicorn_component}
  AdultUnicornComponent({
    UnicornState? initialState,
  }) : super(
          spritePadding: const EdgeInsets.only(
            top: 36,
            left: 25,
            right: 34,
            bottom: 33,
          ),
          spriteComponent: UnicornSpriteComponent(
            initialState: initialState,
            eatAnimationData: UnicornAnimationData(
              columnsAmount: 10,
              frameAmount: 90,
              filePath: Assets.animations.adultEat.keyName,
            ),
            idleAnimationData: UnicornAnimationData(
              columnsAmount: 10,
              frameAmount: 50,
              filePath: Assets.animations.adultIdle.keyName,
            ),
            pettedAnimationData: UnicornAnimationData(
              columnsAmount: 10,
              frameAmount: 90,
              filePath: Assets.animations.adultPetted.keyName,
            ),
            walkAnimationData: UnicornAnimationData(
              columnsAmount: 7,
              frameAmount: 34,
              filePath: Assets.animations.adultWalkCycle.keyName,
            ),
          ),
        );
}

/// {@template unicorn_animation_data}
///  The metadata o of a animation of a unicorn in a specific evolution stage
///  and state.
/// {@endtemplate}
@immutable
class UnicornAnimationData {
  /// {@macro unicorn_animation_data}
  const UnicornAnimationData({
    required this.frameAmount,
    required this.columnsAmount,
    required this.filePath,
  });

  /// The size of each frame in the unicorn spritesheets
  static final _unicornFrameSize = Vector2(338, 405);

  /// How many frames this animation has
  final int frameAmount;

  /// How many columns the sprite sheet files has
  final int columnsAmount;

  /// The path to the sprite sheet file
  final String filePath;

  /// Creates a [SpriteAnimation] from this metadata
  Future<SpriteAnimation> createAnimation({
    required Images images,
    required double duration,
    bool loop = false,
  }) async {
    final image = await images.load(filePath);
    final stepTime = duration / frameAmount;
    return SpriteAnimation.fromFrameData(
      image,
      SpriteAnimationData.sequenced(
        amount: frameAmount,
        stepTime: stepTime,
        amountPerRow: columnsAmount,
        textureSize: _unicornFrameSize,
        loop: loop,
      ),
    );
  }
}

/// {@template unicorn_component}
/// A [PositionComponent] that is responsible for containing a
/// [UnicornSpriteComponent] and padding it to the portion of the sprite
/// animation that actually paints a unicorn.
/// {@endtemplate}
abstract class UnicornComponent extends PositionComponent with HasPaint {
  /// {@macro unicorn_component}
  UnicornComponent({
    required this.spriteComponent,
    required this.spritePadding,
    super.children,
  }) {
    final _paddedRect =
        spritePadding.deflateRect(UnicornSpriteComponent.dimensions.toRect());
    size = _paddedRect.toVector2();
    // The padded offset is negatively appleid to the sprite component
    spriteComponent.position = _paddedRect.topLeft.toVector2() * -1;
  }

  /// Preload all unicorn assets into [images].
  static Future<void> preloadAssets(Images images) async {
    await images.loadAll([
      // Adult
      Assets.animations.adultEat.keyName,
      Assets.animations.adultIdle.keyName,
      Assets.animations.adultPetted.keyName,
      Assets.animations.adultWalkCycle.keyName,

      // Teen
      Assets.animations.teenEat.keyName,
      Assets.animations.teenIdle.keyName,
      Assets.animations.teenPetted.keyName,
      Assets.animations.teenWalkCycle.keyName,

      // Child
      Assets.animations.childEat.keyName,
      Assets.animations.childIdle.keyName,
      Assets.animations.childPetted.keyName,
      Assets.animations.childWalkCycle.keyName,

      // Baby
      Assets.animations.babyEat.keyName,
      Assets.animations.babyIdle.keyName,
      Assets.animations.babyPetted.keyName,
      Assets.animations.babyWalkCycle.keyName,
    ]);
  }

  /// The contained [UnicornSpriteComponent] that should be padded off.
  final UnicornSpriteComponent spriteComponent;

  /// The padding to be applied to the [spriteComponent].
  final EdgeInsets spritePadding;

  TimerComponent? _postAnimationCycleTimer;

  /// Indicates if the current unicorn animation does not loop
  bool get isPlayingFiniteAnimation => spriteComponent.animation?.loop == false;

  /// Get the current [UnicornState] being played by [spriteComponent].
  UnicornState get state => spriteComponent.current!;

  final _currentOnFinishCallbacks = <VoidCallback>[];

  bool _isFlushingPostAnimationCallbacks = false;

  /// Schedules [onFinishCallback] to be called after the current animation
  /// end its current cycle.
  void addPostAnimationCycleCallback(VoidCallback onFinishCallback) {
    _currentOnFinishCallbacks.add(onFinishCallback);
    final currentAnimation = spriteComponent.animation!;
    final afterAnimationTimer = _postAnimationCycleTimer;
    if (afterAnimationTimer == null) {
      add(
        _postAnimationCycleTimer = TimerComponent(
          period: currentAnimation.totalDuration() - currentAnimation.elapsed,
          removeOnFinish: true,
          onTick: () {
            _postAnimationCycleTimer = null;
            _isFlushingPostAnimationCallbacks = true;
            for (final element in _currentOnFinishCallbacks) {
              element();
            }
            _isFlushingPostAnimationCallbacks = false;
            _currentOnFinishCallbacks.clear();
          },
        ),
      );
    }
  }

  /// Cancels any callback added via [addPostAnimationCycleCallback].
  ///
  /// Do not invoke this on a callback added to [addPostAnimationCycleCallback].
  void cancelPostAnimationCycleCallbacks() {
    assert(
      !_isFlushingPostAnimationCallbacks,
      'Cannot cancel post animation callbacks while executing them',
    );
    _currentOnFinishCallbacks.clear();
  }

  /// Make [spriteComponent] play a sprite animation for the given [state].
  void playAnimation(UnicornState state) {
    // If "playAnimation" is called on a post animation callback, do not cancel
    // existing callbacks.
    if (!_isFlushingPostAnimationCallbacks) {
      cancelPostAnimationCycleCallbacks();
    }

    spriteComponent.current = state;
    spriteComponent.animation!.reset();
  }

  /// Borrow the paint from the sprite component.
  ///
  /// Effects applied to this component should be
  /// forwarded to the sprite component.
  @override
  Paint get paint => spriteComponent.paint;

  @override
  set paint(Paint value) => spriteComponent.paint = value;

  @override
  Future<void> onLoad() async {
    await add(spriteComponent);
  }
}

/// {@template unicorn_sprite_component}
/// A [SpriteAnimationGroupComponent] that paints a group of animations,
/// each for a [UnicornState]
/// {@endtemplate}
class UnicornSpriteComponent extends SpriteAnimationGroupComponent<UnicornState>
    with HasGameRef, ParentIsA<UnicornComponent> {
  /// {@macro unicorn_sprite_component}
  @visibleForTesting
  UnicornSpriteComponent({
    required this.eatAnimationData,
    required this.idleAnimationData,
    required this.pettedAnimationData,
    required this.walkAnimationData,
    UnicornState? initialState,
  }) : super(
          size: dimensions,
          current: initialState ?? UnicornState.idle,
        );

  /// The dimensions of the unicorn component in the canvas
  static Vector2 get dimensions => Vector2(202, 242);

  /// The Duration in seconds of the "eat" animation
  static const eatAnimationDuration = 1.5;

  /// The Duration in seconds of the "idle" animation
  static const idleAnimationDuration = 1.0;

  /// The Duration in seconds of the "petted" animation
  static const pettedAnimationDuration = 1.0;

  /// The Duration in seconds of the "walk" animation
  static const walkAnimationDuration = 1.0;

  /// The [UnicornAnimationData] for the [SpriteAnimation] to be run when
  /// [current] is [UnicornState.eating].
  final UnicornAnimationData eatAnimationData;

  /// The [UnicornAnimationData] for the [SpriteAnimation] to be run when
  /// [current] is [UnicornState.idle].
  final UnicornAnimationData idleAnimationData;

  /// The [UnicornAnimationData] for the [SpriteAnimation] to be run when
  /// [current] is [UnicornState.petted].
  final UnicornAnimationData pettedAnimationData;

  /// The [UnicornAnimationData] for the [SpriteAnimation] to be run when
  /// [current] is [UnicornState.walking].
  final UnicornAnimationData walkAnimationData;

  @override
  @visibleForTesting
  set current(UnicornState? value) {
    super.current = value;
  }

  @override
  Future<void> onLoad() async {
    final eatAnimation = await eatAnimationData.createAnimation(
      images: gameRef.images,
      duration: eatAnimationDuration,
    );

    final idleAnimation = await idleAnimationData.createAnimation(
      images: gameRef.images,
      duration: idleAnimationDuration,
      loop: true,
    );

    final pettedAnimation = await pettedAnimationData.createAnimation(
      images: gameRef.images,
      duration: pettedAnimationDuration,
    );

    final walkAnimation = await walkAnimationData.createAnimation(
      images: gameRef.images,
      duration: walkAnimationDuration,
      loop: true,
    );

    animations = {
      UnicornState.eating: eatAnimation,
      UnicornState.idle: idleAnimation,
      UnicornState.petted: pettedAnimation,
      UnicornState.walking: walkAnimation,
    };
  }
}
