import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:very_good_ranch/dialog/dialog.dart';
import 'package:very_good_ranch/dialog/view/credits_dialog_page.dart';
import 'package:very_good_ranch/l10n/l10n.dart';

import '../../helpers/helpers.dart';

void main() {
  group('CreditsDialogPage', () {
    testWidgets('renders correctly', (tester) async {
      final l10n = await AppLocalizations.delegate.load(const Locale('en'));
      await tester.pumpApp(
        const CreditsDialogPage(),
      );

      expect(find.text(l10n.credits), findsOneWidget);
      expect(find.byType(ElevatedButton), findsNWidgets(1));
      expect(find.text(l10n.ok), findsNWidgets(1));
    });

    group('Action button', () {
      testWidgets('Pressing ok goes back to settings', (tester) async {
        final l10n = await AppLocalizations.delegate.load(const Locale('en'));
        final navigator = MockNavigator();
        when(() => navigator.pushReplacementNamed<void, void>(any()))
            .thenAnswer((_) async {});

        await tester.pumpApp(
          const CreditsDialogPage(),
          navigator: navigator,
        );

        await Scrollable.ensureVisible(find.text(l10n.ok).evaluate().first);

        await tester.tap(find.text(l10n.ok));

        verify(() => navigator.pushReplacementNamed<void, void>(settingsRoute))
            .called(1);
      });
    });
  });
}
