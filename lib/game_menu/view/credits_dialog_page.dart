import 'package:flutter/material.dart';
import 'package:ranch_ui/ranch_ui.dart';
import 'package:very_good_ranch/game_menu/game_menu.dart';
import 'package:very_good_ranch/l10n/l10n.dart';

class CreditsDialogPage extends StatelessWidget {
  const CreditsDialogPage({super.key});

  static const maxDialogWidth = 400.0;
  static const maxDialogHeight = 600.0;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return ModalScaffold(
      title: Text(l10n.credits),
      body: const SizedBox.shrink(),
      footer: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed<void, void>(
                GameMenuRoute.settings.name,
              );
            },
            child: Text(l10n.ok),
          ),
        ],
      ),
    );
  }
}
