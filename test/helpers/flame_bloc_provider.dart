import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:very_good_ranch/game/game.dart';

import 'helpers.dart';

FlameMultiBlocProvider flameBlocProvider({
  BlessingBloc? blessingBloc,
  required Component child,
}) {
  return FlameMultiBlocProvider(
    providers: [
      FlameBlocProvider<BlessingBloc, BlessingState>.value(
        value: blessingBloc ?? MockBlessingBloc(),
      ),
    ],
    children: [child],
  );
}
