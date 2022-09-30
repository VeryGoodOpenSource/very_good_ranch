import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ranch_ui/ranch_ui.dart';
import 'package:very_good_ranch/game_menu/view/game_menu_dialog.dart';
import 'package:very_good_ranch/l10n/l10n.dart';

class InstructionsDialogPage extends StatelessWidget {
  const InstructionsDialogPage({super.key});

  static const maxDialogWidth = 310.0;
  static const maxDialogHeight = 515.0;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return ModalScaffold(
      title: Text(l10n.instructions),
      body: const _InstructionsContent(),
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

class _InstructionsContent extends StatelessWidget {
  const _InstructionsContent({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return DefaultTextStyle.merge(
      textAlign: TextAlign.center,
      style: RanchUITheme.minorFontTextStyle.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        height: 1.25,
      ),
      child: ListBody(
        children: [
          Text(
            l10n.instructionsText,
          ),
        ],
      ),
    );
  }
}
