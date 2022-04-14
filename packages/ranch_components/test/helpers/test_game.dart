import 'package:flame/game.dart';

class TestGame extends FlameGame with HasDraggables, HasCollisionDetection {
  TestGame() {
    images.prefix = '';
  }
}
