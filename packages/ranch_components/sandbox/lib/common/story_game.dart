import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';

class StoryGame extends FlameGame {
  StoryGame(
    this.component, {
    this.center = true,
  }) {
    // Clearing the prefix allows us to load images from packages.
    images.prefix = '';
    Flame.images.prefix = '';
  }

  final PositionComponent component;
  final bool center;

  @override
  Color backgroundColor() => const Color(0xFF52C1B1);

  @override
  Future<void> onLoad() async {
    if (center) {
      camera.followVector2(Vector2.zero());
    }
    await add(component);
  }
}
