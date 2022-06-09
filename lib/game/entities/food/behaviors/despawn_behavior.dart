import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:very_good_ranch/game/entities/entities.dart';
import 'package:very_good_ranch/game/entities/food/behaviors/behaviors.dart';

class DespawnBehavior extends Behavior<Food> {
  DespawnBehavior({
    required this.despawnTime,
  });

  /// The amount of time in seconds before the food despawns.
  final double despawnTime;

  TimerComponent? _timer;

  DraggingBehavior? draggable;

  @override
  Future<void> onLoad() async {
    draggable = parent.findBehavior<DraggingBehavior>();
    await add(_timer = TimerComponent(period: despawnTime, onTick: onDespawn));
  }

  void onDespawn() {
    parent.removeFromParent();
  }

  @override
  void update(double dt) {
    // If it is currently being dragged stop the timer
    if (draggable?.beingDragged == true) {
      _timer?.timer.stop();
    } else {
      if (!(_timer?.timer.isRunning() ?? false)) {
        _timer?.timer.start();
      }
    }

    super.update(dt);
  }
}
