// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:ui';

import 'package:flutter/widgets.dart' hide Image;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ranch_flame/ranch_flame.dart';
import 'package:ranch_sounds/ranch_sounds.dart';
import 'package:ranch_ui/ranch_ui.dart';
import 'package:very_good_ranch/gen/assets.gen.dart';
import 'package:very_good_ranch/loading/loading.dart';

import '../../helpers/helpers.dart';

class MockUnprefixedImages extends Mock implements UnprefixedImages {}

class MockRanchSoundPlayer extends Mock implements RanchSoundPlayer {}

void main() {
  group('LoadingPage', () {
    late PreloadCubit preloadCubit;
    late MockUnprefixedImages images;
    late MockRanchSoundPlayer sounds;

    setUp(() {
      preloadCubit = PreloadCubit(
        images = MockUnprefixedImages(),
        sounds = MockRanchSoundPlayer(),
      );

      when(
        () => images.loadAll(any()),
      ).thenAnswer((Invocation invocation) => Future.value(<Image>[]));

      when(sounds.preloadAssets).thenAnswer((Invocation invocation) async {});
      when(() => sounds.play(RanchSound.startBackground))
          .thenAnswer((Invocation invocation) async {});
      when(() => sounds.stop(RanchSound.startBackground))
          .thenAnswer((Invocation invocation) async {});
    });

    testWidgets('basic layout', (tester) async {
      await tester.pumpApp(
        LoadingPage(),
        preloadCubit: preloadCubit,
      );

      expect(
        find.image(AssetImage(Assets.images.loading.keyName)),
        findsOneWidget,
      );

      expect(find.byType(AnimatedProgressBar), findsOneWidget);
      expect(find.textContaining('Loading'), findsOneWidget);

      await tester.pumpAndSettle(Duration(seconds: 1));
    });

    testWidgets('loading text', (tester) async {
      Text textWidgetFinder() {
        return find.textContaining('Loading').evaluate().first.widget as Text;
      }

      await tester.pumpApp(
        LoadingPage(),
        preloadCubit: preloadCubit,
      );

      expect(textWidgetFinder().data, 'Loading  ...');

      unawaited(preloadCubit.loadSequentially());

      await tester.pump();

      expect(textWidgetFinder().data, 'Loading Delightful music...');
      await tester.pump(const Duration(milliseconds: 200));

      expect(textWidgetFinder().data, 'Loading Farmhouse...');
      await tester.pump(const Duration(milliseconds: 200));

      expect(textWidgetFinder().data, 'Loading Snacks...');
      await tester.pump(const Duration(milliseconds: 200));

      expect(textWidgetFinder().data, 'Loading Unicorns...');
      await tester.pump(const Duration(milliseconds: 200));

      /// flush animation timers
      await tester.pumpAndSettle();
    });

    testWidgets('redirects after loading', (tester) async {});
  });
}
