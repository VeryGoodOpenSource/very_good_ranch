// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

// ignore_for_file: prefer_const_constructors

import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:very_good_ranch/game/game.dart';

import '../../helpers/helpers.dart';

void main() {
  group('GamePage', () {
    testWidgets('renders GameWidget', (tester) async {
      await tester.pumpApp(GamePage());
      expect(find.byType(GameWidget<VeryGoodRanchGame>), findsOneWidget);
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
      );

      await tester.tap(find.text('Tap me'));
      await tester.pump();
      await tester.pump();

      expect(find.byType(GamePage), findsOneWidget);
    });
  });
}
