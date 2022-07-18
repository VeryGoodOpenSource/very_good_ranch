// ignore_for_file: cascade_invocations

import 'package:flame/input.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_ranch/game/behaviors/behaviors.dart';

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
      },
      verify: (game, tester) async {
        await tester.tapAt(Offset.zero);
        await tester.pump(kDoubleTapMinTime);
        await tester.tapAt(Offset.zero);

        final behavior =
            game.descendants().whereType<_TestDoubleTapBehavior>().first;
        expect(behavior.doubleTapped, isTrue);

        // flush remaining timers created by the framework
        await tester.pump(kLongPressTimeout);
      },
    );

    flameTester.testGameWidget(
      'does not double tap with too much time between the taps',
      setUp: (game, tester) async {
        final entity = _TestEntity(behaviors: [_TestDoubleTapBehavior()]);
        await game.ensureAdd(entity);
        await game.ready();
      },
      verify: (game, tester) async {
        await tester.tapAt(Offset.zero);
        await tester.pump();
        await tester.pump(kDoubleTapTimeout);
        await tester.tapAt(Offset.zero);
        await tester.pump();

        final behavior =
            game.descendants().whereType<_TestDoubleTapBehavior>().first;

        expect(behavior.doubleTapped, isFalse);

        // flush remaining timers created by the framework
        await tester.pump(kLongPressTimeout);
      },
    );
  });
}
