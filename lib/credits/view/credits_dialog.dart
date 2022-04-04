import 'package:flutter/material.dart';
import 'package:very_good_ranch/l10n/l10n.dart';

class CreditsDialog extends StatelessWidget {
  const CreditsDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(context.l10n.credits),
      ),
    );
  }
}
