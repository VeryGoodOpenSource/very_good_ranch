import 'dart:math';

import 'package:flame/cache.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/widgets.dart';
import 'package:ranch_components/gen/assets.gen.dart';
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
  BackgroundComponent({
    this.viewPadding = EdgeInsets.zero,
    super.children,
    this.getDelegate,
  });

  /// The safe area padding of the view.
  final EdgeInsets viewPadding;

  /// Preload all background assets into [images].
  static Future<void> preloadAssets(Images images) async {
    await images.loadAll([
      Assets.background.barn.keyName,
      Assets.background.sheep.keyName,
      Assets.background.sheepSmall.keyName,
      Assets.background.cow.keyName,
      Assets.background.flowerDuo.keyName,
      Assets.background.flowerGroup.keyName,
      Assets.background.flowerSolo.keyName,
      Assets.background.grass.keyName,
      Assets.background.shortTree.keyName,
      Assets.background.tallTree.keyName,
      Assets.background.linedTree.keyName,
      Assets.background.linedTreeShort.keyName,
    ]);
  }

  /// Describes the amount of pixels in each side of the viewport that are
  /// reserved for visual elements in which the unicorns and playable elements
  /// cannot be displaced to.
  static const paddingToPasture = EdgeInsets.only(
    top: 220,
    left: 42,
    right: 42,
    bottom: 30,
  );

  /// The delegate responsible for defining the positions of the several visual
  /// elements of the background.
  PositionDelegateGetter? getDelegate;

  /// A [Rect] that represents the area in which playable elements
  /// (ex: unicorns)
  /// will be placed
  late final Rect pastureField;

  void _calculatePastureField() {
    final paddingDeflection = Vector2(
      paddingToPasture.horizontal + viewPadding.horizontal,
      paddingToPasture.vertical + viewPadding.vertical,
    );
    final paddingPosition = Vector2(
      paddingToPasture.left + viewPadding.left,
      paddingToPasture.top + viewPadding.top,
    );
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

      Sheep(position: delegate.getPositionForSheep(Sheep.dimensions)),

      SheepSmall(
        position: delegate.getPositionForSheepSmall(SheepSmall.dimensions),
      ),

      Cow(position: delegate.getPositionForCow(Cow.dimensions)),

      // Add trees to the left
      ...delegate.positionSideTrees(
        minX: 0,
        maxX: pastureField.left,
        positionTree: (type, position) => type.getBackgroundElement(position),
      ),

      // Add trees to the right
      ...delegate.positionSideTrees(
        minX: pastureField.right,
        maxX: size.x,
        positionTree: (type, position) => type.getBackgroundElement(position),
      ),

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
