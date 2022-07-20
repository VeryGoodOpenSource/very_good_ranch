import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ranch_flame/ranch_flame.dart';
import 'package:very_good_ranch/app/view/game_viewport.dart';
import 'package:very_good_ranch/game/bloc/game/game_bloc.dart';
import 'package:very_good_ranch/game/very_good_ranch_game.dart';
import 'package:very_good_ranch/game/widgets/widgets.dart';
import 'package:very_good_ranch/inventory/inventory.dart';
import 'package:very_good_ranch/l10n/l10n.dart';

import 'package:very_good_ranch/loading/cubit/cubit.dart';

class GamePage extends StatefulWidget {
  const GamePage({
    super.key,
    this.game,
  });

  final FlameGame? game;

  static Route route() {
    return MaterialPageRoute<void>(
      builder: (context) => const GamePage(),
    );
  }

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  FlameGame? _game;

  late UnprefixedImages preloadedImages;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Retrieve preloaded images
    final cubit = BlocProvider.of<PreloadCubit>(context);
    preloadedImages = cubit.images;
  }

  @override
  Widget build(BuildContext context) {
    _game ??= widget.game ??
        VeryGoodRanchGame(
          gameBloc: context.read<GameBloc>(),
          inventoryBloc: context.read<InventoryBloc>(),
          l10n: context.l10n,
          images: preloadedImages,
        );

    return GameViewport(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: ClipRect(
                child: GameView(game: _game!),
              ),
            ),
            FooterWidget(game: _game!),
          ],
        ),
      ),
    );
  }
}
