import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class GameView extends StatelessWidget {
  const GameView({super.key, required this.game});

  final FlameGame game;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: GameWidget(game: game),
    );
  }
}
