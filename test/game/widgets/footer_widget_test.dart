import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:ranch_ui/ranch_ui.dart';
import 'package:very_good_ranch/game/game.dart';

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

      game.overlays.addEntry(
        'settings',
        (context, game) => const SizedBox.shrink(),
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
    });
  });
}
