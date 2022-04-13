import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';

class VeryGoodRanchGame extends FlameGame with TapDetector {
  @override
  Color backgroundColor() => const Color(0xFFFFFFFF);

  @override
  void onTapUp(TapUpInfo info) {
    if (overlays.value.isNotEmpty) {
      overlays.clear();
    }
    return super.onTapUp(info);
  }
}
