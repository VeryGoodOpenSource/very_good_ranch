import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';

class TestGame extends FlameGame with HasDraggables, HasCollisionDetection {
  TestGame({
    Color? backgroundColor,
    this.center = false,
  }) : _backgroundColor = backgroundColor {
    images.prefix = '';
    Flame.images.prefix = '';
  }

  final Color? _backgroundColor;
  final bool center;

  @override
  Color backgroundColor() => _backgroundColor ?? const Color(0xFFFFFFFF);

  @override
  Future<void> onLoad() async {
    if (center) {
      camera.followVector2(Vector2.zero());
    }
  }
}
