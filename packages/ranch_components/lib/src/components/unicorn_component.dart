import 'dart:async';

import 'package:flame/assets.dart';
import 'package:flame/components.dart';
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
  BabyUnicornComponent()
      : super(
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
        );
}

/// {@template child_unicorn_component}
/// A component that represents a brace face child unicorn.
/// {@endtemplate}
class ChildUnicornComponent extends UnicornComponent {
  /// {@macro child_unicorn_component}
  ChildUnicornComponent()
      : super(
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
        );
}

/// {@template teen_unicorn_component}
/// A component that represents a tenacious teen unicorn.
/// {@endtemplate}
class TeenUnicornComponent extends UnicornComponent {
  /// {@macro teen_unicorn_component}
  TeenUnicornComponent()
      : super(
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
        );
}

/// {@template adult_unicorn_component}
/// A component that represents a magnificent adult unicorn.
/// {@endtemplate}
class AdultUnicornComponent extends UnicornComponent {
  /// {@macro adult_unicorn_component}
  AdultUnicornComponent()
      : super(
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
        );
}

/// {@template unicorn_animation_data}
///  The metadata o of a animation of a unicorn in a specific stage and state.
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
/// A component that represents a unicorn.
/// {@endtemplate}
class UnicornComponent extends SpriteAnimationGroupComponent<UnicornState>
    with HasGameRef {
  /// {@macro unicorn_component}
  UnicornComponent({
    required this.eatAnimationData,
    required this.idleAnimationData,
    required this.pettedAnimationData,
    required this.walkAnimationData,
  }) : super(
          size: dimensions,
          current: UnicornState.idle,
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
