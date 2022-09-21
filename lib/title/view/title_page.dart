import 'package:flutter/material.dart';
import 'package:ranch_ui/ranch_ui.dart';
import 'package:very_good_ranch/app/view/game_viewport.dart';
import 'package:very_good_ranch/game/game.dart';
import 'package:very_good_ranch/gen/assets.gen.dart';
import 'package:very_good_ranch/l10n/l10n.dart';
import 'package:very_good_ranch/settings/settings.dart';

const _skyPercentageOnYAxis = 0.36;

class TitlePage extends StatelessWidget {
  const TitlePage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(
      builder: (_) => const TitlePage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GameViewport(
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: const [
            TitlePageSky(),
            TitlePageGround(),
            TitlePageMenu(),
          ],
        ),
      ),
    );
  }
}

@visibleForTesting
class TitlePageSky extends StatelessWidget {
  const TitlePageSky({super.key});

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0, _skyPercentageOnYAxis],
          colors: [
            Color(0xFF5F9EFA),
            Color(0xFF9CFFFE),
          ],
        ),
      ),
    );
  }
}

@visibleForTesting
class TitlePageGround extends StatelessWidget {
  const TitlePageGround({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final biggest = constraints.biggest;
        final horizon = biggest.height * _skyPercentageOnYAxis;
        return Stack(
          children: [
            // Rainbow
            Positioned(
              left: 0,
              height: horizon + 2, // pixel correction from png anti alias
              width: biggest.width * 0.75,
              child: Image.asset(
                Assets.images.titleRainbow.path,
                alignment: Alignment.bottomLeft,
                fit: BoxFit.contain,
                excludeFromSemantics: true,
              ),
            ),

            // Ground gradient
            Positioned.fill(
              top: horizon,
              child: const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF46B2A0),
                      Color(0xFF92DED3),
                    ],
                  ),
                ),
              ),
            ),

            // Barn
            Positioned(
              left: 0,
              right: 0,
              height: biggest.height * 0.105,
              // pixel correction from png anti alias
              bottom: biggest.height - horizon - 2,
              child: Image.asset(
                Assets.images.titleBarn.path,
                alignment: Alignment.bottomCenter,
                fit: BoxFit.contain,
                excludeFromSemantics: true,
              ),
            ),

            // Tree and plants
            Positioned(
              top: horizon - biggest.height * 0.1,
              bottom: 10,
              left: 0,
              right: 0,
              child: Image.asset(
                Assets.images.titleBackground.path,
                fit: BoxFit.cover,
                excludeFromSemantics: true,
              ),
            ),

            // unicorn
            Positioned.fromRelativeRect(
              rect: RelativeRect.fromLTRB(
                biggest.width * 0.15,
                biggest.height * 0.37,
                biggest.width * 0.15,
                biggest.height * 0.25,
              ),
              child: Image.asset(
                Assets.images.titleUnicorn.path,
                fit: BoxFit.contain,
                excludeFromSemantics: true,
              ),
            ),
          ],
        );
      },
    );
  }
}

@visibleForTesting
class TitlePageMenu extends StatelessWidget {
  const TitlePageMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final biggest = constraints.biggest;
        return Stack(
          children: [
            Positioned(
              left: biggest.height * 0.05,
              right: biggest.height * 0.05,
              bottom: biggest.height * 0.78,
              height: biggest.height * 0.2,
              child: Center(
                child: ConstrainedBox(
                  constraints: constraints.loosen().copyWith(maxWidth: 550),
                  child: Image.asset(
                    Assets.images.titleBoard.path,
                    fit: BoxFit.contain,
                    excludeFromSemantics: true,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 16,
              left: 0,
              right: 0,
              height: biggest.height * 0.25,
              child: const _Buttons(),
            ),
          ],
        );
      },
    );
  }
}

class _Buttons extends StatelessWidget {
  const _Buttons();

  void goPlay(BuildContext context) {
    Navigator.of(context).pushReplacement<void, void>(
      GamePage.route(),
    );
  }

  void goSettings(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (_) => const SettingsDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return OverflowBox(
      minHeight: 150,
      maxHeight: 1000,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BoardButton(
              child: Text(context.l10n.play),
              onTap: () {
                goPlay(context);
              },
            ),
            BoardButtonTheme.minor(
              child: BoardButton(
                child: Text(context.l10n.settings),
                onTap: () {
                  goSettings(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
