import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:very_good_ranch/game_menu/game_menu.dart';
import 'package:very_good_ranch/game_menu/view/credits_dialog_page.dart';
import 'package:very_good_ranch/game_menu/view/instructions_dialog_page.dart';
import 'package:very_good_ranch/game_menu/view/settings_dialog_page.dart';
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
                  GameMenuDialog.open(context);
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
                  GameMenuDialog.open(
                    context,
                    initialRoute: GameMenuRoute.instructions,
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
                  GameMenuDialog.open(
                    context,
                    initialRoute: GameMenuRoute.credits,
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
