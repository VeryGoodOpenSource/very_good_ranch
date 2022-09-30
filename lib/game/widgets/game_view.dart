import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:very_good_ranch/game_menu/game_menu.dart';
import 'package:very_good_ranch/l10n/l10n.dart';

class GameView<GameType extends FlameGame> extends StatelessWidget {
  const GameView({super.key, required this.game});

  final GameType game;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return SafeArea(
      bottom: false,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final biggest = constraints.biggest;
          return Stack(
            fit: StackFit.expand,
            children: [
              GameWidget<GameType>(
                game: game,
              ),
              Positioned(
                top: biggest.height * 0.08,
                right: biggest.width * 0.04,
                child: IconButton(
                  tooltip: l10n.settings,
                  color: const Color(0xFF107161),
                  icon: const Icon(
                    Icons.tune,
                    size: 36,
                  ),
                  onPressed: () async {
                    game.pauseEngine();
                    await GameMenuDialog.open(context);
                    game.resumeEngine();
                  },
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
