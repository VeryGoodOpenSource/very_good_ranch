import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flutter/widgets.dart';
import 'package:ranch_components/ranch_components.dart';
import 'package:ranch_components/src/components/background/background_elements.dart';
import 'package:ranch_components/src/components/background/background_position_delegate.dart';

class BackgroundComponent extends PositionComponent with HasGameRef {
  BackgroundComponent({super.children, this.positioner});

  static const padding = EdgeInsets.only(
    top: 170,
    left: 30,
    right: 30,
    bottom: 30,
  );

  BackgroundPositionDelegate? positioner;

  late final Rect pastureArea;

  void _calculatePastureArea() {
    final paddingDeflection = Vector2(padding.horizontal, padding.vertical);
    final paddingPosition = Vector2(padding.left, padding.top);
    final pastureAreaSize = size - paddingDeflection;
    final pastureAreaPosition = paddingPosition;

    pastureArea = Rect.fromPoints(
      pastureAreaPosition.toOffset(),
      pastureAreaPosition.toOffset() + pastureAreaSize.toOffset(),
    );
  }

  @override
  Future<void> onLoad() async {
    size = gameRef.camera.viewport.effectiveSize;

    _calculatePastureArea();

    final positioner = this.positioner ??= BackgroundPositionDelegate(
      seed: Random(),
      pastureArea: pastureArea,
    );

    // Add barn
    await add(Barn(position: positioner.getPositionForBarn()));

    // Add 3 tree trios:
    // one at the top
    await add(
      TreeTrio(
        position: positioner.getPositionForTreeTrio1(TreeTrio.dimensions),
      ),
    );

    // one at bottom left
    await add(
      TreeTrio(
        position: positioner.getPositionForTreeTrio2(TreeTrio.dimensions),
      )..priority = 1,
    );

    // one at bottom left
    await add(
      TreeTrio(
        position: positioner.getPositionForTreeTrio3(TreeTrio.dimensions),
      )..priority = 1,
    );

    // Add trees to the left
    final leftSideTreePositions =
        positioner.getPositionsForLeftSideTrees(TreeTall.dimensions);
    for (final leftSideTreePosition in leftSideTreePositions) {
      await add(
        TreeTall(
          position: leftSideTreePosition,
        ),
      );
    }

    // Add trees to the right
    final rightSideTreePositions =
        positioner.getPositionsForRightSideTrees(TreeShort.dimensions, size.x);
    for (final rightSideTreePosition in rightSideTreePositions) {
      await add(
        TreeShort(
          position: rightSideTreePosition,
        ),
      );
    }

    // Add all the grass
    final grassesPositions =
        positioner.getPositionsForGrasses(Grass.dimensions);
    for (final grassPosition in grassesPositions) {
      await add(
        Grass(
          position: grassPosition,
        ),
      );
    }

    // Add flowers solo
    final soloFlowersPositions =
        positioner.getPositionsForFlowerSolo(FlowerSolo.dimensions);
    for (final soloFlowersPosition in soloFlowersPositions) {
      await add(
        FlowerSolo(
          position: soloFlowersPosition,
        ),
      );
    }

    // Add flowers duo
    final duoFlowersPositions =
        positioner.getPositionsForFlowerDuo(FlowerDuo.dimensions);
    for (final duoFlowersPosition in duoFlowersPositions) {
      await add(
        FlowerDuo(
          position: duoFlowersPosition,
        ),
      );
    }

    // Add groups of flowers
    final flowerGroupPositions =
        positioner.getPositionsForFlowerDuo(FlowerGroup.dimensions);
    for (final flowerGroupPosition in flowerGroupPositions) {
      await add(
        FlowerGroup(
          position: flowerGroupPosition,
        ),
      );
    }
  }
}
