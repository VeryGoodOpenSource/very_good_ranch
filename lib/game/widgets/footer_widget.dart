import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:ranch_ui/ranch_ui.dart';
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
      padding: const EdgeInsets.symmetric(
        horizontal: 28,
        vertical: 28,
      ).copyWith(top: 0),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const UnicornCounter(
              isActive: true,
              type: UnicornType.baby,
              child: Text('1'),
            ),
            const SizedBox(width: 16),
            const UnicornCounter(
              isActive: true,
              type: UnicornType.child,
              child: Text('1'),
            ),
            const SizedBox(width: 16),
            const UnicornCounter(
              isActive: true,
              type: UnicornType.teen,
              child: Text('1'),
            ),
            const SizedBox(width: 16),
            const UnicornCounter(
              isActive: false,
              type: UnicornType.adult,
              child: Text('0'),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  _clearOverlays(except: InventoryDialog.overlayKey);
                  if (!game.overlays.isActive(InventoryDialog.overlayKey)) {
                    game.overlays.add(InventoryDialog.overlayKey);
                  }
                },
                child: const Center(child: Text('Inventory PLACEHOLDER')),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _clearOverlays({
    required String except,
  }) {
    if (game.overlays.isActive(
          SettingsDialog.overlayKey,
        ) &&
        except != SettingsDialog.overlayKey) {
      game.overlays.remove(SettingsDialog.overlayKey);
    }
  }
}
