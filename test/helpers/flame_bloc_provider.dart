import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:very_good_ranch/game/game.dart';
import 'package:very_good_ranch/inventory/inventory.dart';

import 'helpers.dart';

FlameMultiBlocProvider flameBlocProvider({
  GameBloc? gameBloc,
  InventoryBloc? inventoryBloc,
  BlessingBloc? blessingBloc,
  required Component child,
}) {
  return FlameMultiBlocProvider(
    providers: [
      FlameBlocProvider<BlessingBloc, BlessingState>.value(
        value: blessingBloc ?? MockBlessingBloc(),
      ),
      FlameBlocProvider<GameBloc, GameState>.value(
        value: gameBloc ?? MockGameBloc(),
      ),
      FlameBlocProvider<InventoryBloc, InventoryState>.value(
        value: inventoryBloc ?? MockInventoryBloc(),
      ),
    ],
    children: [child],
  );
}
