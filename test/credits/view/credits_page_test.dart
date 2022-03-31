// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_ranch/credits/credits.dart';
import 'package:very_good_ranch/l10n/l10n.dart';

import '../../helpers/helpers.dart';

void main() {
  group('CreditsPage', () {
    testWidgets('renders correctly', (tester) async {
      final l10n = await AppLocalizations.delegate.load(Locale('en'));
      await tester.pumpApp(CreditsPage());

      expect(find.byType(Text), findsOneWidget);
      expect(find.text(l10n.credits), findsOneWidget);
    });
  });
}
