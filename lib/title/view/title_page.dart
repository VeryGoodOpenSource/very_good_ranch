import 'package:flutter/material.dart';
import 'package:very_good_ranch/credits/credits.dart';
import 'package:very_good_ranch/game/game.dart';
import 'package:very_good_ranch/l10n/l10n.dart';
import 'package:very_good_ranch/settings/settings.dart';

class TitlePage extends StatelessWidget {
  const TitlePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Text(
                  context.l10n.gameTitle,
                  style: Theme.of(context).textTheme.headline2,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement<void, void>(
                        GamePage.route(),
                      );
                    },
                    child: Text(context.l10n.play),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      showDialog<void>(
                        context: context,
                        builder: (_) => const _WrappedDialog(
                          child: CreditsPage(),
                        ),
                      );
                    },
                    child: Text(context.l10n.credits),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      showDialog<void>(
                        context: context,
                        builder: (_) => const _WrappedDialog(
                          child: SettingsPage(),
                        ),
                      );
                    },
                    child: Text(context.l10n.settings),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WrappedDialog extends StatelessWidget {
  const _WrappedDialog({
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: child,
      ),
    );
  }
}
