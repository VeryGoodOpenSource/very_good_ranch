import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:ranch_components/ranch_components.dart';
import 'package:very_good_ranch/game/entities/unicorn/unicorn.dart';

class UnicornSpawner extends TimerComponent
    with ParentIsA<BackgroundComponent> {
  UnicornSpawner({
    required this.seed,
    double spawnThreshold = 20.0,
  }) : super(repeat: true, period: spawnThreshold);

  /// The random number generator for spawning unicorn.
  final Random seed;

  @override
  void onTick() {
    // TODO(wolfen): Before the random check, confirm that the overal happiness
    // allows for a new friend to join.
    if (seed.nextDouble() < .5) {
      return;
    }

    final pastureArea = parent.pastureArea;
    final position = Vector2.random(seed)
      ..multiply(pastureArea.size.toVector2())
      ..add(pastureArea.topLeft.toVector2());

    parent.add(Unicorn(position: position));
  }
}
