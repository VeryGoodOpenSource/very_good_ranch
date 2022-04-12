import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_ranch/game/game.dart';
import 'package:very_good_ranch/l10n/l10n.dart';

import '../../helpers/pump_app.dart';

void main() {
  group('HeaderWidget', () {
    testWidgets('renders correctly', (tester) async {
      final l10n = await AppLocalizations.delegate.load(const Locale('en'));
      await tester.pumpApp(const Scaffold(body: HeaderWidget()));

      expect(find.byType(Text), findsOneWidget);
      expect(find.text(l10n.gameTitle), findsOneWidget);
    });
  });
}
