// ignore_for_file: cascade_invocations

// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:math';

import 'package:flame/game.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_ranch/game/game.dart';

import '../helpers/helpers.dart';

void main() {
  late Random seed;
  late GameBloc gameBloc;

  setUp(() {
    seed = MockRandom();
    when(() => seed.nextDouble()).thenReturn(0);
    when(() => seed.nextBool()).thenReturn(false);

    gameBloc = MockGameBloc();
    when(() => gameBloc.state).thenReturn(const GameState());
  });

  final flameTester = FlameTester<VeryGoodRanchGame>(
    () => VeryGoodRanchGame(
      seed: seed,
      gameBloc: gameBloc,
      inventoryBloc: MockInventoryBloc(),
    ),
    createGameWidget: (game) {
      return GameWidget(
        game: game,
        overlayBuilderMap: {
          'test': (game, context) => const Text('test overlay'),
        },
      );
    },
  );

  group('VeryGoodRanchGame', () {
    test('can be instantiated', () {
      expect(
        VeryGoodRanchGame(
          gameBloc: gameBloc,
          inventoryBloc: MockInventoryBloc(),
        ),
        isA<VeryGoodRanchGame>(),
      );
    });

    flameTester.testGameWidget(
      'clears all overlays if any is set',
      setUp: (game, tester) async {
        await game.ready();
        game.overlays.add('test');
        await tester.pump();

        expect(game.overlays.isActive('test'), true);

        await tester.tap(find.byType(GameWidget<VeryGoodRanchGame>));
        await tester.pump();

        expect(game.overlays.isActive('test'), false);
      },
    );
  });
}
