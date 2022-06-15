import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:very_good_ranch/game/game.dart';

class ScoreIndicator extends PositionComponent
    with HasGameRef<VeryGoodRanchGame> {
  ScoreIndicator({
    required super.position,
  });

  @override
  PositionType get positionType => PositionType.game;

  static final _textPaint = TextPaint(
    style: GoogleFonts.mouseMemoirs(
      color: Colors.white,
      fontSize: 24,
      height: 1.2,
    ),
  );

  @override
  void render(Canvas canvas) {
    final l10n = gameRef.l10n;

    _textPaint.render(
      canvas,
      '${l10n.score}: ${gameRef.score}',
      Vector2(8, 8),
    );
  }
}
