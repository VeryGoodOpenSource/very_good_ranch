import 'dart:async';
import 'dart:math';

import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:very_good_ranch/game/bloc/game/game_bloc.dart';
import 'package:very_good_ranch/game/components/components.dart';
import 'package:very_good_ranch/game/spawners/spawners.dart';
import 'package:very_good_ranch/inventory/inventory.dart';

class VeryGoodRanchGame extends FlameGame
    with HasDraggables, HasTappables, HasCollisionDetection {
  VeryGoodRanchGame({
    Random? seed,
    required this.gameBloc,
    required this.inventoryBloc,
    @visibleForTesting bool debugMode = kDebugMode,
  })  : _debugMode = debugMode,
        seed = seed ?? Random() {
    // Clearing the prefix allows us to load images from packages.
    images.prefix = '';
    Flame.images.prefix = '';
  }

  static const _virtualWidth = 800.0;

  /// The random number generator for this game, allowing it to be seed-able.
  final Random seed;

  final GameBloc gameBloc;

  final InventoryBloc inventoryBloc;

  final bool _debugMode;

  @override
  bool get debugMode => _debugMode;

  @override
  Color backgroundColor() => const Color(0xFFFFFFFF);

  @override
  Future<void> onLoad() async {
    final aspectRatio = size.x / size.y;
    const width = _virtualWidth;
    final height = width / aspectRatio;

    camera.viewport = FixedResolutionViewport(Vector2(width, height));

    await add(
      FlameMultiBlocProvider(
        providers: [
          FlameBlocProvider<GameBloc, GameState>.value(value: gameBloc),
          FlameBlocProvider<InventoryBloc, InventoryState>.value(
            value: inventoryBloc,
          ),
        ],
        children: [
          FoodSpawner(seed: seed),
          UnicornSpawner(seed: seed),
        ],
      ),
    );

    await add(
      UnicornCounter(
        position: Vector2(camera.viewport.effectiveSize.x, 0),
      ),
    );
  }

  @override
  void onTapUp(int pointerId, TapUpInfo info) {
    if (overlays.value.isNotEmpty) {
      overlays.clear();
    }
    return super.onTapUp(pointerId, info);
  }
}
