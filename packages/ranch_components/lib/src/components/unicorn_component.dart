import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:ranch_components/gen/assets.gen.dart';

/// The animation state of the unicorn.
enum UnicornState {
  /// The unicorn is idle.
  idle,

  /// The unicorn is roaming.
  roaming,
}

/// {@template unicorn_component}
/// A component that represents a cute baby unicorn.
/// {@endtemplate}
class BabyUnicornComponent extends UnicornComponent {
  /// {@macro unicorn_component}
  BabyUnicornComponent()
      : super(
          size: dimensions,
          columns: 1,
          filePath: Assets.images.babySprite.packagePath,
        );

  static final dimensions = Vector2(57, 48.5);
}

/// {@template child_unicorn_component}
/// A component that represents a brace face child unicorn.
/// {@endtemplate}
class ChildUnicornComponent extends UnicornComponent {
  /// {@macro child_unicorn_component}
  ChildUnicornComponent()
      : super(
          size: dimensions,
          columns: 1,
          filePath: Assets.images.childSprite.packagePath,
        );

  static final dimensions = Vector2(71, 70);
}

/// {@template teen_unicorn_component}
/// A component that represents a tenacious teen unicorn.
/// {@endtemplate}
class TeenUnicornComponent extends UnicornComponent {
  /// {@macro teen_unicorn_component}
  TeenUnicornComponent()
      : super(
          size: dimensions,
          columns: 1,
          filePath: Assets.images.teenSprite.packagePath,
        );

  static final dimensions = Vector2(84, 87.5);
}

/// {@template adult_unicorn_component}
/// A component that represents a magnificent adult unicorn.
/// {@endtemplate}
class AdultUnicornComponent extends UnicornComponent {
  /// {@macro adult_unicorn_component}
  AdultUnicornComponent()
      : super(
          size: dimensions,
          columns: 1,
          filePath: Assets.images.adultSprite.packagePath,
        );

  static final dimensions = Vector2(90, 110.5);
}

/// {@template unicorn_component}
/// A component that represents a unicorn.
/// {@endtemplate}
abstract class UnicornComponent
    extends SpriteAnimationGroupComponent<UnicornState> with HasGameRef {
  /// {@macro unicorn_component}
  @visibleForTesting
  UnicornComponent({
    required String filePath,
    required int columns,
    required Vector2 size,
  })  : _columns = columns,
        _fileName = filePath,
        super(
          size: size,
          current: UnicornState.idle,
        );

  final int _columns;
  final String _fileName;

  @override
  Future<void> onLoad() async {
    final sheet = SpriteSheet.fromColumnsAndRows(
      image: await gameRef.images.load(_fileName),
      columns: _columns,
      rows: UnicornState.values.length,
    );

    const stepTime = .3;

    final idleAnimation = sheet.createAnimation(
      row: 0,
      stepTime: stepTime,
      to: 1,
    );

    final roamAnimation = sheet.createAnimation(
      row: 1,
      stepTime: stepTime,
      to: 1,
    );

    animations = {
      UnicornState.idle: idleAnimation,
      UnicornState.roaming: roamAnimation,
    };
  }
}
