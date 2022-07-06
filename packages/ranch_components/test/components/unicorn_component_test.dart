// ignore_for_file: cascade_invocations

import 'package:flame/cache.dart';
import 'package:flame/components.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ranch_components/ranch_components.dart';

import '../helpers/helpers.dart';

late AssetImage pans;

class MockUnicornAnimationData extends Mock implements UnicornAnimationData {}

class MockImages extends Mock implements Images {}

class MockSpriteAnimations extends Mock implements SpriteAnimation {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final flameTester = FlameTester(TestGame.new);

  setUpAll(() {
    registerFallbackValue(MockImages());
  });

  group('UnicornSpriteComponent', () {
    flameTester.test(
      'loads correctly',
      (game) async {
        final animationData = MockUnicornAnimationData();
        when(
          () => animationData.createAnimation(
            images: any(named: 'images'),
            duration: any(named: 'duration'),
            loop: any(named: 'loop'),
          ),
        ).thenAnswer(
          (invocation) => Future.value(MockSpriteAnimations()),
        );

        final unicorn = UnicornSpriteComponent(
          eatAnimationData: animationData,
          idleAnimationData: animationData,
          pettedAnimationData: animationData,
          walkAnimationData: animationData,
        );

        await game.ready();
        await game.ensureAdd(unicorn);

        expect(unicorn.current, UnicornState.idle);
        expect(game.contains(unicorn), isTrue);
      },
    );

    flameTester.test(
      'sets up each animation',
      (game) async {
        final eatAnimationData = MockUnicornAnimationData();
        final eatAnimation = MockSpriteAnimations();
        when(
          () => eatAnimationData.createAnimation(
            images: any(named: 'images'),
            duration: any(named: 'duration'),
            loop: any(named: 'loop'),
          ),
        ).thenAnswer(
          (invocation) => Future.value(eatAnimation),
        );

        final idleAnimationData = MockUnicornAnimationData();
        final idleAnimation = MockSpriteAnimations();
        when(
          () => idleAnimationData.createAnimation(
            images: any(named: 'images'),
            duration: any(named: 'duration'),
            loop: any(named: 'loop'),
          ),
        ).thenAnswer(
          (invocation) => Future.value(idleAnimation),
        );

        final pettedAnimationData = MockUnicornAnimationData();
        final pettedAnimation = MockSpriteAnimations();
        when(
          () => pettedAnimationData.createAnimation(
            images: any(named: 'images'),
            duration: any(named: 'duration'),
            loop: any(named: 'loop'),
          ),
        ).thenAnswer(
          (invocation) => Future.value(pettedAnimation),
        );

        final walkAnimationData = MockUnicornAnimationData();
        final walkAnimation = MockSpriteAnimations();
        when(
          () => walkAnimationData.createAnimation(
            images: any(named: 'images'),
            duration: any(named: 'duration'),
            loop: any(named: 'loop'),
          ),
        ).thenAnswer(
          (invocation) => Future.value(walkAnimation),
        );

        final unicorn = UnicornSpriteComponent(
          eatAnimationData: eatAnimationData,
          idleAnimationData: idleAnimationData,
          pettedAnimationData: pettedAnimationData,
          walkAnimationData: walkAnimationData,
        );

        await game.ready();
        await game.ensureAdd(unicorn);

        expect(
          unicorn.animations,
          <UnicornState, SpriteAnimation>{
            UnicornState.eating: eatAnimation,
            UnicornState.idle: idleAnimation,
            UnicornState.petted: pettedAnimation,
            UnicornState.walking: walkAnimation,
          },
        );
      },
    );
  });

  group('UnicornComponent', () {});

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
        for (var i = 0.0, index = 0;
            i <= UnicornSpriteComponent.idleAniationDuration;
            i += 0.3, index++) {
          game.update(0.3);
          await tester.pump();

          await expectLater(
            find.byGame<TestGame>(),
            matchesGoldenFile(
              'golden/baby_unicorn_component/idle/frame_$index.png',
            ),
          );
        }
      },
    );

    flameTester.testGameWidget(
      'eat animation',
      setUp: (game, tester) async {
        final unicorn = BabyUnicornComponent();
        unicorn.state = UnicornState.eating;

        await game.ensureAdd(
          PositionComponent(
            position: Vector2(150, 150),
            children: [unicorn],
          ),
        );
      },
      verify: (game, tester) async {
        for (var i = 0.0, index = 0;
            i <= UnicornSpriteComponent.eatAnimationDuration;
            i += 0.3, index++) {
          game.update(0.3);
          await tester.pump();

          await expectLater(
            find.byGame<TestGame>(),
            matchesGoldenFile(
              'golden/baby_unicorn_component/eat/frame_$index.png',
            ),
          );
        }
      },
    );

    flameTester.testGameWidget(
      'petted animation',
      setUp: (game, tester) async {
        final unicorn = BabyUnicornComponent();
        unicorn.state = UnicornState.petted;

        await game.ensureAdd(
          PositionComponent(
            position: Vector2(150, 150),
            children: [unicorn],
          ),
        );
      },
      verify: (game, tester) async {
        for (var i = 0.0, index = 0;
            i <= UnicornSpriteComponent.pettedAnimationDuration;
            i += 0.3, index++) {
          game.update(0.3);
          await tester.pump();

          await expectLater(
            find.byGame<TestGame>(),
            matchesGoldenFile(
              'golden/baby_unicorn_component/petted/frame_$index.png',
            ),
          );
        }
      },
    );

    flameTester.testGameWidget(
      'walking animation',
      setUp: (game, tester) async {
        final unicorn = BabyUnicornComponent();
        unicorn.state = UnicornState.walking;

        await game.ensureAdd(
          PositionComponent(
            position: Vector2(150, 150),
            children: [unicorn],
          ),
        );
      },
      verify: (game, tester) async {
        for (var i = 0.0, index = 0;
            i <= UnicornSpriteComponent.walkAnimationDuration;
            i += 0.3, index++) {
          game.update(0.3);
          await tester.pump();

          await expectLater(
            find.byGame<TestGame>(),
            matchesGoldenFile(
              'golden/baby_unicorn_component/walking/frame_$index.png',
            ),
          );
        }
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
        for (var i = 0.0, index = 0;
            i <= UnicornSpriteComponent.idleAniationDuration;
            i += 0.3, index++) {
          game.update(0.3);
          await tester.pump();
          await expectLater(
            find.byGame<TestGame>(),
            matchesGoldenFile(
              'golden/child_unicorn_component/idle/frame_$index.png',
            ),
          );
        }
      },
    );

    flameTester.testGameWidget(
      'eat animation',
      setUp: (game, tester) async {
        final unicorn = ChildUnicornComponent();
        unicorn.state = UnicornState.eating;

        await game.ensureAdd(
          PositionComponent(
            position: Vector2(150, 150),
            children: [unicorn],
          ),
        );
      },
      verify: (game, tester) async {
        for (var i = 0.0, index = 0;
            i <= UnicornSpriteComponent.eatAnimationDuration;
            i += 0.3, index++) {
          game.update(0.3);
          await tester.pump();

          await expectLater(
            find.byGame<TestGame>(),
            matchesGoldenFile(
              'golden/child_unicorn_component/eat/frame_$index.png',
            ),
          );
        }
      },
    );

    flameTester.testGameWidget(
      'petted animation',
      setUp: (game, tester) async {
        final unicorn = ChildUnicornComponent();
        unicorn.state = UnicornState.petted;

        await game.ensureAdd(
          PositionComponent(
            position: Vector2(150, 150),
            children: [unicorn],
          ),
        );
      },
      verify: (game, tester) async {
        for (var i = 0.0, index = 0;
            i <= UnicornSpriteComponent.pettedAnimationDuration;
            i += 0.3, index++) {
          game.update(0.3);
          await tester.pump();

          await expectLater(
            find.byGame<TestGame>(),
            matchesGoldenFile(
              'golden/child_unicorn_component/petted/frame_$index.png',
            ),
          );
        }
      },
    );

    flameTester.testGameWidget(
      'walking animation',
      setUp: (game, tester) async {
        final unicorn = ChildUnicornComponent();
        unicorn.state = UnicornState.walking;

        await game.ensureAdd(
          PositionComponent(
            position: Vector2(150, 150),
            children: [unicorn],
          ),
        );
      },
      verify: (game, tester) async {
        for (var i = 0.0, index = 0;
            i <= UnicornSpriteComponent.walkAnimationDuration;
            i += 0.3, index++) {
          game.update(0.3);
          await tester.pump();

          await expectLater(
            find.byGame<TestGame>(),
            matchesGoldenFile(
              'golden/child_unicorn_component/walking/frame_$index.png',
            ),
          );
        }
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
        for (var i = 0.0, index = 0;
            i <= UnicornSpriteComponent.idleAniationDuration;
            i += 0.3, index++) {
          game.update(0.3);
          await tester.pump();

          await expectLater(
            find.byGame<TestGame>(),
            matchesGoldenFile(
              'golden/teen_unicorn_component/idle/frame_$index.png',
            ),
          );
        }
      },
    );

    flameTester.testGameWidget(
      'eat animation',
      setUp: (game, tester) async {
        final unicorn = TeenUnicornComponent();
        unicorn.state = UnicornState.eating;

        await game.ensureAdd(
          PositionComponent(
            position: Vector2(150, 150),
            children: [unicorn],
          ),
        );
      },
      verify: (game, tester) async {
        for (var i = 0.0, index = 0;
            i <= UnicornSpriteComponent.eatAnimationDuration;
            i += 0.3, index++) {
          game.update(0.3);
          await tester.pump();

          await expectLater(
            find.byGame<TestGame>(),
            matchesGoldenFile(
              'golden/teen_unicorn_component/eat/frame_$index.png',
            ),
          );
        }
      },
    );

    flameTester.testGameWidget(
      'petted animation',
      setUp: (game, tester) async {
        final unicorn = TeenUnicornComponent();
        unicorn.state = UnicornState.petted;

        await game.ensureAdd(
          PositionComponent(
            position: Vector2(150, 150),
            children: [unicorn],
          ),
        );
      },
      verify: (game, tester) async {
        for (var i = 0.0, index = 0;
            i <= UnicornSpriteComponent.pettedAnimationDuration;
            i += 0.3, index++) {
          game.update(0.3);
          await tester.pump();

          await expectLater(
            find.byGame<TestGame>(),
            matchesGoldenFile(
              'golden/teen_unicorn_component/petted/frame_$index.png',
            ),
          );
        }
      },
    );

    flameTester.testGameWidget(
      'walking animation',
      setUp: (game, tester) async {
        final unicorn = TeenUnicornComponent();
        unicorn.state = UnicornState.walking;

        await game.ensureAdd(
          PositionComponent(
            position: Vector2(150, 150),
            children: [unicorn],
          ),
        );
      },
      verify: (game, tester) async {
        for (var i = 0.0, index = 0;
            i <= UnicornSpriteComponent.walkAnimationDuration;
            i += 0.3, index++) {
          game.update(0.3);
          await tester.pump();

          await expectLater(
            find.byGame<TestGame>(),
            matchesGoldenFile(
              'golden/teen_unicorn_component/walking/frame_$index.png',
            ),
          );
        }
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
        for (var i = 0.0, index = 0;
            i <= UnicornSpriteComponent.idleAniationDuration;
            i += 0.3, index++) {
          game.update(0.3);
          await tester.pump();
          await expectLater(
            find.byGame<TestGame>(),
            matchesGoldenFile(
              'golden/adult_unicorn_component/idle/frame_$index.png',
            ),
          );
        }
      },
    );

    flameTester.testGameWidget(
      'eat animation',
      setUp: (game, tester) async {
        final unicorn = AdultUnicornComponent();
        unicorn.state = UnicornState.eating;

        await game.ensureAdd(
          PositionComponent(
            position: Vector2(150, 150),
            children: [unicorn],
          ),
        );
      },
      verify: (game, tester) async {
        for (var i = 0.0, index = 0;
            i <= UnicornSpriteComponent.eatAnimationDuration;
            i += 0.3, index++) {
          game.update(0.3);
          await tester.pump();

          await expectLater(
            find.byGame<TestGame>(),
            matchesGoldenFile(
              'golden/adult_unicorn_component/eat/frame_$index.png',
            ),
          );
        }
      },
    );

    flameTester.testGameWidget(
      'petted animation',
      setUp: (game, tester) async {
        final unicorn = AdultUnicornComponent();
        unicorn.state = UnicornState.petted;

        await game.ensureAdd(
          PositionComponent(
            position: Vector2(150, 150),
            children: [unicorn],
          ),
        );
      },
      verify: (game, tester) async {
        for (var i = 0.0, index = 0;
            i <= UnicornSpriteComponent.pettedAnimationDuration;
            i += 0.3, index++) {
          game.update(0.3);
          await tester.pump();

          await expectLater(
            find.byGame<TestGame>(),
            matchesGoldenFile(
              'golden/adult_unicorn_component/petted/frame_$index.png',
            ),
          );
        }
      },
    );

    flameTester.testGameWidget(
      'walking animation',
      setUp: (game, tester) async {
        final unicorn = AdultUnicornComponent();
        unicorn.state = UnicornState.walking;

        await game.ensureAdd(
          PositionComponent(
            position: Vector2(150, 150),
            children: [unicorn],
          ),
        );
      },
      verify: (game, tester) async {
        for (var i = 0.0, index = 0;
            i <= UnicornSpriteComponent.walkAnimationDuration;
            i += 0.3, index++) {
          game.update(0.3);
          await tester.pump();

          await expectLater(
            find.byGame<TestGame>(),
            matchesGoldenFile(
              'golden/adult_unicorn_component/walking/frame_$index.png',
            ),
          );
        }
      },
    );
  });
}
