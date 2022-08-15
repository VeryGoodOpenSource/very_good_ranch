import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:ranch_components/gen/assets.gen.dart';
import 'package:ranch_components/ranch_components.dart';

/// {@template background_element}
/// A background element that can be added to the [BackgroundComponent].
/// {@endtemplate}
abstract class BackgroundElement extends SpriteComponent with HasGameRef {
  /// {@macro tree_trio}
  BackgroundElement({
    super.position,
    required Vector2 dimensions,
    required this.asset,
    super.anchor,
  }) : super(size: dimensions);

  /// The asset to use for the background element.
  final String asset;

  @override
  @mustCallSuper
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite(asset);
    priority = positionOfAnchor(Anchor.bottomCenter).y.toInt();
  }
}

/// {@template barn}
/// A component that shows a barn
/// {@endtemplate}
class Barn extends BackgroundElement {
  /// {@macro barn}
  Barn({super.position})
      : super(
          dimensions: dimensions,
          asset: Assets.background.barn.keyName,
          anchor: Anchor.bottomLeft,
        );

  /// The dimensions of the barn
  static final dimensions = Vector2(210, 140);
}

/// {@template sheep}
/// A component that shows a sheep
/// {@endtemplate}
class Sheep extends BackgroundElement {
  /// {@macro sheep}
  Sheep({super.position})
      : super(
          dimensions: dimensions,
          asset: Assets.background.sheep.keyName,
          anchor: Anchor.bottomCenter,
        );

  /// The dimensions of the sheep
  static final dimensions = Vector2(54.6, 47.8);
}

/// {@template sheep_small}
/// A component that shows a small sheep
/// {@endtemplate}
class SheepSmall extends BackgroundElement {
  /// {@macro sheep_small}
  SheepSmall({super.position})
      : super(
          dimensions: dimensions,
          asset: Assets.background.sheepSmall.keyName,
          anchor: Anchor.bottomCenter,
        );

  /// The dimensions of the small sheep
  static final dimensions = Vector2(38.7, 34.4);
}

/// {@template cow}
/// A component that shows a cow
/// {@endtemplate}
class Cow extends BackgroundElement {
  /// {@macro cow}
  Cow({super.position})
      : super(
          dimensions: dimensions,
          asset: Assets.background.cow.keyName,
          anchor: Anchor.bottomCenter,
        );

  /// The dimensions of the cow
  static final dimensions = Vector2(82.4, 54.6);
}

/// The different types of trees that can be position in the background.
enum BackgroundTreeType {
  /// Corresponding to [TallTree].
  tall,

  /// Corresponding to [ShortTree].
  short,

  /// Corresponding to [LinedTree].
  lined,

  /// Corresponding to [LinedTreeShort].
  linedShort,
}

/// Adds [getBackgroundElement] to [BackgroundTreeType]
///
/// NOTE: This should be a 2.17 enum constructor but guess what, coverage
/// doesn't work for that, see: https://github.com/dart-lang/coverage/issues/386
extension BackgroundTreeTypeX on BackgroundTreeType {
  /// Get hte corresponding [BackgroundElement] given a [BackgroundTreeType]
  BackgroundElement getBackgroundElement(Vector2 position) {
    switch (this) {
      case BackgroundTreeType.tall:
        return TallTree(position: position);
      case BackgroundTreeType.short:
        return ShortTree(position: position);
      case BackgroundTreeType.lined:
        return LinedTree(position: position);
      case BackgroundTreeType.linedShort:
        return LinedTreeShort(position: position);
    }
  }
}

/// {@template tall_tree}
/// A component that shows a tall tree
/// {@endtemplate}
class TallTree extends BackgroundElement {
  /// {@macro tall_tree}
  TallTree({super.position})
      : super(
          dimensions: dimensions,
          asset: Assets.background.tallTree.keyName,
          anchor: Anchor.bottomCenter,
        );

  /// The dimensions of the tall tree
  static final dimensions = Vector2(61.4, 189.5);
}

/// {@template short_tree}
/// A component that shows a short tree
/// {@endtemplate}
class ShortTree extends BackgroundElement {
  /// {@macro short_tree}
  ShortTree({super.position})
      : super(
          dimensions: dimensions,
          asset: Assets.background.shortTree.keyName,
          anchor: Anchor.bottomCenter,
        );

  /// The dimensions of the short tree
  static final dimensions = Vector2(41, 126.3);
}

/// {@template lined_tree}
/// A component that shows a tree with branches
/// {@endtemplate}
class LinedTree extends BackgroundElement {
  /// {@macro lined_tree}
  LinedTree({super.position})
      : super(
          dimensions: dimensions,
          asset: Assets.background.linedTree.keyName,
          anchor: Anchor.bottomCenter,
        );

  /// The dimensions of the lined tree
  static final dimensions = Vector2(59.7, 174.1);
}

/// {@template lined_tree_short}
/// A component that shows a short tree with branches
/// {@endtemplate}
class LinedTreeShort extends BackgroundElement {
  /// {@macro lined_tree_short}
  LinedTreeShort({super.position})
      : super(
          dimensions: dimensions,
          asset: Assets.background.linedTreeShort.keyName,
          anchor: Anchor.bottomCenter,
        );

  /// The dimensions of the lined tree
  static final dimensions = Vector2(41, 126.3);
}

/// {@template grass}
/// A component that shows some grass
/// {@endtemplate}
class Grass extends BackgroundElement {
  /// {@macro grass}
  Grass({super.position})
      : super(dimensions: dimensions, asset: Assets.background.grass.keyName);

  /// The dimensions of the
  static final dimensions = Vector2(19, 5);
}

/// {@template flower_solo}
/// A component that shows a lone flower
/// {@endtemplate}
class FlowerSolo extends BackgroundElement {
  /// {@macro flower_solo}
  FlowerSolo({super.position})
      : super(
          dimensions: dimensions,
          asset: Assets.background.flowerSolo.keyName,
        );

  /// The dimensions of the lone flower
  static final dimensions = Vector2(8.5, 20.5);
}

/// {@template flower_duo}
/// A component that shows two flowers
/// {@endtemplate}
class FlowerDuo extends BackgroundElement {
  /// {@macro flower_duo}
  FlowerDuo({super.position})
      : super(
          dimensions: dimensions,
          asset: Assets.background.flowerDuo.keyName,
        );

  /// The dimensions of the two flowers
  static final dimensions = Vector2(24, 25);
}

/// {@template flower_group}
/// A component that shows a group of flowers
/// {@endtemplate}
class FlowerGroup extends BackgroundElement {
  /// {@macro flower_group}
  FlowerGroup({super.position})
      : super(
          dimensions: dimensions,
          asset: Assets.background.flowerGroup.keyName,
        );

  /// The dimensions of the group of flowers
  static final dimensions = Vector2(49, 18.5);
}
