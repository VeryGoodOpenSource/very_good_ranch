import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:ranch_components/gen/assets.gen.dart';

/// {@template background_element}
/// A background element that can be added to the background.
/// {@endtemplate}
abstract class BackgroundElement extends SpriteComponent with HasGameRef {
  /// {@macro tree_trio}
  BackgroundElement({
    super.position,
    required Vector2 dimensions,
    required this.asset,
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
      : super(dimensions: dimensions, asset: Assets.images.barn.keyName);

  /// The dimensions of the barn
  static final dimensions = Vector2(220.5, 140);
}

/// {@template tree_trio}
/// A component that shows a tiny forest of three trees
/// {@endtemplate}
class TreeTrio extends BackgroundElement {
  /// {@macro tree_trio}
  TreeTrio({super.position})
      : super(dimensions: dimensions, asset: Assets.images.treeTrio.keyName);

  /// The dimensions of the tiny forest of three trees
  static final dimensions = Vector2(68.3, 96);
}

/// {@template tall_tree}
/// A component that shows a tall tree
/// {@endtemplate}
class TallTree extends BackgroundElement {
  /// {@macro tall_tree}
  TallTree({super.position})
      : super(dimensions: dimensions, asset: Assets.images.tallTree.keyName);

  /// The dimensions of the tall tree
  static final dimensions = Vector2(24.5, 69);
}

/// {@template short_tree}
/// A component that shows a short tree
/// {@endtemplate}
class ShortTree extends BackgroundElement {
  /// {@macro short_tree}
  ShortTree({super.position})
      : super(dimensions: dimensions, asset: Assets.images.shortTree.keyName);

  /// The dimensions of the short tree
  static final dimensions = Vector2(24, 51.5);
}

/// {@template grass}
/// A component that shows some grass
/// {@endtemplate}
class Grass extends BackgroundElement {
  /// {@macro grass}
  Grass({super.position})
      : super(dimensions: dimensions, asset: Assets.images.grass.keyName);

  /// The dimensions of the
  static final dimensions = Vector2(19, 5);
}

/// {@template flower_solo}
/// A component that shows a lone flower
/// {@endtemplate}
class FlowerSolo extends BackgroundElement {
  /// {@macro flower_solo}
  FlowerSolo({super.position})
      : super(dimensions: dimensions, asset: Assets.images.flowerSolo.keyName);

  /// The dimensions of the lone flower
  static final dimensions = Vector2(8.5, 20.5);
}

/// {@template flower_duo}
/// A component that shows two flowers
/// {@endtemplate}
class FlowerDuo extends BackgroundElement {
  /// {@macro flower_duo}
  FlowerDuo({super.position})
      : super(dimensions: dimensions, asset: Assets.images.flowerDuo.keyName);

  /// The dimensions of the two flowers
  static final dimensions = Vector2(24, 25);
}

/// {@template flower_group}
/// A component that shows a group of flowers
/// {@endtemplate}
class FlowerGroup extends BackgroundElement {
  /// {@macro flower_group}
  FlowerGroup({super.position})
      : super(dimensions: dimensions, asset: Assets.images.flowerGroup.keyName);

  /// The dimensions of the group of flowers
  static final dimensions = Vector2(49, 18.5);
}
