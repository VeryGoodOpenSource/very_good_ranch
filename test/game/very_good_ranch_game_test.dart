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
import 'package:mockingjay/mockingjay.dart';
import 'package:ranch_components/ranch_components.dart';
import 'package:very_good_ranch/game/game.dart';

class MockRandom extends Mock implements Random {}

void main() {
  late Random seed;

  setUp(() {
    seed = MockRandom();
    when(() => seed.nextInt(any())).thenReturn(0);
    when(seed.nextDouble).thenReturn(0);
    when(seed.nextBool).thenReturn(false);
  });

  final flameTester = FlameTester<VeryGoodRanchGame>(
    () => VeryGoodRanchGame(seed: seed),
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
      expect(VeryGoodRanchGame(), isA<VeryGoodRanchGame>());
    });

    flameTester.testGameWidget(
      'clears all overlays if any is set',
      setUp: (game, tester) async {
        await game.ready();
        game.overlays.add('test');
        await tester.pump();

        expect(find.text('test overlay'), findsOneWidget);

        await tester.tap(find.byType(GameWidget<VeryGoodRanchGame>));
        await tester.pump();

        expect(game.overlays.isActive('test'), false);
      },
    );

    group('spawns a food component every 60 seconds', () {
      flameTester.testGameWidget(
        'spawns a cupcake',
        setUp: (game, tester) async {
          when(() => seed.nextInt(any())).thenReturn(0);

          await game.ready();
          game.update(60);
          await tester.pump();
        },
        verify: (game, tester) async {
          final foodComponents = game.children.whereType<FoodComponent>();
          expect(foodComponents.length, 1);
          expect(foodComponents.first.type, FoodType.cupcake);
        },
      );

      flameTester.testGameWidget(
        'spawns a lolipop',
        setUp: (game, tester) async {
          when(() => seed.nextInt(any())).thenReturn(1);

          await game.ready();
          game.update(60);
          await tester.pump();
        },
        verify: (game, tester) async {
          final foodComponents = game.children.whereType<FoodComponent>();
          expect(foodComponents.length, 1);
          expect(foodComponents.first.type, FoodType.lolipop);
        },
      );

      flameTester.testGameWidget(
        'spawns a pancake',
        setUp: (game, tester) async {
          when(() => seed.nextInt(any())).thenReturn(2);

          await game.ready();
          game.update(60);
          await tester.pump();
        },
        verify: (game, tester) async {
          final foodComponents = game.children.whereType<FoodComponent>();
          expect(foodComponents.length, 1);
          expect(foodComponents.first.type, FoodType.pancake);
        },
      );

      flameTester.testGameWidget(
        'spawns a ice cream',
        setUp: (game, tester) async {
          when(() => seed.nextInt(any())).thenReturn(3);

          await game.ready();
          game.update(60);
          await tester.pump();
        },
        verify: (game, tester) async {
          final foodComponents = game.children.whereType<FoodComponent>();
          expect(foodComponents.length, 1);
          expect(foodComponents.first.type, FoodType.iceCream);
        },
      );

      flameTester.testGameWidget(
        'spawns a candy',
        setUp: (game, tester) async {
          when(() => seed.nextInt(any())).thenReturn(4);

          await game.ready();
          game.update(60);
          await tester.pump();
        },
        verify: (game, tester) async {
          final foodComponents = game.children.whereType<FoodComponent>();
          expect(foodComponents.length, 1);
          expect(foodComponents.first.type, FoodType.candy);
        },
      );
    });
  });
}
