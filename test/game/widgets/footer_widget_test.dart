import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:ranch_ui/ranch_ui.dart';
import 'package:very_good_ranch/game/game.dart';
import 'package:very_good_ranch/inventory/inventory.dart';
import 'package:very_good_ranch/settings/settings.dart';

import '../../helpers/helpers.dart';

void main() {
  group('FooterWidget', () {
    late FlameGame game;
    late BlessingBloc blessingBloc;

    setUp(() {
      game = FlameGame();

      blessingBloc = MockBlessingBloc();
      when(() => blessingBloc.state).thenReturn(
        BlessingState.zero(babyUnicorns: 1),
      );
    });

    testWidgets('renders correctly', (tester) async {
      await tester.pumpApp(
        blessingBloc: blessingBloc,
        Scaffold(
          body: FooterWidget(game: game),
        ),
      );

      UnicornCounter getUnicownCounter(int at) {
        return find.byType(UnicornCounter).evaluate().elementAt(at).widget
            as UnicornCounter;
      }

      expect(find.byType(UnicornCounter), findsNWidgets(4));

      expect(getUnicownCounter(0).type, UnicornType.baby);
      expect(getUnicownCounter(0).isActive, true);
      expect(getUnicownCounter(1).type, UnicornType.child);
      expect(getUnicownCounter(1).isActive, false);
      expect(getUnicownCounter(2).type, UnicornType.teen);
      expect(getUnicownCounter(2).isActive, false);
      expect(getUnicownCounter(3).type, UnicornType.adult);
      expect(getUnicownCounter(3).isActive, false);

      expect(find.byType(GestureDetector), findsOneWidget);
    });

    group('open overlay', () {
      testWidgets('activates inventory overlay', (tester) async {
        await tester.pumpApp(Scaffold(body: FooterWidget(game: game)));

        await tester.tap(find.byType(GestureDetector));

        expect(game.overlays.isActive(InventoryDialog.overlayKey), isTrue);
      });

      testWidgets(
        'removes any overlay when inventory is opened',
        (tester) async {
          game.overlays.add(SettingsDialog.overlayKey);
          await tester.pumpApp(
            Scaffold(body: FooterWidget(game: game)),
          );

          await tester.tap(find.byType(GestureDetector));

          expect(game.overlays.isActive(SettingsDialog.overlayKey), isFalse);
          expect(game.overlays.isActive(InventoryDialog.overlayKey), isTrue);
        },
      );
    });
  });
}
