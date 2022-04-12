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

// NOTE(wolfen): remove when https://github.com/flame-engine/flame/pull/1536 is merged
extension _ActiveOverlaysNotifier on ActiveOverlaysNotifier {
  void clear() {
    value.clear();
    // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
    notifyListeners();
  }
}
