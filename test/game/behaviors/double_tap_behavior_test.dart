// ignore_for_file: cascade_invocations

import 'package:flame/input.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_ranch/game/behaviors/double_tap_behavior.dart';

import '../../helpers/helpers.dart';

class _TestEntity extends Entity {
  _TestEntity({super.behaviors}) : super(size: Vector2.all(32));
}

class _TestDoubleTapBehavior extends DoubleTapBehavior {
  bool doubleTapped = false;

  @override
  bool onDoubleTapDown(TapDownInfo info) {
    doubleTapped = true;
    return super.onDoubleTapDown(info);
  }
}

void main() {
  final flameTester = FlameTester(TestGame.new);

  group('DoubleTapBehavior', () {
    flameTester.testGameWidget(
      'on double tap down',
      setUp: (game, tester) async {
        final entity = _TestEntity(behaviors: [_TestDoubleTapBehavior()]);
        await game.ensureAdd(entity);
        await game.ready();

        await tester.tapAt(Offset.zero);
        await Future<void>.delayed(kDoubleTapMinTime);
        await tester.tapAt(Offset.zero);
        await tester.pump();
      },
      verify: (game, tester) async {
        final behavior =
            game.descendants().whereType<_TestDoubleTapBehavior>().first;
        expect(behavior.doubleTapped, isTrue);
      },
    );

    flameTester.testGameWidget(
      'does not double tap with too much time between the taps',
      setUp: (game, tester) async {
        final entity = _TestEntity(behaviors: [_TestDoubleTapBehavior()]);
        await game.ensureAdd(entity);
        await game.ready();

        await tester.tapAt(Offset.zero);
        await tester.pump();
        await Future<void>.delayed(kDoubleTapTimeout);
        await tester.tapAt(Offset.zero);
        await tester.pump();
      },
      verify: (game, tester) async {
        final behavior =
            game.descendants().whereType<_TestDoubleTapBehavior>().first;

        expect(behavior.doubleTapped, isFalse);
      },
    );
  });
}