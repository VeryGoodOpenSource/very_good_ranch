// ignore_for_file: cascade_invocations

import 'package:flame/components.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ranch_components/gen/assets.gen.dart';
import 'package:ranch_components/ranch_components.dart';

import '../helpers/helpers.dart';

late AssetImage pans;

class _TestUnicornComponent extends UnicornComponent {
  _TestUnicornComponent()
      : super(
          size: Vector2(90, 110.5),
          columns: 1,
          filePath: Assets.images.adultSprite.packagePath,
        );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final flameTester = FlameTester(TestGame.new);

  group('UnicornComponent', () {
    flameTester.test(
      'loads correctly',
      (game) async {
        final unicorn = _TestUnicornComponent();

        await game.ready();
        await game.ensureAdd(unicorn);

        expect(unicorn.current, UnicornState.idle);
        expect(game.contains(unicorn), isTrue);
      },
    );
  });
  group('BabyUnicornComponent', () {
    flameTester.testGameWidget(
      'idle animation',
      setUp: (game, tester) async {
        final unicorn = BabyUnicornComponent();

        await game.ensureAdd(
          PositionComponent(
            position: Vector2(150, 150),
            children: [unicorn],
          ),
        );
      },
      verify: (game, tester) async {
        game.update(.3);
        await tester.pump();

        await expectLater(
          find.byGame<TestGame>(),
          matchesGoldenFile('golden/baby_unicorn_component/idle/frame_0.png'),
        );
      },
    );
  });
  group('ChildUnicornComponent', () {
    flameTester.testGameWidget(
      'idle animation',
      setUp: (game, tester) async {
        final unicorn = ChildUnicornComponent();
        await game.ensureAdd(
          PositionComponent(
            position: Vector2(150, 150),
            children: [unicorn],
          ),
        );
      },
      verify: (game, tester) async {
        game.update(.3);
        await tester.pump();

        await expectLater(
          find.byGame<TestGame>(),
          matchesGoldenFile('golden/child_unicorn_component/idle/frame_0.png'),
        );
      },
    );
  });
  group('TeenUnicornComponent', () {
    flameTester.testGameWidget(
      'idle animation',
      setUp: (game, tester) async {
        final unicorn = TeenUnicornComponent();
        await game.ensureAdd(
          PositionComponent(
            position: Vector2(150, 150),
            children: [unicorn],
          ),
        );
      },
      verify: (game, tester) async {
        game.update(.3);
        await tester.pump();

        await expectLater(
          find.byGame<TestGame>(),
          matchesGoldenFile('golden/teen_unicorn_component/idle/frame_0.png'),
        );
      },
    );
  });
  group('AdultUnicornComponent', () {
    flameTester.testGameWidget(
      'idle animation',
      setUp: (game, tester) async {
        final unicorn = AdultUnicornComponent();
        await game.ensureAdd(
          PositionComponent(
            position: Vector2(150, 150),
            children: [unicorn],
          ),
        );
      },
      verify: (game, tester) async {
        game.update(.3);
        await tester.pump();

        await expectLater(
          find.byGame<TestGame>(),
          matchesGoldenFile('golden/adult_unicorn_component/idle/frame_0.png'),
        );
      },
    );
  });
}
