import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:very_good_ranch/game/very_good_ranch_game.dart';
import 'package:very_good_ranch/game/widgets/widgets.dart';
import 'package:very_good_ranch/settings/settings.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(
      builder: (_) => const GamePage(),
    );
  }

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final _game = VeryGoodRanchGame();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const HeaderWidget(),
          Expanded(
            child: ClipRect(
              child: GameWidget(
                game: _game,
                overlayBuilderMap: {
                  SettingsDialog.overlayKey: (context, game) {
                    return const SettingsDialog();
                  }
                },
              ),
            ),
          ),
          FooterWidget(overlays: _game.overlays),
        ],
      ),
    );
  }
}
