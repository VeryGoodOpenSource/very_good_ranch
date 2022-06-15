import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';

class TestGame extends FlameGame with HasDraggables, HasCollisionDetection {
  TestGame([this._backgroundColor]) {
    images.prefix = '';
    Flame.images.prefix = '';
  }

  final Color? _backgroundColor;

  @override
  Color backgroundColor() => _backgroundColor ?? const Color(0xFFFFFFFF);
}
