import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/widgets.dart';
import 'package:ranch_components/ranch_components.dart';
import 'package:ranch_components/src/components/background/background_elements.dart';
import 'package:ranch_components/src/components/background/background_position_delegate.dart';

/// A signature for a callback that crates a [BackgroundPositionDelegate] given
/// a pastureField
typedef PositionDelegateGetter = BackgroundPositionDelegate Function(
  Rect pastureField,
);

/// {@template background_component}
/// A [Component] that adds the several background elements of a ranch and
/// displaces them in such a way there is a [pastureField] in
/// which unicorns can eat and roam about
/// {@endtemplate}
class BackgroundComponent extends PositionComponent with HasGameRef {
  /// {@macro background_component}
  BackgroundComponent({super.children, this.getDelegate});

  /// Describes the amount of pixels in each side of the viewport that are
  /// reserved for visual elements in which the unicorns and playble elements
  /// cannot be displaced to.
  static const paddingToPasture = EdgeInsets.only(
    top: 170,
    left: 30,
    right: 30,
    bottom: 30,
  );

  /// The delegate responsible for defining the positions of the several visual
  /// elements of the background.
  PositionDelegateGetter? getDelegate;

  /// A [Rect] that represents the area in which playable elements (ex: uncorns)
  /// will be placed
  late final Rect pastureField;

  void _calculatePastureField() {
    final paddingDeflection =
        Vector2(paddingToPasture.horizontal, paddingToPasture.vertical);
    final paddingPosition =
        Vector2(paddingToPasture.left, paddingToPasture.top);
    final pastureFieldSize = size - paddingDeflection;
    final pastureFieldPosition = paddingPosition;

    pastureField = Rect.fromPoints(
      pastureFieldPosition.toOffset(),
      pastureFieldPosition.toOffset() + pastureFieldSize.toOffset(),
    );
  }

  @override
  Future<void> onLoad() async {
    size = gameRef.camera.viewport.effectiveSize;

    _calculatePastureField();

    final delegate = getDelegate?.call(pastureField) ??
        BackgroundPositionDelegate(Random(), pastureField);

    // Add barn
    await add(
      Barn(
        position: delegate.getPositionForBarn(Barn.dimensions),
      ),
    );

    // Add  tree trios:
    // one at the top
    await add(
      TreeTrio(
        position: delegate.getPositionForTreeTrio1(TreeTrio.dimensions),
      ),
    );

    // one at bottom left
    await add(
      TreeTrio(
        position: delegate.getPositionForTreeTrio2(TreeTrio.dimensions),
      )..priority = 1,
    );

    // one at bottom left
    await add(
      TreeTrio(
        position: delegate.getPositionForTreeTrio3(TreeTrio.dimensions),
      )..priority = 1,
    );

    // Add trees to the left
    final leftSideTreePositions =
        delegate.getPositionsForLeftSideTrees(TallTree.dimensions);
    for (final leftSideTreePosition in leftSideTreePositions) {
      await add(
        TallTree(
          position: leftSideTreePosition,
        ),
      );
    }

    // Add trees to the right
    final rightSideTreePositions =
        delegate.getPositionsForRightSideTrees(ShortTree.dimensions, size.x);
    for (final rightSideTreePosition in rightSideTreePositions) {
      await add(
        ShortTree(
          position: rightSideTreePosition,
        ),
      );
    }

    // Add all the grass
    final grassesPositions = delegate.getPositionsForGrasses(Grass.dimensions);
    for (final grassPosition in grassesPositions) {
      await add(
        Grass(
          position: grassPosition,
        ),
      );
    }

    // Add flowers solo
    final soloFlowersPositions =
        delegate.getPositionsForFlowerSolo(FlowerSolo.dimensions);
    for (final soloFlowersPosition in soloFlowersPositions) {
      await add(
        FlowerSolo(
          position: soloFlowersPosition,
        ),
      );
    }

    // Add flowers duo
    final duoFlowersPositions =
        delegate.getPositionsForFlowerDuo(FlowerDuo.dimensions);
    for (final duoFlowersPosition in duoFlowersPositions) {
      await add(
        FlowerDuo(
          position: duoFlowersPosition,
        ),
      );
    }

    // Add groups of flowers
    final flowerGroupPositions =
        delegate.getPositionsForFlowerGroup(FlowerGroup.dimensions);
    for (final flowerGroupPosition in flowerGroupPositions) {
      await add(
        FlowerGroup(
          position: flowerGroupPosition,
        ),
      );
    }
  }
}
