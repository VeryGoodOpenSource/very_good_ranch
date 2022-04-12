import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_ranch/game/game.dart';
import 'package:very_good_ranch/settings/view/settings_dialog.dart';

import '../../helpers/pump_app.dart';

void main() {
  group('FooterWidget', () {
    late ActiveOverlaysNotifier overlays;

    setUp(() {
      overlays = ActiveOverlaysNotifier();
    });

    testWidgets('renders correctly', (tester) async {
      await tester.pumpApp(Scaffold(body: FooterWidget(overlays: overlays)));

      expect(find.byType(IconButton), findsNWidgets(2));
      expect(find.byIcon(Icons.inventory), findsOneWidget);
      expect(find.byIcon(Icons.settings), findsOneWidget);
    });

    testWidgets('activates settings overlay', (tester) async {
      await tester.pumpApp(Scaffold(body: FooterWidget(overlays: overlays)));

      await tester.tap(find.byIcon(Icons.settings));
      await tester.pump();

      expect(overlays.isActive(SettingsDialog.overlayKey), isTrue);
    });
  });
}