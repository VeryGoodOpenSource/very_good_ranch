// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:ranch_flame/ranch_flame.dart';
import 'package:ranch_sounds/ranch_sounds.dart';
import 'package:very_good_ranch/game/game.dart';
import 'package:very_good_ranch/game_menu/game_menu.dart';
import 'package:very_good_ranch/loading/loading.dart';

import '../../helpers/helpers.dart';

class MockRanchSoundPlayer extends Mock implements RanchSoundPlayer {}

void main() {
  group('GamePage', () {
    late BlessingBloc blessingBloc;
    late PreloadCubit preloadCubit;
    late SettingsBloc settingsBloc;
    late MockRanchSoundPlayer sounds;

    setUp(() {
      blessingBloc = MockBlessingBloc();
      when(() => blessingBloc.state).thenReturn(BlessingState.initial());

      settingsBloc = MockSettingsBloc();
      whenListen(
        settingsBloc,
        const Stream<SettingsState>.empty(),
        initialState: SettingsState(),
      );

      preloadCubit = MockPreloadCubit();
      when(() => preloadCubit.images).thenReturn(UnprefixedImages());

      when(() => preloadCubit.sounds)
          .thenReturn(sounds = MockRanchSoundPlayer());
      when(sounds.preloadAssets).thenAnswer((Invocation invocation) async {});
      when(() => sounds.play(RanchSound.sunsetMemory))
          .thenAnswer((Invocation invocation) async {});
      when(() => sounds.stop(RanchSound.sunsetMemory))
          .thenAnswer((Invocation invocation) async {});
    });

    testWidgets('renders GameView', (tester) async {
      await tester.pumpApp(
        GamePage(),
        blessingBloc: blessingBloc,
        preloadCubit: preloadCubit,
        settingsBloc: settingsBloc,
      );
      expect(find.byType(GameView), findsOneWidget);
    });

    testWidgets('route returns a valid navigation route', (tester) async {
      await tester.pumpApp(
        Scaffold(
          body: Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push<void>(GamePage.route());
                },
                child: Text('Tap me'),
              );
            },
          ),
        ),
        preloadCubit: preloadCubit,
        settingsBloc: settingsBloc,
      );

      await tester.tap(find.text('Tap me'));
      await tester.pump();
      await tester.pump();

      expect(find.byType(GamePage), findsOneWidget);
    });

    testWidgets('Passes preloaded images', (tester) async {
      final images = UnprefixedImages();
      when(() => preloadCubit.images).thenReturn(images);
      await tester.pumpApp(
        GamePage(),
        preloadCubit: preloadCubit,
        settingsBloc: settingsBloc,
      );
      final gameView =
          find.byType(GameView).evaluate().first.widget as GameView;
      expect(gameView.game.images, images);
    });
  });
}
