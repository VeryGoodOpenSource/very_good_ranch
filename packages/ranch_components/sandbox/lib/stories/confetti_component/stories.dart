import 'dart:ui';

import 'package:dashbook/dashbook.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:ranch_components/ranch_components.dart';

class ConfettiComponentExample extends FlameGame with TapDetector {
  ConfettiComponentExample({required this.confettiSize});

  final double confettiSize;
  @override
  void onTapUp(TapUpInfo info) {
    add(
      ConfettiComponent(
        position: info.eventPosition.game,
        confettiSize: confettiSize,
      ),
    );
  }

  @override
  Color backgroundColor() => const Color(0xFF666666);
}

void addConfettiComponentStories(Dashbook dashbook) {
  dashbook.storiesOf('ConfettiComponent').add(
    'basic',
    (context) {
      return GameWidget(
        game: ConfettiComponentExample(
          confettiSize: context.numberProperty('confettiSize', 10),
        ),
      );
    },
    info: 'Tap on the screen to create confetti',
  );
}
