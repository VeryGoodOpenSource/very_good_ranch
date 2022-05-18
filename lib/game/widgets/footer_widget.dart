import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:very_good_ranch/inventory/view/view.dart';
import 'package:very_good_ranch/settings/settings.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({
    Key? key,
    required this.overlays,
  }) : super(key: key);

  final ActiveOverlaysNotifier overlays;

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
                if (!overlays.isActive(InventoryDialog.overlayKey)) {
                  overlays.add(InventoryDialog.overlayKey);
                }
              },
              icon: const Icon(Icons.inventory),
            ),
            IconButton(
              onPressed: () {
                _clearOverlays(except: SettingsDialog.overlayKey);
                if (!overlays.isActive(SettingsDialog.overlayKey)) {
                  overlays.add(SettingsDialog.overlayKey);
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
    if (overlays.isActive(
          InventoryDialog.overlayKey,
        ) &&
        except != InventoryDialog.overlayKey) {
      overlays.remove(InventoryDialog.overlayKey);
    }
    if (overlays.isActive(
          SettingsDialog.overlayKey,
        ) &&
        except != SettingsDialog.overlayKey) {
      overlays.remove(SettingsDialog.overlayKey);
    }
  }
}
