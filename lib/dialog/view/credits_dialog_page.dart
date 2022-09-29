import 'package:flutter/material.dart';
import 'package:ranch_ui/ranch_ui.dart';
import 'package:very_good_ranch/dialog/view/dialog.dart';
import 'package:very_good_ranch/l10n/l10n.dart';

class CreditsDialogPage extends StatelessWidget {
  const CreditsDialogPage({super.key});

  static const width = 400.0;
  static const height = 600.0;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return ModalScaffold(
      title: Text(l10n.credits),
      body: Container(
        height: 400,
      ),
      footer: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context)
                  .pushReplacementNamed<void, void>(settingsRoute);
            },
            child: Text(l10n.ok),
          ),
        ],
      ),
    );
  }
}
