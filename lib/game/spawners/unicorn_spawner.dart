import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:ranch_components/ranch_components.dart';
import 'package:very_good_ranch/game/entities/unicorn/unicorn.dart';
import 'package:very_good_ranch/game/game.dart';

class UnicornSpawner extends TimerComponent
    with
        ParentIsA<BackgroundComponent>,
        FlameBlocReader<BlessingBloc, BlessingState> {
  UnicornSpawner({
    required this.seed,
    double spawnThreshold = 20.0,
  }) : super(repeat: true, period: spawnThreshold);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    addUnicorn();
  }

  /// The random number generator for spawning unicorn.
  final Random seed;

  @override
  void onTick() {
    if (seed.nextDouble() < .5) {
      return;
    }
    addUnicorn();
  }

  void addUnicorn() {
    final pastureField = parent.pastureField;
    final unicorn = Unicorn(
      position: Vector2.zero(),
      onMountGauge: (gauge) {
        parent.add(gauge);
      },
      onUnmountGauge: (gauge) {
        parent.remove(gauge);
      },
    );
    final position = Vector2.random(seed)
      ..multiply(pastureField.size.toVector2() - unicorn.size)
      ..add(pastureField.topLeft.toVector2());

    parent.add(
      RainbowDrop(
        position: position,
        target: unicorn,
        sprite: unicorn.unicornComponent,
      ),
    );
    bloc.add(UnicornSpawned());
  }
}
