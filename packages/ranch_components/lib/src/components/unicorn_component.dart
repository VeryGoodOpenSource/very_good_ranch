import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
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
          size: Vector2(57, 48.5),
          columns: 1,
          filePath: Assets.images.babySprite.packagePath,
        );
}

/// {@template child_unicorn_component}
/// A component that represents a brace face child unicorn.
/// {@endtemplate}
class ChildUnicornComponent extends UnicornComponent {
  /// {@macro unicorn_component}
  ChildUnicornComponent()
      : super(
          size: Vector2(71, 70),
          columns: 1,
          filePath: Assets.images.childSprite.packagePath,
        );
}

/// {@template unicorn_component}
/// A component that represents a tenacious teen unicorn.
/// {@endtemplate}
class TeenUnicornComponent extends UnicornComponent {
  /// {@macro unicorn_component}
  TeenUnicornComponent()
      : super(
          size: Vector2(84, 87.5),
          columns: 1,
          filePath: Assets.images.teenSprite.packagePath,
        );
}

/// {@template unicorn_component}
/// A component that represents a magnificent adult unicorn.
/// {@endtemplate}
class AdultUnicornComponent extends UnicornComponent {
  /// {@macro unicorn_component}
  AdultUnicornComponent()
      : super(
          size: Vector2(90, 110.5),
          columns: 1,
          filePath: Assets.images.adultSprite.packagePath,
        );
}

/// {@template unicorn_component}
/// A component that represents a unicorn.
/// {@endtemplate}
abstract class UnicornComponent
    extends SpriteAnimationGroupComponent<UnicornState> {
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
          anchor: Anchor.center,
        );

  final int _columns;
  final String _fileName;

  @override
  Future<void> onLoad() async {
    final sheet = SpriteSheet.fromColumnsAndRows(
      image: await Flame.images.load(_fileName),
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
      to: 3,
    );

    animations = {
      UnicornState.idle: idleAnimation,
      UnicornState.roaming: roamAnimation,
    };
  }
}
