import 'package:flutter/material.dart' hide Dialog;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:very_good_ranch/dialog/dialog.dart';
import 'package:very_good_ranch/dialog/view/credits_dialog_page.dart';
import 'package:very_good_ranch/dialog/view/instructions_dialog_page.dart';
import 'package:very_good_ranch/dialog/view/settings_dialog_page.dart';
import 'package:very_good_ranch/l10n/l10n.dart';

import '../../helpers/helpers.dart';

void main() {
  late SettingsBloc settingsBloc;

  setUp(() {
    settingsBloc = MockSettingsBloc();
    when(() => settingsBloc.state).thenReturn(const SettingsState());
  });

  group('open', () {
    testWidgets('using open method opens settings dialog ', (tester) async {
      await AppLocalizations.delegate.load(const Locale('en'));

      await tester.pumpApp(
        Builder(
          builder: (context) {
            return Center(
              child: ElevatedButton(
                child: const Text('Tap me'),
                onPressed: () {
                  Dialog.open(context);
                },
              ),
            );
          },
        ),
        settingsBloc: settingsBloc,
      );

      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      expect(find.byType(SettingsDialogPage), findsOneWidget);
    });

    testWidgets('using open method opens instructions dialog', (tester) async {
      await AppLocalizations.delegate.load(const Locale('en'));

      await tester.pumpApp(
        Builder(
          builder: (context) {
            return Center(
              child: ElevatedButton(
                child: const Text('Tap me'),
                onPressed: () {
                  Dialog.open(
                    context,
                    initialRoute: instructionsRoute,
                  );
                },
              ),
            );
          },
        ),
      );

      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      expect(find.byType(InstructionsDialogPage), findsOneWidget);
    });

    testWidgets('using open method opens credits dialog', (tester) async {
      await AppLocalizations.delegate.load(const Locale('en'));

      await tester.pumpApp(
        Builder(
          builder: (context) {
            return Center(
              child: ElevatedButton(
                child: const Text('Tap me'),
                onPressed: () {
                  Dialog.open(
                    context,
                    initialRoute: creditsRoute,
                  );
                },
              ),
            );
          },
        ),
      );

      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      expect(find.byType(CreditsDialogPage), findsOneWidget);
    });
  });
}
