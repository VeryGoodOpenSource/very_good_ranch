import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:very_good_ranch/inventory/inventory.dart';
import 'package:very_good_ranch/settings/settings.dart';

class GameView extends StatelessWidget {
  const GameView({super.key, required this.game});

  final FlameGame game;

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: game,
      overlayBuilderMap: {
        InventoryDialog.overlayKey: (context, game) {
          return const InventoryDialog();
        },
        SettingsDialog.overlayKey: (context, game) {
          return const SettingsDialog();
        }
      },
    );
  }
}
