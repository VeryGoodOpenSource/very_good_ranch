import 'package:flame/game.dart';
import 'package:flutter/material.dart';
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
            IconButton(onPressed: () {}, icon: const Icon(Icons.inventory)),
            IconButton(
              onPressed: () {
                if (overlays.isActive('shop')) {
                  overlays.remove('shop');
                }
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
}
