import 'dart:math';
import 'dart:ui';

import 'package:dashbook/dashbook.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart' hide Gradient;
import 'package:ranch_components/ranch_components.dart';

class _Rectangle extends RectangleComponent {
  _Rectangle()
      : super(
          size: Vector2(200, 200),
          anchor: Anchor.center,
          paint: Paint()
            ..shader = Gradient.linear(
              Offset.zero,
              const Offset(0, 100),
              [Colors.orange, Colors.blue],
            ),
          children: [
            SequenceEffect(
              [
                RotateEffect.by(
                  pi * 2,
                  LinearEffectController(.4),
                ),
                RotateEffect.by(
                  0,
                  LinearEffectController(.4),
                ),
              ],
              infinite: true,
            ),
          ],
        );
}

class ClipComponentExample extends FlameGame {
  static String description = '';

  @override
  Future<void> onLoad() async {
    await addAll(
      [
        ClipComponent.rect(
          position: Vector2(100, 100),
          size: Vector2.all(50),
          children: [_Rectangle()],
        ),
        ClipComponent.circle(
          position: Vector2(200, 100),
          size: Vector2.all(50),
          children: [_Rectangle()],
        ),
        ClipComponent.polygon(
          points: [
            Vector2(50, 0),
            Vector2(50, 50),
            Vector2(0, 50),
            Vector2(50, 0),
          ],
          position: Vector2(150, 200),
          size: Vector2.all(50),
          children: [_Rectangle()],
        ),
      ],
    );
  }
}

void addClipComponentStories(Dashbook dashbook) {
  dashbook.storiesOf('ClipComponent').add('basic', (context) {
    return GameWidget(game: ClipComponentExample());
  });
}
