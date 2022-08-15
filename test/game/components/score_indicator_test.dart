// ignore_for_file: cascade_invocations

import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:very_good_ranch/game/bloc/game/game_bloc.dart';
import 'package:very_good_ranch/game/very_good_ranch_game.dart';
import 'package:very_good_ranch/l10n/l10n.dart';

import '../../helpers/helpers.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late GameBloc gameBloc;

  late AppLocalizations l10n;

  setUp(() {
    gameBloc = MockGameBloc();
    when(() => gameBloc.state).thenReturn(const GameState());

    l10n = MockAppLocalizations();
    when(() => l10n.score).thenReturn('score');
  });

  final flameTester = FlameTester<VeryGoodRanchGame>(
    () => VeryGoodRanchGame(
      gameBloc: gameBloc,
      inventoryBloc: MockInventoryBloc(),
      l10n: l10n,
    ),
  );

  group('ScoreIndicator', () {
    flameTester.testGameWidget(
      'shows score correctly',
      setUp: (game, tester) async {
        await game.toBeLoaded();
      },
      verify: (game, tester) async {
        verify(() => l10n.score).called(1);
      },
    );
  });
}
