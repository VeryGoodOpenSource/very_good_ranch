import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:very_good_ranch/game_menu/game_menu.dart';
import 'package:very_good_ranch/game_menu/view/credits_dialog_page.dart';
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
      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.text(l10n.ok), findsOneWidget);

      // credits content
      expect(find.text(l10n.gameTitle), findsOneWidget);
      expect(find.text(l10n.byVGV), findsOneWidget);
      expect(find.text(l10n.programming), findsOneWidget);
      expect(find.text(l10n.music), findsOneWidget);
      expect(find.text(l10n.artAndUICredits), findsOneWidget);
      expect(find.text(l10n.librariesCredits), findsOneWidget);
      expect(find.text(l10n.showLicensesPage), findsOneWidget);
      expect(find.text(l10n.noCrueltyDisclaimer), findsOneWidget);
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

        verify(
          () => navigator.pushReplacementNamed<void, void>(
            GameMenuRoute.settings.name,
          ),
        ).called(1);
      });
    });

    group('Licenses button', () {
      testWidgets('Pressing "show licenses" shows licenses', (tester) async {
        final l10n = await AppLocalizations.delegate.load(const Locale('en'));
        final navigator = MockNavigator();
        when(() => navigator.push<void>(any())).thenAnswer((_) async {});

        await tester.pumpApp(
          const CreditsDialogPage(),
          rootNavigator: navigator,
        );

        await Scrollable.ensureVisible(
          find.text(l10n.showLicensesPage).evaluate().first,
        );

        await tester.tap(find.text(l10n.showLicensesPage));

        final captured = verify(
          () => navigator.push<void>(
            captureAny(
              that: isA<MaterialPageRoute<void>>(),
            ),
          ),
        ).captured;

        expect(captured.length, 1);

        final licensesRoute = captured.first as MaterialPageRoute<void>;

        await tester.pumpApp(
          Builder(
            builder: licensesRoute.builder,
          ),
        );

        await tester.pumpAndSettle();

        expect(find.byType(LicensePage), findsOneWidget);
      });
    });
  });
}
