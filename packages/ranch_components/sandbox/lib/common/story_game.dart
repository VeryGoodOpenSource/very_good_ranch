import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';

class StoryGame extends FlameGame {
  StoryGame(
    this._component, {
    this.center = true,
  }) {
    // Clearing the prefix allows us to load images from packages.
    images.prefix = '';
    Flame.images.prefix = '';
  }

  PositionComponent _component;

  PositionComponent get component => _component;

  Future<void> setComponent(PositionComponent value) async {
    _component.removeFromParent();
    value.removeFromParent();
    return add(_component = value);
  }

  final bool center;

  @override
  Color backgroundColor() => const Color(0xFF52C1B1);

  @override
  Future<void> onLoad() async {
    if (center) {
      camera.followVector2(Vector2.zero());
    }

    await add(_component);
  }
}
