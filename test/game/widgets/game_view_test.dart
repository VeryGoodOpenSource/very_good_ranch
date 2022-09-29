import 'package:bloc_test/bloc_test.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart' hide Dialog;
import 'package:flutter_test/flutter_test.dart';
import 'package:ranch_ui/ranch_ui.dart';
import 'package:very_good_ranch/dialog/dialog.dart';
import 'package:very_good_ranch/game/game.dart';
import 'package:very_good_ranch/l10n/l10n.dart';

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

        expect(testGame.paused, isFalse);

        await tester.tap(find.byType(IconButton));
        await tester.pump();

        expect(testGame.paused, isTrue);
        expect(find.byType(Dialog), findsOneWidget);

        await tester.tap(find.byType(ModalCloseButton));
        await tester.pump();

        expect(testGame.paused, isFalse);
      });
    });
  });
}
