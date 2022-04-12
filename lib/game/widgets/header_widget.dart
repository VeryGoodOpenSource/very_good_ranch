import 'package:flutter/material.dart';
import 'package:very_good_ranch/l10n/l10n.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide()),
      ),
      padding: const EdgeInsets.all(8),
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Text(context.l10n.gameTitle),
          ],
        ),
      ),
    );
  }
}
