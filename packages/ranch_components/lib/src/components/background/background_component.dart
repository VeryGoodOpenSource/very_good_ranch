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

    await addAll([
      // Add barn
      Barn(position: delegate.getPositionForBarn(Barn.dimensions)),

      // Add tree trios:
      // one at the top
      TreeTrio(position: delegate.getPositionForTreeTrio1(TreeTrio.dimensions)),
      // one at bottom left
      TreeTrio(position: delegate.getPositionForTreeTrio2(TreeTrio.dimensions)),
      // one at bottom left
      TreeTrio(position: delegate.getPositionForTreeTrio3(TreeTrio.dimensions)),

      // Add trees to the left
      for (final position
          in delegate.getPositionsForLeftSideTrees(TallTree.dimensions))
        TallTree(position: position),

      // Add trees to the right
      for (final position in delegate.getPositionsForRightSideTrees(
        ShortTree.dimensions,
        size.x,
      ))
        ShortTree(position: position),

      // Add all the grass
      for (final position in delegate.getPositionsForGrasses(Grass.dimensions))
        Grass(position: position),

      // Add flowers solo
      for (final position
          in delegate.getPositionsForFlowerSolo(FlowerSolo.dimensions))
        FlowerSolo(position: position),

      // Add flowers duo
      for (final position
          in delegate.getPositionsForFlowerDuo(FlowerDuo.dimensions))
        FlowerDuo(position: position),

      // Add groups of flowers
      for (final position
          in delegate.getPositionsForFlowerGroup(FlowerGroup.dimensions))
        FlowerGroup(position: position)
    ]);
  }
}
