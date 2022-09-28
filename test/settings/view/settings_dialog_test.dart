// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:very_good_ranch/l10n/l10n.dart';
import 'package:very_good_ranch/settings/settings.dart';

import '../../helpers/helpers.dart';

void main() {
  group('SettingsDialog', () {
    late SettingsBloc settingsBloc;

    setUp(() {
      settingsBloc = MockSettingsBloc();
      when(() => settingsBloc.state).thenReturn(SettingsState());
    });

    testWidgets('renders correctly', (tester) async {
      final l10n = await AppLocalizations.delegate.load(Locale('en'));
      await tester.pumpApp(
        SettingsDialog(
          onTapCredits: () {},
          onTapHelp: () {},
        ),
        settingsBloc: settingsBloc,
      );

      expect(find.byType(ElevatedButton), findsNWidgets(2));
      expect(find.byType(Slider), findsNWidgets(1));
      expect(find.text(l10n.settings), findsOneWidget);
      expect(find.text(l10n.musicVolume(100)), findsOneWidget);
    });

    testWidgets('updates music volume correctly', (tester) async {
      await tester.pumpApp(
        SettingsDialog(
          onTapCredits: () {},
          onTapHelp: () {},
        ),
        settingsBloc: settingsBloc,
      );

      await tester.tap(find.byType(Slider));

      verify(() => settingsBloc.add(const MusicVolumeChanged(0.5))).called(1);
    });

    testWidgets('on tap help', (tester) async {
      final l10n = await AppLocalizations.delegate.load(Locale('en'));

      var wannaHelp = false;
      await tester.pumpApp(
        SettingsDialog(
          onTapCredits: () {},
          onTapHelp: () {
            wannaHelp = true;
          },
        ),
        settingsBloc: settingsBloc,
      );

      await tester.tap(find.text(l10n.help));

      expect(wannaHelp, true);
    });

    testWidgets('on tap credits', (tester) async {
      final l10n = await AppLocalizations.delegate.load(Locale('en'));

      var wannaCredits = false;
      await tester.pumpApp(
        SettingsDialog(
          onTapCredits: () {
            wannaCredits = true;
          },
          onTapHelp: () {},
        ),
        settingsBloc: settingsBloc,
      );

      await tester.tap(find.text(l10n.credits));

      expect(wannaCredits, true);
    });

    group('open', () {
      testWidgets('using open emthod opens settings dialog', (tester) async {
        final l10n = await AppLocalizations.delegate.load(Locale('en'));

        await tester.pumpApp(
          Builder(
            builder: (context) {
              return Center(
                child: ElevatedButton(
                  child: Text('Tap me daddy'),
                  onPressed: () {
                    SettingsDialog.open(context);
                  },
                ),
              );
            },
          ),
          settingsBloc: settingsBloc,
        );

        await tester.tap(find.byType(ElevatedButton));
        await tester.pump();

        expect(find.byType(SettingsDialog), findsOneWidget);

        // nothing happens when tapping these buttons, for now
        await tester.tap(find.text(l10n.credits));
        await tester.tap(find.text(l10n.help));
        expect(true, true);
      });
    });
  });
}
