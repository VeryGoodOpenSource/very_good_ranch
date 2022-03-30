import 'package:flutter/material.dart';
import 'package:very_good_ranch/l10n/l10n.dart';

class CreditsPage extends StatelessWidget {
  const CreditsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(context.l10n.credits);
  }
}
