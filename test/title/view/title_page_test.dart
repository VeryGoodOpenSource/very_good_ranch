// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:very_good_ranch/credits/credits.dart';
import 'package:very_good_ranch/l10n/l10n.dart';
import 'package:very_good_ranch/settings/settings.dart';
import 'package:very_good_ranch/title/title.dart';

import '../../helpers/helpers.dart';

void main() {
  group('TitlePage', () {
    testWidgets('renders correctly', (tester) async {
      final l10n = await AppLocalizations.delegate.load(Locale('en'));
      await tester.pumpApp(TitlePage());

      expect(find.byType(ElevatedButton), findsNWidgets(3));
      expect(find.text(l10n.play), findsOneWidget);
      expect(find.text(l10n.credits), findsOneWidget);
      expect(find.text(l10n.settings), findsOneWidget);
    });

    testWidgets('tapping on play button navigates to GamePage', (tester) async {
      final l10n = await AppLocalizations.delegate.load(Locale('en'));
      final navigator = MockNavigator();
      when(() => navigator.pushReplacement<void, void>(any()))
          .thenAnswer((_) async {});

      await tester.pumpApp(
        TitlePage(),
        navigator: navigator,
      );

      await tester.tap(find.widgetWithText(ElevatedButton, l10n.play));

      verify(() => navigator.pushReplacement<void, void>(any())).called(1);
    });

    testWidgets('tapping on credits button displays dialog with CreditsDialog',
        (tester) async {
      final l10n = await AppLocalizations.delegate.load(Locale('en'));
      await tester.pumpApp(TitlePage());

      await tester.tap(find.widgetWithText(ElevatedButton, l10n.credits));
      await tester.pump();

      expect(find.byType(CreditsDialog), findsOneWidget);
    });

    testWidgets(
        'tapping on settings button displays dialog with SettingsDialog',
        (tester) async {
      final settingsBloc = MockSettingsBloc();

      whenListen(
        settingsBloc,
        const Stream<SettingsState>.empty(),
        initialState: SettingsState(),
      );

      final l10n = await AppLocalizations.delegate.load(Locale('en'));
      await tester.pumpApp(TitlePage(), settingsBloc: settingsBloc);

      await tester.tap(find.widgetWithText(ElevatedButton, l10n.settings));
      await tester.pump();

      expect(find.byType(SettingsDialog), findsOneWidget);
    });
  });
}
