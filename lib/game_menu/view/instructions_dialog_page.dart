import 'package:flutter/material.dart';
import 'package:ranch_ui/ranch_ui.dart';
import 'package:very_good_ranch/game_menu/view/game_menu_dialog.dart';
import 'package:very_good_ranch/l10n/l10n.dart';

class InstructionsDialogPage extends StatelessWidget {
  const InstructionsDialogPage({super.key});

  static const maxDialogWidth = 400.0;
  static const maxDialogHeight = 800.0;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return ModalScaffold(
      title: Text(l10n.instructions),
      body: Container(
        height: 600,
      ),
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
