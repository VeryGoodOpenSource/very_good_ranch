// ignore_for_file: cascade_invocations

import 'dart:ui';

import 'package:flame/cache.dart';
import 'package:flame/components.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ranch_components/gen/assets.gen.dart';
import 'package:ranch_components/ranch_components.dart';

import '../helpers/helpers.dart';

late AssetImage pans;

class MockUnicornAnimationData extends Mock implements UnicornAnimationData {}

class MockImages extends Mock implements Images {}

class MockSpriteAnimation extends Mock implements SpriteAnimation {}

class MockUnicornSpriteComponent extends Mock
    implements UnicornSpriteComponent {}

class TestUnicornComponent extends UnicornComponent {
  TestUnicornComponent({
    required super.spriteComponent,
    required super.spritePadding,
  });
}

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
          (_) async => MockSpriteAnimation(),
        );

        final unicornSpriteComponent = UnicornSpriteComponent(
          eatAnimationData: animationData,
          idleAnimationData: animationData,
          pettedAnimationData: animationData,
          walkAnimationData: animationData,
        );

        await game.ready();
        await game.ensureAdd(
          TestUnicornComponent(
            spriteComponent: unicornSpriteComponent,
            spritePadding: EdgeInsets.zero,
          ),
        );

        expect(unicornSpriteComponent.current, UnicornState.idle);
        expect(game.descendants().contains(unicornSpriteComponent), isTrue);
      },
    );

    flameTester.test(
      'sets up each animation',
      (game) async {
        final eatAnimationData = MockUnicornAnimationData();
        final eatAnimation = MockSpriteAnimation();
        when(
          () => eatAnimationData.createAnimation(
            images: any(named: 'images'),
            duration: any(named: 'duration'),
            loop: any(named: 'loop'),
          ),
        ).thenAnswer(
          (_) async => eatAnimation,
        );

        final idleAnimationData = MockUnicornAnimationData();
        final idleAnimation = MockSpriteAnimation();
        when(
          () => idleAnimationData.createAnimation(
            images: any(named: 'images'),
            duration: any(named: 'duration'),
            loop: any(named: 'loop'),
          ),
        ).thenAnswer(
          (_) async => idleAnimation,
        );

        final pettedAnimationData = MockUnicornAnimationData();
        final pettedAnimation = MockSpriteAnimation();
        when(
          () => pettedAnimationData.createAnimation(
            images: any(named: 'images'),
            duration: any(named: 'duration'),
            loop: any(named: 'loop'),
          ),
        ).thenAnswer(
          (_) async => pettedAnimation,
        );

        final walkAnimationData = MockUnicornAnimationData();
        final walkAnimation = MockSpriteAnimation();
        when(
          () => walkAnimationData.createAnimation(
            images: any(named: 'images'),
            duration: any(named: 'duration'),
            loop: any(named: 'loop'),
          ),
        ).thenAnswer(
          (_) async => walkAnimation,
        );

        final unicornSpriteComponent = UnicornSpriteComponent(
          eatAnimationData: eatAnimationData,
          idleAnimationData: idleAnimationData,
          pettedAnimationData: pettedAnimationData,
          walkAnimationData: walkAnimationData,
        );

        await game.ready();
        await game.ensureAdd(
          TestUnicornComponent(
            spriteComponent: unicornSpriteComponent,
            spritePadding: EdgeInsets.zero,
          ),
        );

        expect(
          unicornSpriteComponent.animations,
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

  group('UnicornComponent', () {
    test('assumes the right size', () {
      final unicornComponent = TestUnicornComponent(
        spriteComponent: MockUnicornSpriteComponent(),
        spritePadding: const EdgeInsets.all(20),
      );

      expect(unicornComponent.size, Vector2(162, 202));
    });

    test('proxies paint to spriteComponent', () {
      final unicornSpriteComponent = UnicornSpriteComponent(
        eatAnimationData: MockUnicornAnimationData(),
        idleAnimationData: MockUnicornAnimationData(),
        pettedAnimationData: MockUnicornAnimationData(),
        walkAnimationData: MockUnicornAnimationData(),
      );
      final unicornComponent = TestUnicornComponent(
        spriteComponent: unicornSpriteComponent,
        spritePadding: EdgeInsets.zero,
      );
      expect(unicornComponent.paint, unicornSpriteComponent.paint);

      final newPaint = Paint();

      unicornComponent.paint = newPaint;
      expect(unicornSpriteComponent.paint, newPaint);
    });

    group('playAnimation', () {
      flameTester.test(
        'defines the correct animation',
        (game) async {
          final animationData = MockUnicornAnimationData();
          final spriteAnimation = MockSpriteAnimation();
          when(
            () => animationData.createAnimation(
              images: any(named: 'images'),
              duration: any(named: 'duration'),
              loop: any(named: 'loop'),
            ),
          ).thenAnswer(
            (_) async => spriteAnimation,
          );

          final unicornComponent = TestUnicornComponent(
            spriteComponent: UnicornSpriteComponent(
              eatAnimationData: animationData,
              idleAnimationData: animationData,
              pettedAnimationData: animationData,
              walkAnimationData: animationData,
            ),
            spritePadding: EdgeInsets.zero,
          );

          await game.ensureAdd(unicornComponent);

          expect(unicornComponent.state, UnicornState.idle);

          unicornComponent.playAnimation(UnicornState.walking);

          expect(unicornComponent.state, UnicornState.walking);
          verify(spriteAnimation.reset).called(1);
        },
      );

      flameTester.test(
        'cancels current post animation callbacks',
        (game) async {
          final unicornComponent = AdultUnicornComponent(
            initialState: UnicornState.walking,
          );

          await game.ensureAdd(unicornComponent);

          expect(unicornComponent.state, UnicornState.walking);

          var called1 = false;
          unicornComponent.addPostAnimationCycleCallback(() => called1 = true);

          unicornComponent.playAnimation(UnicornState.idle);

          game.update(UnicornSpriteComponent.walkAnimationDuration);

          expect(called1, isFalse);
          expect(unicornComponent.state, UnicornState.idle);
        },
      );
    });

    group('addPostAnimationCycleCallback', () {
      flameTester.test(
        'calls after the current animation cycle',
        (game) async {
          final unicornComponent = AdultUnicornComponent(
            initialState: UnicornState.walking,
          );

          await game.ensureAdd(unicornComponent);

          unicornComponent.playAnimation(UnicornState.walking);
          expect(unicornComponent.state, UnicornState.walking);

          var called = false;
          unicornComponent.addPostAnimationCycleCallback(() => called = true);
          expect(called, isFalse);
          game.update(UnicornSpriteComponent.walkAnimationDuration);
          expect(called, isTrue);
        },
      );

      flameTester.test(
        'maintains previous callbacks',
        (game) async {
          final unicornComponent = AdultUnicornComponent(
            initialState: UnicornState.walking,
          );

          await game.ensureAdd(unicornComponent);

          unicornComponent.playAnimation(UnicornState.walking);
          expect(unicornComponent.state, UnicornState.walking);

          var called1 = false;
          unicornComponent.addPostAnimationCycleCallback(() => called1 = true);
          game.update(UnicornSpriteComponent.walkAnimationDuration / 2);

          var called2 = false;
          unicornComponent.addPostAnimationCycleCallback(() {
            unicornComponent.playAnimation(UnicornState.idle);
            called2 = true;
          });

          var called3 = false;
          unicornComponent.addPostAnimationCycleCallback(() => called3 = true);

          expect(called1, isFalse);
          expect(called2, isFalse);
          expect(called3, isFalse);

          game.update(UnicornSpriteComponent.walkAnimationDuration / 2);

          expect(called1, isTrue);
          expect(called2, isTrue);
          expect(called3, isTrue);

          expect(unicornComponent.state, UnicornState.idle);
        },
      );
    });

    group('isPlayingFiniteAnimation', () {
      flameTester.test(
        'calls after the current animation cycle',
        (game) async {
          final pettedUnicorn = AdultUnicornComponent(
            initialState: UnicornState.petted,
          );

          final eatingUnicorn = AdultUnicornComponent(
            initialState: UnicornState.eating,
          );

          final idleInicorn = AdultUnicornComponent(
            initialState: UnicornState.idle,
          );

          final walkingUnicorn = AdultUnicornComponent(
            initialState: UnicornState.walking,
          );

          await game.ensureAdd(pettedUnicorn);
          await game.ensureAdd(eatingUnicorn);
          await game.ensureAdd(idleInicorn);
          await game.ensureAdd(walkingUnicorn);

          expect(pettedUnicorn.isPlayingFiniteAnimation, true);
          expect(eatingUnicorn.isPlayingFiniteAnimation, true);
          expect(idleInicorn.isPlayingFiniteAnimation, false);
          expect(walkingUnicorn.isPlayingFiniteAnimation, false);
        },
      );
    });
  });

  group('BabyUnicornComponent', () {
    group('preloadAssets', () {
      testWidgets('preloads assets', (tester) async {
        final images = MockImages();

        when(
          () => images.loadAll(any()),
        ).thenAnswer((Invocation invocation) => Future.value(<Image>[]));

        await BabyUnicornComponent.preloadAssets(images);

        verify(
          () => images.loadAll(
            [
              Assets.animations.babyEat.keyName,
              Assets.animations.babyIdle.keyName,
              Assets.animations.babyPetted.keyName,
              Assets.animations.babyWalkCycle.keyName,
            ],
          ),
        ).called(1);
      });
    });

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
            i <= UnicornSpriteComponent.idleAnimationDuration;
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
        final unicorn = BabyUnicornComponent(
          initialState: UnicornState.eating,
        );

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
        final unicorn = BabyUnicornComponent(
          initialState: UnicornState.petted,
        );

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
        final unicorn = BabyUnicornComponent(
          initialState: UnicornState.walking,
        );

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
    group('preloadAssets', () {
      testWidgets('preloads assets', (tester) async {
        final images = MockImages();

        when(
          () => images.loadAll(any()),
        ).thenAnswer((Invocation invocation) => Future.value(<Image>[]));

        await ChildUnicornComponent.preloadAssets(images);

        verify(
          () => images.loadAll(
            [
              Assets.animations.childEat.keyName,
              Assets.animations.childIdle.keyName,
              Assets.animations.childPetted.keyName,
              Assets.animations.childWalkCycle.keyName,
            ],
          ),
        ).called(1);
      });
    });

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
            i <= UnicornSpriteComponent.idleAnimationDuration;
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
        final unicorn = ChildUnicornComponent(
          initialState: UnicornState.eating,
        );

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
        final unicorn = ChildUnicornComponent(
          initialState: UnicornState.petted,
        );

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
        final unicorn = ChildUnicornComponent(
          initialState: UnicornState.walking,
        );

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
    group('preloadAssets', () {
      testWidgets('preloads assets', (tester) async {
        final images = MockImages();

        when(
          () => images.loadAll(any()),
        ).thenAnswer((Invocation invocation) => Future.value(<Image>[]));

        await TeenUnicornComponent.preloadAssets(images);

        verify(
          () => images.loadAll(
            [
              Assets.animations.teenEat.keyName,
              Assets.animations.teenIdle.keyName,
              Assets.animations.teenPetted.keyName,
              Assets.animations.teenWalkCycle.keyName,
            ],
          ),
        ).called(1);
      });
    });

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
            i <= UnicornSpriteComponent.idleAnimationDuration;
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
        final unicorn = TeenUnicornComponent(initialState: UnicornState.eating);

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
        final unicorn = TeenUnicornComponent(
          initialState: UnicornState.petted,
        );

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
        final unicorn = TeenUnicornComponent(
          initialState: UnicornState.walking,
        );

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
    group('preloadAssets', () {
      testWidgets('preloads assets', (tester) async {
        final images = MockImages();

        when(
          () => images.loadAll(any()),
        ).thenAnswer((Invocation invocation) => Future.value(<Image>[]));

        await AdultUnicornComponent.preloadAssets(images);

        verify(
          () => images.loadAll(
            [
              Assets.animations.adultEat.keyName,
              Assets.animations.adultIdle.keyName,
              Assets.animations.adultPetted.keyName,
              Assets.animations.adultWalkCycle.keyName,
            ],
          ),
        ).called(1);
      });
    });

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
            i <= UnicornSpriteComponent.idleAnimationDuration;
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
        final unicorn = AdultUnicornComponent(
          initialState: UnicornState.eating,
        );

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
        final unicorn = AdultUnicornComponent(
          initialState: UnicornState.petted,
        );

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
        final unicorn = AdultUnicornComponent(
          initialState: UnicornState.walking,
        );

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
