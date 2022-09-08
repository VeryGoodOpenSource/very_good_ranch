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
  Color backgroundColor() => const Color(0xFF92DED3);

  @override
  Future<void> onLoad() async {
    final aspectRatio = size.x / size.y;
    const width = 680.0;
    final height = width / aspectRatio;

    camera.viewport = FixedResolutionViewport(Vector2(width, height));

    if (center) {
      camera.followVector2(Vector2.zero());
    }

    await add(_component);
  }
}
