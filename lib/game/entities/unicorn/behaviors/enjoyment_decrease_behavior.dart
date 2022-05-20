import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:very_good_ranch/game/entities/unicorn/unicorn.dart';

class EnjoymentDecreaseBehavior extends Behavior<Unicorn> {
  static double decreaseInterval = 8;

  @override
  Future<void> onLoad() async {
    await add(
      TimerComponent(
        period: decreaseInterval,
        repeat: true,
        onTick: _decreaseEnjoyment,
      ),
    );
  }

  void _decreaseEnjoyment() {
    parent.enjoymentFactor -= parent.currentStage.enjoymentDecreaseFactor;
  }
}

extension on UnicornStage {
  /// Percentage that of enjoyment lost every
  /// [EnjoymentDecreaseBehavior.decreaseInterval].
  double get enjoymentDecreaseFactor {
    switch (this) {
      case UnicornStage.baby:
        return 0.3;
      case UnicornStage.kid:
        return 0.2;
      case UnicornStage.teenager:
        return 0.1;
      case UnicornStage.adult:
        return 0.1;
    }
  }
}
