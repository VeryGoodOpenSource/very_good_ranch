import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:very_good_ranch/game/very_good_ranch_game.dart';

class GamePage extends StatelessWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GameWidget(game: VeryGoodRanchGame());
  }
}
