import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_ranch/game/bloc/game/game_bloc.dart';
import 'package:very_good_ranch/game/very_good_ranch_game.dart';
import 'package:very_good_ranch/game/widgets/widgets.dart';
import 'package:very_good_ranch/inventory/inventory.dart';
import 'package:very_good_ranch/settings/settings.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  static Route route() {
    return MaterialPageRoute<void>(
      builder: (context) => const GamePage(),
    );
  }

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  late VeryGoodRanchGame _game;

  @override
  void initState() {
    super.initState();
    _game = VeryGoodRanchGame(
      gameBloc: BlocProvider.of<GameBloc>(context),
      inventoryBloc: BlocProvider.of<InventoryBloc>(context),
    );
  }

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
                  InventoryDialog.overlayKey: (context, game) {
                    return const InventoryDialog();
                  },
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
