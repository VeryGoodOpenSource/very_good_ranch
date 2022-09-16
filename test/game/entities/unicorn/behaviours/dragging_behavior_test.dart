// ignore_for_file: cascade_invocations

import 'dart:math';

import 'package:flame/extensions.dart';
import 'package:flame/particles.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_ranch/game/entities/unicorn/behaviors/behaviors.dart';
import 'package:very_good_ranch/game/entities/unicorn/behaviors/dragging_behavior.dart';
import 'package:very_good_ranch/game/entities/unicorn/unicorn.dart';
import 'package:very_good_ranch/game/game.dart';

import '../../../../helpers/helpers.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Random seed;

  setUp(() {
    seed = MockRandom();
    when(() => seed.nextInt(any())).thenReturn(0);
    when(() => seed.nextDouble()).thenReturn(0);
    when(() => seed.nextBool()).thenReturn(false);
  });

  final flameTester = FlameTester<VeryGoodRanchGame>(
    () => VeryGoodRanchGame(
      seed: seed,
      blessingBloc: MockBlessingBloc(),
    ),
  );

  group('beingDragged', () {
    flameTester.testGameWidget(
      'set it to true on drag start',
      setUp: (game, tester) async {
        final unicorn = Unicorn.test(
          position: Vector2.all(0),
          behaviors: [DraggingBehavior()],
        );
        await game.background.ensureAdd(unicorn);
        await game.ready();

        final gesture = await tester.createGesture();
        await gesture.down(Offset.zero);
        await tester.pump();
        await gesture.moveTo(const Offset(210, 350));
        await tester.pump();
      },
      verify: (game, tester) async {
        final unicorn = game.descendants().whereType<Unicorn>().first;

        expect(unicorn.beingDragged, isTrue);
      },
    );

    flameTester.testGameWidget(
      'set it to false on drag stop',
      setUp: (game, tester) async {
        final unicorn = Unicorn.test(
          position: Vector2.all(0),
          behaviors: [DraggingBehavior()],
        );
        await game.background.ensureAdd(unicorn);
        await game.ready();

        final gesture = await tester.createGesture();
        await gesture.down(Offset.zero);
        await tester.pump();
        await gesture.moveTo(const Offset(210, 350));
        await gesture.up();
        await tester.pump();
      },
      verify: (game, tester) async {
        final unicorn = game.descendants().whereType<Unicorn>().first;

        expect(unicorn.beingDragged, isFalse);
      },
    );

    flameTester.testGameWidget(
      'set it to false on drag cancel',
      setUp: (game, tester) async {
        final unicorn = Unicorn.test(
          position: Vector2.all(0),
          behaviors: [DraggingBehavior()],
        );
        await game.background.ensureAdd(unicorn);
        await game.ready();

        final gesture = await tester.createGesture();
        await gesture.down(Offset.zero);
        await tester.pump();
        await gesture.moveTo(const Offset(210, 350));
        await gesture.cancel();
        await tester.pump();
        await tester.pump();
      },
      verify: (game, tester) async {
        final unicorn = game.descendants().whereType<Unicorn>().first;

        expect(unicorn.beingDragged, isFalse);
      },
    );
  });

  group('overridePriority', () {
    flameTester.testGameWidget(
      'set it to value on drag start',
      setUp: (game, tester) async {
        final unicorn = Unicorn.test(
          position: Vector2.all(0),
          behaviors: [DraggingBehavior()],
        );
        await game.background.ensureAdd(unicorn);
        await game.ready();

        final gesture = await tester.createGesture();
        await gesture.down(Offset.zero);
        await tester.pump();
        await gesture.moveTo(const Offset(210, 350));
        await tester.pump();
      },
      verify: (game, tester) async {
        final unicorn = game.descendants().whereType<Unicorn>().first;

        expect(unicorn.overridePriority, isNotNull);
      },
    );

    flameTester.testGameWidget(
      'set it to null on drag stop',
      setUp: (game, tester) async {
        final unicorn = Unicorn.test(
          position: Vector2.all(0),
          behaviors: [DraggingBehavior()],
        );
        await game.background.ensureAdd(unicorn);
        await game.ready();

        final gesture = await tester.createGesture();
        await gesture.down(Offset.zero);
        await tester.pump();
        await gesture.moveTo(const Offset(210, 350));
        await gesture.up();
        await tester.pump();
      },
      verify: (game, tester) async {
        final unicorn = game.descendants().whereType<Unicorn>().first;

        expect(unicorn.overridePriority, isNull);
      },
    );

    flameTester.testGameWidget(
      'set it to null on drag cancel',
      setUp: (game, tester) async {
        final unicorn = Unicorn.test(
          position: Vector2.all(0),
          behaviors: [DraggingBehavior()],
        );
        await game.background.ensureAdd(unicorn);
        await game.ready();

        final gesture = await tester.createGesture();
        await gesture.down(Offset.zero);
        await tester.pump();
        await gesture.moveTo(const Offset(210, 350));
        await gesture.cancel();
        await tester.pump();
        await tester.pump();
      },
      verify: (game, tester) async {
        final unicorn = game.descendants().whereType<Unicorn>().first;

        expect(unicorn.overridePriority, isNull);
      },
    );
  });

  group('scale effects', () {
    flameTester.testGameWidget(
      'sets scale during and after drag',
      setUp: (game, tester) async {
        final unicorn = Unicorn.test(
          position: Vector2.all(0),
          behaviors: [DraggingBehavior()],
        );
        await game.background.ensureAdd(unicorn);
        await game.ready();
      },
      verify: (game, tester) async {
        final gesture = await tester.createGesture();
        await gesture.down(Offset.zero);

        /// Flush long press gesture timer
        game.pauseEngine();
        await tester.pumpAndSettle();
        game.resumeEngine();

        await gesture.moveTo(const Offset(210, 350));
        await tester.pump();

        final unicorn = game.descendants().whereType<Unicorn>().first;
        expect(unicorn.scale, Vector2.all(1));
        game.update(0.1);
        expect(unicorn.scale, Vector2.all(0.7));

        await gesture.up();
        expect(unicorn.scale, Vector2.all(0.7));
        game.update(0.1);
        expect(unicorn.scale, Vector2.all(1));
      },
    );
  });

  group('opacity effects', () {
    flameTester.testGameWidget(
      'sets opacity during and after drag',
      setUp: (game, tester) async {
        final unicorn = Unicorn.test(
          position: Vector2.all(0),
          behaviors: [DraggingBehavior()],
        );
        await game.background.ensureAdd(unicorn);
        await game.ready();
      },
      verify: (game, tester) async {
        final gesture = await tester.createGesture();
        await gesture.down(Offset.zero);

        /// Flush long press gesture timer
        game.pauseEngine();
        await tester.pumpAndSettle();
        game.resumeEngine();

        await gesture.moveTo(const Offset(210, 350));
        await tester.pump();

        final unicorn = game.descendants().whereType<Unicorn>().first;
        expect(unicorn.unicornComponent.paint.color.alpha / 255, 1);
        game.update(0.4);
        expect(unicorn.unicornComponent.paint.color.alpha / 255, 0.8);

        await gesture.up();
        expect(unicorn.unicornComponent.paint.color.alpha / 255, 0.8);
        game.update(0.4);
        expect(unicorn.unicornComponent.paint.color.alpha / 255, 1);
      },
    );
  });

  group('rotate effects', () {
    flameTester.testGameWidget(
      'sets angle during drag',
      setUp: (game, tester) async {
        final unicorn = Unicorn.test(
          position: Vector2.all(0),
          behaviors: [DraggingBehavior()],
        );
        await game.background.ensureAdd(unicorn);
        await game.ready();
      },
      verify: (game, tester) async {
        final gesture = await tester.createGesture();
        await gesture.down(Offset.zero);

        /// Flush long press gesture timer
        game.pauseEngine();
        await tester.pumpAndSettle();
        game.resumeEngine();

        await gesture.moveTo(const Offset(210, 350));
        await tester.pump();

        final unicorn = game.descendants().whereType<Unicorn>().first;
        expect(unicorn.angle, 0);
        game.update(0.1);
        expect(unicorn.angle, 15 * degrees2Radians);

        await gesture.moveTo(const Offset(110, 350));
        await tester.pump();
        expect(unicorn.angle, 15 * degrees2Radians);
        game.update(0.1);
        expect(unicorn.angle, -15 * degrees2Radians);
      },
    );
  });

  group('clamp unicorn positions', () {
    flameTester.testGameWidget(
      'clamps to pasture field',
      setUp: (game, tester) async {
        final unicorn = Unicorn.test(
          position: Vector2.all(0),
          behaviors: [DraggingBehavior()],
        );
        await game.background.ensureAdd(unicorn);
        await game.ready();
      },
      verify: (game, tester) async {
        final gesture = await tester.createGesture();
        await gesture.down(Offset.zero);

        final unicorn = game.descendants().whereType<Unicorn>().first;

        game.pauseEngine();
        await tester.pumpAndSettle();
        game.resumeEngine();

        await gesture.moveTo(const Offset(1000, 1000));
        await tester.pump();
        expect(
          unicorn.position,
          game.background.pastureField.bottomRight.toVector2(),
        );

        await gesture.moveTo(const Offset(-1000, 1000));
        await tester.pump();
        expect(
          unicorn.position,
          game.background.pastureField.bottomLeft.toVector2(),
        );

        await gesture.moveTo(const Offset(-1000, -1000));
        await tester.pump();
        expect(
          unicorn.position,
          game.background.pastureField.topLeft.toVector2(),
        );

        await gesture.moveTo(const Offset(1000, -1000));
        await tester.pump();
        expect(
          unicorn.position,
          game.background.pastureField.topRight.toVector2(),
        );
      },
    );
  });

  group('drop unicorn', () {
    flameTester.testGameWidget(
      'drops unicorn after dragging',
      setUp: (game, tester) async {
        final unicorn = Unicorn.test(
          position: Vector2.all(0),
          behaviors: [DraggingBehavior()],
        );
        await game.background.ensureAdd(unicorn);
        await game.ready();

        final gesture = await tester.createGesture();
        await gesture.down(Offset.zero);
        await tester.pump();
        await gesture.moveBy(const Offset(0, 1000));
        await gesture.up();
        await tester.pump();
      },
      verify: (game, tester) async {
        final unicorn = game.descendants().whereType<Unicorn>().first;

        game.update(0.3);

        expect(
          unicorn.absolutePositionOfAnchor(Anchor.bottomCenter).y,
          game.background.pastureField.bottom,
        );
      },
    );
  });
}
