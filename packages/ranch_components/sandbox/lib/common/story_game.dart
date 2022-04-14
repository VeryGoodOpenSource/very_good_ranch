import 'package:flame/components.dart';
import 'package:flame/game.dart';

class StoryGame extends FlameGame with HasDraggables, HasCollisionDetection {
  StoryGame(this.component);

  final PositionComponent component;

  @override
  Future<void> onLoad() async {
    camera.followVector2(Vector2.zero());
    await add(component);
  }
}
