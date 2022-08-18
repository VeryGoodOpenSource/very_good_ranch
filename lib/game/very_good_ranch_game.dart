import 'dart:async';
import 'dart:math';

import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/material.dart';
import 'package:ranch_components/ranch_components.dart';
import 'package:ranch_flame/ranch_flame.dart';
import 'package:very_good_ranch/game/bloc/blessing/blessing_bloc.dart';
import 'package:very_good_ranch/game/bloc/game/game_bloc.dart';
import 'package:very_good_ranch/game/spawners/spawners.dart';
import 'package:very_good_ranch/inventory/inventory.dart';

class VeryGoodRanchGame extends FlameGame
    with HasDraggables, HasTappables, HasCollisionDetection, SeedGame {
  VeryGoodRanchGame({
    Random? seed,
    required this.blessingBloc,
    required this.gameBloc,
    required this.inventoryBloc,
    UnprefixedImages? images,
    @visibleForTesting bool debugMode = false,
    EdgeInsets viewPadding = EdgeInsets.zero,
  })  : _images = images ?? UnprefixedImages(),
        _viewPadding = viewPadding,
        _debugMode = debugMode,
        seed = seed ?? Random();

  static const _virtualWidth = 680.0;

  final UnprefixedImages _images;

  final EdgeInsets _viewPadding;

  @override
  UnprefixedImages get images => _images;

  @override
  final Random seed;

  final BlessingBloc blessingBloc;

  final GameBloc gameBloc;

  final InventoryBloc inventoryBloc;

  final bool _debugMode;

  @override
  bool get debugMode => _debugMode;

  @override
  Color backgroundColor() => Colors.transparent;

  late final BackgroundComponent background;

  @override
  Future<void> onLoad() async {
    final aspectRatio = size.x / size.y;
    const width = _virtualWidth;
    final height = width / aspectRatio;

    camera.viewport = FixedResolutionViewport(Vector2(width, height));

    await add(
      FlameMultiBlocProvider(
        providers: [
          FlameBlocProvider<BlessingBloc, BlessingState>.value(
            value: blessingBloc,
          ),
          FlameBlocProvider<GameBloc, GameState>.value(value: gameBloc),
          FlameBlocProvider<InventoryBloc, InventoryState>.value(
            value: inventoryBloc,
          ),
        ],
        children: [
          background = BackgroundComponent(
            viewPadding: _viewPadding,
            children: [
              FoodSpawner(seed: seed),
              UnicornSpawner(seed: seed),
            ],
          ),
        ],
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
