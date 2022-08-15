import 'package:dashbook/dashbook.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:ranch_components/ranch_components.dart';

class _RainbowDropGame extends FlameGame with TapDetector {
  @override
  Color backgroundColor() => const Color(0xFF52C1B1);

  @override
  void onTapUp(TapUpInfo info) {
    add(
      RainbowDrop(
        position: info.eventPosition.game,
        target: RectangleComponent.square(
          size: 50,
          paint: Paint()..color = Colors.blue,
        ),
      ),
    );
  }
}

void addRainbowDropStories(Dashbook dashbook) {
  dashbook.storiesOf('RainbowDrop').add(
    'basic',
    (context) {
      return GameWidget(game: _RainbowDropGame());
    },
    info: '''
      A RainbowDrop "carries" a component into a position onto the game. Click anywhere on the screen to delivery a new unicorn component.
      ''',
  );
}
