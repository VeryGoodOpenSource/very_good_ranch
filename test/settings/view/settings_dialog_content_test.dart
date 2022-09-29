import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:very_good_ranch/dialog/dialog.dart';
import 'package:very_good_ranch/dialog/view/settings_dialog_page.dart';
import 'package:very_good_ranch/l10n/l10n.dart';

import '../../helpers/helpers.dart';

void main() {
  group('SettingsDialogPage', () {
    late SettingsBloc settingsBloc;

    setUp(() {
      settingsBloc = MockSettingsBloc();
      when(() => settingsBloc.state).thenReturn(const SettingsState());
    });

    testWidgets('renders correctly', (tester) async {
      final l10n = await AppLocalizations.delegate.load(const Locale('en'));
      await tester.pumpApp(
        const SettingsDialogPage(),
        settingsBloc: settingsBloc,
      );

      expect(find.byType(ElevatedButton), findsNWidgets(2));
      expect(find.byType(Slider), findsNWidgets(1));
      expect(find.text(l10n.settings), findsOneWidget);
      expect(find.text(l10n.musicVolume(100)), findsOneWidget);
    });

    testWidgets('updates music volume correctly', (tester) async {
      await tester.pumpApp(
        const SettingsDialogPage(),
        settingsBloc: settingsBloc,
      );

      await tester.tap(find.byType(Slider));

      verify(() => settingsBloc.add(const MusicVolumeChanged(0.5))).called(1);
    });

    testWidgets('on tap help', (tester) async {
      final l10n = await AppLocalizations.delegate.load(const Locale('en'));
      final navigator = MockNavigator();
      when(() => navigator.pushReplacementNamed<void, void>(any()))
          .thenAnswer((_) async {});

      await tester.pumpApp(
        const SettingsDialogPage(),
        settingsBloc: settingsBloc,
        navigator: navigator,
      );

      await Scrollable.ensureVisible(find.text(l10n.help).evaluate().first);

      await tester.tap(find.text(l10n.help));

      verify(() =>
              navigator.pushReplacementNamed<void, void>(instructionsRoute))
          .called(1);
    });

    testWidgets('on tap credits', (tester) async {
      final l10n = await AppLocalizations.delegate.load(const Locale('en'));
      final navigator = MockNavigator();
      when(() => navigator.pushReplacementNamed<void, void>(any()))
          .thenAnswer((_) async {});

      await tester.pumpApp(
        const SettingsDialogPage(),
        settingsBloc: settingsBloc,
        navigator: navigator,
      );

      await Scrollable.ensureVisible(find.text(l10n.credits).evaluate().first);

      await tester.tap(find.text(l10n.credits));

      verify(() => navigator.pushReplacementNamed<void, void>(creditsRoute))
          .called(1);
    });
  });
}
