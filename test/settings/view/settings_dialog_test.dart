// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
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
      whenListen(
        settingsBloc,
        const Stream<SettingsState>.empty(),
        initialState: SettingsState(),
      );
    });

    testWidgets('renders correctly', (tester) async {
      final l10n = await AppLocalizations.delegate.load(Locale('en'));
      await tester.pumpApp(SettingsDialog(), settingsBloc: settingsBloc);

      expect(find.byType(Text), findsNWidgets(4));
      expect(find.byType(Slider), findsNWidgets(2));
      expect(find.text(l10n.settings), findsOneWidget);
      expect(find.text(l10n.audioSettings), findsOneWidget);
      expect(find.text(l10n.musicVolume(100)), findsOneWidget);
      expect(find.text(l10n.gameplayVolume(100)), findsOneWidget);
    });

    testWidgets('updates music volume correctly', (tester) async {
      await tester.pumpApp(SettingsDialog(), settingsBloc: settingsBloc);

      await tester.tap(find.byKey(const Key('musicVolumeSlider')));

      verify(() => settingsBloc.add(const MusicVolumeChanged(0.5))).called(1);
    });

    testWidgets('updates gameplay volume correctly', (tester) async {
      await tester.pumpApp(SettingsDialog(), settingsBloc: settingsBloc);

      await tester.tap(find.byKey(const Key('gameplayVolumeSlider')));

      verify(() => settingsBloc.add(const GameplayVolumeChanged(0.5)))
          .called(1);
    });
  });
}
