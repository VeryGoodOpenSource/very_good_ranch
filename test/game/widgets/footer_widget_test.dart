import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_ranch/game/game.dart';
import 'package:very_good_ranch/inventory/inventory.dart';
import 'package:very_good_ranch/settings/settings.dart';

import '../../helpers/pump_app.dart';

void main() {
  group('FooterWidget', () {
    late FlameGame game;

    setUp(() {
      game = FlameGame();
    });

    testWidgets('renders correctly', (tester) async {
      await tester.pumpApp(Scaffold(body: FooterWidget(game: game)));

      expect(find.byType(IconButton), findsNWidgets(2));
      expect(find.byIcon(Icons.inventory), findsOneWidget);
      expect(find.byIcon(Icons.settings), findsOneWidget);
    });

    group('open settings', () {
      testWidgets('activates settings overlay', (tester) async {
        await tester.pumpApp(Scaffold(body: FooterWidget(game: game)));

        await tester.tap(find.byIcon(Icons.settings));

        expect(game.overlays.isActive(SettingsDialog.overlayKey), true);
      });

      testWidgets('activates inventory overlay', (tester) async {
        await tester.pumpApp(Scaffold(body: FooterWidget(game: game)));

        await tester.tap(find.byIcon(Icons.inventory));

        expect(game.overlays.isActive(InventoryDialog.overlayKey), isTrue);
      });

      testWidgets(
        'removes inventory overlay when settings is opened',
        (tester) async {
          game.overlays.add(InventoryDialog.overlayKey);
          await tester.pumpApp(
            Scaffold(body: FooterWidget(game: game)),
          );

          await tester.tap(find.byIcon(Icons.settings));

          expect(game.overlays.isActive(InventoryDialog.overlayKey), false);
          expect(game.overlays.isActive(SettingsDialog.overlayKey), true);
        },
      );

      testWidgets(
        'removes settings overlay when inventory is opened',
        (tester) async {
          game.overlays.add(SettingsDialog.overlayKey);
          await tester.pumpApp(
            Scaffold(body: FooterWidget(game: game)),
          );

          await tester.tap(find.byIcon(Icons.inventory));

          expect(game.overlays.isActive(SettingsDialog.overlayKey), isFalse);
          expect(game.overlays.isActive(InventoryDialog.overlayKey), isTrue);
        },
      );
    });
  });
}
