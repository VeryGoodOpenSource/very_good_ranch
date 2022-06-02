import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:very_good_ranch/inventory/inventory.dart';
import 'package:very_good_ranch/settings/settings.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({
    super.key,
    required this.game,
  });

  final FlameGame game;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        border: Border(top: BorderSide()),
      ),
      padding: const EdgeInsets.all(8),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                _clearOverlays(except: InventoryDialog.overlayKey);
                if (!game.overlays.isActive(InventoryDialog.overlayKey)) {
                  game.overlays.add(InventoryDialog.overlayKey);
                }
              },
              icon: const Icon(Icons.inventory),
            ),
            IconButton(
              onPressed: () {
                _clearOverlays(except: SettingsDialog.overlayKey);
                if (!game.overlays.isActive(SettingsDialog.overlayKey)) {
                  game.overlays.add(SettingsDialog.overlayKey);
                }
              },
              icon: const Icon(Icons.settings),
            )
          ],
        ),
      ),
    );
  }

  void _clearOverlays({
    required String except,
  }) {
    if (game.overlays.isActive(
          InventoryDialog.overlayKey,
        ) &&
        except != InventoryDialog.overlayKey) {
      game.overlays.remove(InventoryDialog.overlayKey);
    }
    if (game.overlays.isActive(
          SettingsDialog.overlayKey,
        ) &&
        except != SettingsDialog.overlayKey) {
      game.overlays.remove(SettingsDialog.overlayKey);
    }
  }
}
