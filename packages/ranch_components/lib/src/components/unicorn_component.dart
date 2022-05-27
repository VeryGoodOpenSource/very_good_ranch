import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:ranch_components/gen/assets.gen.dart';

/// The animation state of the unicorn.
enum UnicornState {
  /// The unicorn is idle.
  idle,

  /// The unicorn is roaming.
  roaming,
}

/// {@template unicorn_component}
/// A component that represents a unicorn.
/// {@endtemplate}
class UnicornComponent extends SpriteAnimationGroupComponent<UnicornState> {
  /// {@macro unicorn_component}
  UnicornComponent({Vector2? size})
      : super(
          size: size ?? Vector2.all(32),
          current: UnicornState.idle,
          anchor: Anchor.center,
        );

  @override
  Future<void> onLoad() async {
    final sheet = SpriteSheet.fromColumnsAndRows(
      image: await Flame.images.load(Assets.images.unicorn.keyName),
      columns: 4,
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
