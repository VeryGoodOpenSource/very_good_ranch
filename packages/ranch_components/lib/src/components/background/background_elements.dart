import 'package:flame/components.dart';
import 'package:ranch_components/gen/assets.gen.dart';

/// {@template barn}
/// A component that shows a barn
/// {@endtemplate}
class Barn extends SpriteComponent with HasGameRef {
  /// {@macro barn}
  Barn({super.position}) : super(size: Vector2(220.5, 140));

  /// The dimensions of the barn
  static final dimensions = Vector2(220.5, 140);

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite(Assets.images.barn.packagePath);
  }
}

/// {@template tree_trio}
/// A component that shows a tiny forrest of three trees
/// {@endtemplate}
class TreeTrio extends SpriteComponent with HasGameRef {
  /// {@macro tree_trio}
  TreeTrio({super.position}) : super(size: dimensions);

  /// The dimensions of the tiny forrest of three trees
  static final dimensions = Vector2(68.3, 96);

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite(Assets.images.treeTrio.packagePath);
  }
}

/// {@template tree_tall}
/// A component that shows a tall tree
/// {@endtemplate}
class TreeTall extends SpriteComponent with HasGameRef {
  /// {@macro tree_tall}
  TreeTall({super.position}) : super(size: dimensions);

  /// The dimensions of the tall tree
  static final dimensions = Vector2(24.5, 69);

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite(Assets.images.treeTall.packagePath);
  }
}

/// {@template tree_short}
/// A component that shows a short tree
/// {@endtemplate}
class TreeShort extends SpriteComponent with HasGameRef {
  /// {@macro tree_short}
  TreeShort({super.position}) : super(size: dimensions);

  /// The dimensions of the short tree
  static final dimensions = Vector2(24, 51.5);

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite(Assets.images.treeShort.packagePath);
  }
}

/// {@template grass}
/// A component that shows some grass
/// {@endtemplate}
class Grass extends SpriteComponent with HasGameRef {
  /// {@macro grass}
  Grass({super.position}) : super(size: dimensions);

  /// The dimensions of the
  static final dimensions = Vector2(19, 5);

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite(Assets.images.grass.packagePath);
  }
}

/// {@template flower_solo}
/// A component that shows a lone flower
/// {@endtemplate}
class FlowerSolo extends SpriteComponent with HasGameRef {
  /// {@macro flower_solo}
  FlowerSolo({super.position}) : super(size: dimensions);

  /// The dimensions of the lone flower
  static final dimensions = Vector2(8.5, 20.5);

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite(Assets.images.flowerSolo.packagePath);
  }
}

/// {@template flower_duo}
/// A component that shows two flowers
/// {@endtemplate}
class FlowerDuo extends SpriteComponent with HasGameRef {
  /// {@macro flower_duo}
  FlowerDuo({super.position}) : super(size: dimensions);

  /// The dimensions of the two flowers
  static final dimensions = Vector2(24, 25);

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite(Assets.images.flowerDuo.packagePath);
  }
}

/// {@template flower_group}
/// A component that shows a group of flowers
/// {@endtemplate}
class FlowerGroup extends SpriteComponent with HasGameRef {
  /// {@macro flower_group}
  FlowerGroup({super.position}) : super(size: dimensions);

  /// The dimensions of the group of flowers
  static final dimensions = Vector2(49, 18.5);

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite(Assets.images.flowerGroup.packagePath);
  }
}
