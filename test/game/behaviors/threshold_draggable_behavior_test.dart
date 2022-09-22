// ignore_for_file: cascade_invocations

import 'package:flame/input.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_ranch/game/behaviors/behaviors.dart';

import '../../helpers/helpers.dart';

class _TestEntity extends Entity {
  _TestEntity({super.behaviors}) : super(size: Vector2.all(32));
}

class _TestThresholdDraggingBehavior extends ThresholdDraggableBehavior {
  _TestThresholdDraggingBehavior({
    required this.handleReallyDragStart,
    required this.handleReallyDragUpdate,
  });

  @override
  double get threshold => 99;

  final ValueSetter<DragStartInfo> handleReallyDragStart;

  final ValueSetter<DragUpdateInfo> handleReallyDragUpdate;

  @override
  bool onReallyDragStart(DragStartInfo info) {
    super.onReallyDragStart(info);
    handleReallyDragStart(info);
    return false;
  }

  @override
  bool onReallyDragUpdate(DragUpdateInfo info) {
    super.onReallyDragUpdate(info);
    handleReallyDragUpdate(info);
    return false;
  }
}

void main() {
  final flameTester = FlameTester(TestGame.new);

  group('ThresholdDraggableBehavior', () {
    DragStartInfo? lastDragStartInfo;
    DragUpdateInfo? lastDragUpdateInfo;

    setUp(() {
      lastDragStartInfo = null;
      lastDragUpdateInfo = null;
    });

    flameTester.testGameWidget(
      'on drag within threshold',
      setUp: (game, tester) async {
        final entity = _TestEntity(
          behaviors: [
            _TestThresholdDraggingBehavior(
              handleReallyDragStart: (info) {
                lastDragStartInfo = info;
              },
              handleReallyDragUpdate: (info) {
                lastDragUpdateInfo = info;
              },
            ),
          ],
        );
        await game.ensureAdd(entity);
        await game.ready();
      },
      verify: (game, tester) async {
        await tester.flingFrom(
          Offset.zero,
          const Offset(0, 90),
          100,
        );

        expect(lastDragStartInfo, isNull);
        expect(lastDragUpdateInfo, isNull);
      },
    );

    flameTester.testGameWidget(
      'on drag beyond threshold',
      setUp: (game, tester) async {
        late final _TestEntity entity;

        entity = _TestEntity(
          behaviors: [
            _TestThresholdDraggingBehavior(
              handleReallyDragStart: (info) {
                lastDragStartInfo = info;
              },
              handleReallyDragUpdate: (info) {
                entity.position.add(info.delta.game);
                lastDragUpdateInfo = info;
              },
            ),
          ],
        );
        await game.ensureAdd(entity);
        await game.ready();
      },
      verify: (game, tester) async {
        await tester.flingFrom(
          Offset.zero,
          const Offset(0, 100),
          100,
        );

        expect(
          lastDragStartInfo?.eventPosition.viewport,
          Vector2.zero(),
        );
        expect(
          lastDragUpdateInfo?.eventPosition.viewport,
          Vector2(0, 100),
        );

        lastDragStartInfo = null;
        lastDragUpdateInfo = null;

        game.pauseEngine();
        await tester.pumpAndSettle();
        game.resumeEngine();

        await tester.flingFrom(
          const Offset(0, 100),
          const Offset(100, 0),
          100,
        );

        expect(
          lastDragStartInfo?.eventPosition.viewport,
          Vector2(0, 100),
        );
        expect(
          lastDragUpdateInfo?.eventPosition.viewport,
          Vector2(100, 100),
        );
      },
    );
  });
}
