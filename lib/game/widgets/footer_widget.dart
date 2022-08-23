import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ranch_ui/ranch_ui.dart';
import 'package:very_good_ranch/game/game.dart';
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
            const _UnicornCounter(type: UnicornType.baby),
            const SizedBox(width: 16),
            const _UnicornCounter(type: UnicornType.child),
            const SizedBox(width: 16),
            const _UnicornCounter(type: UnicornType.teen),
            const SizedBox(width: 16),
            const _UnicornCounter(type: UnicornType.adult),
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

class _UnicornCounter extends StatelessWidget {
  const _UnicornCounter({
    required this.type,
  });

  final UnicornType type;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlessingBloc, BlessingState>(
      builder: (context, state) {
        final count = state.getUnicornCountForType(type);
        return UnicornCounter(
          isActive: count > 0,
          type: type,
          child: Text(count.toString()),
        );
      },
    );
  }
}

extension on BlessingState {
  int getUnicornCountForType(UnicornType type) {
    switch (type) {
      case UnicornType.baby:
        return babyUnicorns;
      case UnicornType.child:
        return childUnicorns;
      case UnicornType.teen:
        return teenUnicorns;
      case UnicornType.adult:
        return adultUnicorns;
    }
  }
}
