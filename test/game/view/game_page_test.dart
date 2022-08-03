// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:ranch_flame/ranch_flame.dart';
import 'package:ranch_sounds/ranch_sounds.dart';
import 'package:very_good_ranch/game/game.dart';
import 'package:very_good_ranch/inventory/inventory.dart';
import 'package:very_good_ranch/loading/loading.dart';
import 'package:very_good_ranch/settings/settings.dart';

import '../../helpers/helpers.dart';

class MockRanchSoundPlayer extends Mock implements RanchSoundPlayer {}

void main() {
  group('GamePage', () {
    late GameBloc gameBloc;
    late PreloadCubit preloadCubit;
    late MockRanchSoundPlayer sounds;

    setUp(() {
      gameBloc = MockGameBloc();
      when(() => gameBloc.state).thenReturn(GameState());

      preloadCubit = MockPreloadCubit();
      when(() => preloadCubit.images).thenReturn(UnprefixedImages());

      when(() => preloadCubit.sounds)
          .thenReturn(sounds = MockRanchSoundPlayer());
      when(sounds.preloadAssets).thenAnswer((Invocation invocation) async {});
      when(() => sounds.play(RanchSounds.gameBackground))
          .thenAnswer((Invocation invocation) async {});
      when(() => sounds.stop(RanchSounds.gameBackground))
          .thenAnswer((Invocation invocation) async {});
    });

    testWidgets('renders GameView', (tester) async {
      await tester.pumpApp(
        GamePage(),
        gameBloc: gameBloc,
        preloadCubit: preloadCubit,
      );
      expect(find.byType(GameView), findsOneWidget);
    });

    testWidgets('route returns a valid navigation route', (tester) async {
      await tester.pumpApp(
        Scaffold(
          body: Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push<void>(GamePage.route());
                },
                child: Text('Tap me'),
              );
            },
          ),
        ),
        gameBloc: gameBloc,
        preloadCubit: preloadCubit,
      );

      await tester.tap(find.text('Tap me'));
      await tester.pump();
      await tester.pump();

      expect(find.byType(GamePage), findsOneWidget);
    });

    testWidgets('overlays SettingsDialog', (tester) async {
      await tester.runAsync(() async {
        final settingsBloc = MockSettingsBloc();
        when(() => settingsBloc.state).thenReturn(SettingsState());
        final game = TestGame();

        await tester.pumpApp(
          GamePage(game: game),
          gameBloc: gameBloc,
          settingsBloc: settingsBloc,
          preloadCubit: preloadCubit,
        );

        // These three lines of code is needed to ensure that the game is
        // attached to the GameRenderBox.
        game.pauseEngine();
        await tester.pumpAndSettle();
        game.resumeEngine();

        await tester.tap(find.byIcon(Icons.settings));
        await tester.pump();

        expect(find.byType(SettingsDialog), findsOneWidget);
      });
    });

    testWidgets('overlays InventoryDialog', (tester) async {
      final inventoryBloc = MockInventoryBloc();
      when(() => inventoryBloc.state).thenReturn(InventoryState());
      final game = TestGame();

      await tester.pumpApp(
        GamePage(game: game),
        gameBloc: gameBloc,
        inventoryBloc: inventoryBloc,
        preloadCubit: preloadCubit,
      );

      // These three lines of code is needed to ensure that the game is
      // attached to the GameRenderBox.
      game.pauseEngine();
      await tester.pumpAndSettle();
      game.resumeEngine();

      await tester.tap(find.byIcon(Icons.inventory));
      await tester.pump();

      expect(find.byType(InventoryDialog), findsOneWidget);
    });

    testWidgets('Passes preloaded images', (tester) async {
      final images = UnprefixedImages();
      when(() => preloadCubit.images).thenReturn(images);
      await tester.pumpApp(
        GamePage(),
        gameBloc: gameBloc,
        preloadCubit: preloadCubit,
      );
      final gameView =
          find.byType(GameView).evaluate().first.widget as GameView;
      expect(gameView.game.images, images);
    });
  });
}
