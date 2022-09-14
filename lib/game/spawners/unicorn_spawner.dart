import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:ranch_components/ranch_components.dart';
import 'package:ranch_flame/ranch_flame.dart';
import 'package:very_good_ranch/game/entities/unicorn/unicorn.dart';
import 'package:very_good_ranch/game/game.dart';

class UnicornSpawner extends Component
    with
        ParentIsA<BackgroundComponent>,
        FlameBlocReader<BlessingBloc, BlessingState> {
  UnicornSpawner({
    required this.seed,
    this.secondSpawnThreshold = 30.0,
    this.spawnThreshold = 25.0,
    this.varyThresholdBy = 0.3,
  });

  final double spawnThreshold;
  final double secondSpawnThreshold;
  final double varyThresholdBy;

  late Timer _timer;

  int _spawnedUnicorns = 0;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    _spawnUnicorn();
  }

  /// The random number generator for spawning unicorn.
  final Random seed;

  void _spawnUnicorn() {
    _spawnedUnicorns++;

    final double nextLimit;
    if (_spawnedUnicorns == 0) {
      nextLimit = secondSpawnThreshold;
    } else {
      final variation = varyThresholdBy * spawnThreshold;
      nextLimit = spawnThreshold + exponentialDistribution(seed) * variation;
    }
    _timer = Timer(nextLimit, onTick: _spawnUnicorn);

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

  @override
  void update(double dt) {
    _timer.update(dt);
  }
}
