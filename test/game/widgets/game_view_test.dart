import 'package:bloc_test/bloc_test.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_ranch/game/game.dart';
import 'package:very_good_ranch/l10n/l10n.dart';
import 'package:very_good_ranch/settings/settings.dart';

import '../../helpers/helpers.dart';

void main() {
  late TestGame testGame;

  setUp(() {
    testGame = TestGame();
  });

  group('GameView', () {
    testWidgets('renders correctly', (tester) async {
      await tester.pumpApp(
        Scaffold(
          body: GameView(game: testGame),
        ),
      );

      expect(find.byType(GameWidget<TestGame>), findsOneWidget);
      expect(find.byType(IconButton), findsOneWidget);
    });

    group('settings button', () {
      testWidgets('should open the settings dialog', (tester) async {
        final settingsBloc = MockSettingsBloc();

        whenListen(
          settingsBloc,
          const Stream<SettingsState>.empty(),
          initialState: const SettingsState(),
        );

        await AppLocalizations.delegate.load(const Locale('en'));
        await tester.pumpApp(
          settingsBloc: settingsBloc,
          Scaffold(
            body: GameView(game: testGame),
          ),
        );

        await tester.tap(find.byType(IconButton));
        await tester.pump();

        expect(find.byType(SettingsDialog), findsOneWidget);
      });
    });
  });
}
