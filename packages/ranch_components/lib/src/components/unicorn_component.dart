import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:ranch_components/gen/assets.gen.dart';

enum UnicornState {
  idle,
  roaming,
}

/// {@template unicorn_component}
/// A component that represents a unicorn.
/// {@endtemplate}
class UnicornComponent extends SpriteAnimationGroupComponent<UnicornState> {
  /// {@macro unicorn_component}
  UnicornComponent({
    required Vector2 position,
  }) : super(
          position: position,
          size: Vector2.all(32),
          children: [RectangleHitbox()],
          current: UnicornState.idle,
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
