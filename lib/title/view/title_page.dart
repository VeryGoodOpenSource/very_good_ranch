import 'package:flutter/material.dart';
import 'package:very_good_ranch/credits/credits.dart';
import 'package:very_good_ranch/game/game.dart';
import 'package:very_good_ranch/gen/assets.gen.dart';
import 'package:very_good_ranch/l10n/l10n.dart';
import 'package:very_good_ranch/settings/settings.dart';

class TitlePage extends StatelessWidget {
  const TitlePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            const Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF4776F7), Color(0xFFFFFFFF)],
                    begin: Alignment.center,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Image.asset(
                Assets.images.titleHills.path,
              ),
            ),
            Positioned.fill(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    Assets.images.titleHeader.path,
                    semanticLabel: context.l10n.gameTitle,
                  ),
                  const SizedBox(height: 64),
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
                        builder: (_) => const CreditsDialog(),
                      );
                    },
                    child: Text(context.l10n.credits),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      showDialog<void>(
                        context: context,
                        builder: (_) => const SettingsDialog(),
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
