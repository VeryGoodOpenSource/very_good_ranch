import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ranch_ui/ranch_ui.dart';
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

      expect(find.byType(UnicornCounter), findsNWidgets(4));
      expect(find.byType(GestureDetector), findsOneWidget);
    });

    group('open overlay', () {
      testWidgets('activates inventory overlay', (tester) async {
        await tester.pumpApp(Scaffold(body: FooterWidget(game: game)));

        await tester.tap(find.byType(GestureDetector));

        expect(game.overlays.isActive(InventoryDialog.overlayKey), isTrue);
      });

      testWidgets(
        'removes any overlay when inventory is opened',
        (tester) async {
          game.overlays.add(SettingsDialog.overlayKey);
          await tester.pumpApp(
            Scaffold(body: FooterWidget(game: game)),
          );

          await tester.tap(find.byType(GestureDetector));

          expect(game.overlays.isActive(SettingsDialog.overlayKey), isFalse);
          expect(game.overlays.isActive(InventoryDialog.overlayKey), isTrue);
        },
      );
    });
  });
}
