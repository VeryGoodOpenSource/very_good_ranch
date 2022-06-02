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

import 'package:very_good_ranch/game/game.dart';
import 'package:very_good_ranch/inventory/inventory.dart';
import 'package:very_good_ranch/settings/settings.dart';

import '../../helpers/helpers.dart';

void main() {
  group('GamePage', () {
    late GameBloc gameBloc;

    setUp(() {
      gameBloc = MockGameBloc();
      when(() => gameBloc.state).thenReturn(GameState());
    });

    testWidgets('renders GameView', (tester) async {
      await tester.pumpApp(GamePage(), gameBloc: gameBloc);
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
  });
}
