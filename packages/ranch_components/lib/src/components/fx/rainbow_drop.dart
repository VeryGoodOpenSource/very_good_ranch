import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';
import 'package:ranch_components/ranch_components.dart';

/// {@template rainbow_drop}
/// A [PositionComponent] that renders a rainbow drop like effect that "carries"
/// a target into the game.
/// {@endtemplate}
class RainbowDrop extends PositionComponent with HasGameRef {
  /// {@macro rainbow_drop}
  RainbowDrop({
    /// The position that the [target] will be "dropped".
    required Vector2 position,

    /// The target that the drop will "carry" into the game.
    required PositionComponent target,

    /// The target sprite.
    required HasPaint sprite,
  })  : _target = target,
        _sprite = sprite,
        super(position: position, anchor: Anchor.bottomCenter, priority: 999);

  final PositionComponent _target;
  final HasPaint _sprite;

  static const _colors = [
    Color(0xFFEF6C6C),
    Color(0xFFEDB069),
    Color(0xFFFFDD99),
    Color(0xFF99FDFF),
    Color(0xFF51C7EC),
    Color(0xFF805BD4),
  ];

  @override
  Future<void> onLoad() async {
    final targetY = y;
    height = gameRef.size.y + position.y;
    y = -height;

    const baseTime = .4;
    final segmentSize = _target.size.y / _colors.length;

    unawaited(
      Future<void>.delayed(const Duration(milliseconds: 500), () {
        parent?.add(
          ConfettiComponent(
            position: position + Vector2(_target.size.x / 2, 0),
            confettiSize: segmentSize,
            priority: _sprite.priority + 1,
          ),
        );
      }),
    );

    unawaited(
      Future<void>.delayed(
        const Duration(milliseconds: 550),
        () {
          _sprite.setOpacity(0);
          parent?.add(
            _target..position = Vector2(x, targetY),
          );

          _sprite.add(
            OpacityEffect.to(
              1,
              CurvedEffectController(baseTime, Curves.easeOutCubic),
            ),
          );
          removeFromParent();
        },
      ),
    );

    await addAll(
      [
        ClipComponent.rect(
          size: Vector2(segmentSize * Colors.accents.length, height),
          children: [
            for (var i = 0; i < _colors.length; i++)
              RectangleComponent(
                paint: Paint()..color = _colors[i],
                size: Vector2(segmentSize, height),
                position: Vector2(segmentSize * i, 0),
                children: [
                  MoveEffect.to(
                    Vector2(segmentSize * i, height),
                    SequenceEffectController(
                      [
                        PauseEffectController(baseTime, progress: 0),
                        CurvedEffectController(baseTime, Curves.easeOutCubic),
                      ],
                    ),
                  ),
                  OpacityEffect.to(
                    0,
                    SequenceEffectController(
                      [
                        PauseEffectController(baseTime, progress: 0),
                        CurvedEffectController(baseTime, Curves.easeOut),
                      ],
                    ),
                  ),
                ],
              ),
          ],
        ),
        MoveEffect.to(
          Vector2(x, targetY + _target.size.y),
          CurvedEffectController(
            baseTime,
            Curves.easeOutCubic,
          ),
        ),
      ],
    );
  }
}
