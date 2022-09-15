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
import 'package:ranch_flame/ranch_flame.dart';
import 'package:very_good_ranch/game/game.dart';

import '../helpers/helpers.dart';

void main() {
  late Random seed;
  late BlessingBloc blessingBloc;

  setUp(() {
    seed = MockRandom();
    when(() => seed.nextDouble()).thenReturn(0);
    when(() => seed.nextBool()).thenReturn(false);

    blessingBloc = MockBlessingBloc();
  });

  final flameTester = FlameTester<VeryGoodRanchGame>(
    () => VeryGoodRanchGame(
      seed: seed,
      blessingBloc: blessingBloc,
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
        VeryGoodRanchGame(blessingBloc: blessingBloc),
        isA<VeryGoodRanchGame>(),
      );
    });

    test('can be instantiated with a images instance', () {
      final images = UnprefixedImages();
      expect(
        VeryGoodRanchGame(
          blessingBloc: blessingBloc,
          images: images,
        ).images,
        images,
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

    group('viewport', () {
      group('big square viewport', () {
        final configuredViewportTester = flameTester.configure(
          gameSize: Vector2(4000, 4000),
        );
        configuredViewportTester.test('assumes aspect ratio', (game) {
          expect(game.camera.viewport.effectiveSize, Vector2(680, 680));
        });
      });

      group('narrow portrait viewport', () {
        final configuredViewportTester = flameTester.configure(
          gameSize: Vector2(1000, 4000),
        );
        configuredViewportTester.test('assumes aspect ratio', (game) {
          expect(game.camera.viewport.effectiveSize, Vector2(680, 2720));
        });
      });

      group('narrow portrait viewport', () {
        final configuredViewportTester = flameTester.configure(
          gameSize: Vector2(500, 100),
        );
        configuredViewportTester.test('assumes aspect ratio', (game) {
          expect(game.camera.viewport.effectiveSize, Vector2(680, 136));
        });
      });
    });
  });
}
