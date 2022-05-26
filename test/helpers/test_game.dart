import 'dart:ui';

import 'package:flame/flame.dart';
import 'package:flame/game.dart';

class TestGame extends FlameGame
    with HasTappables, HasDraggables, HasCollisionDetection {
  TestGame() {
    images.prefix = '';
    Flame.images.prefix = '';
  }

  @override
  Color backgroundColor() => const Color(0xFFFFFFFF);
}
