import 'package:flame/components.dart';
import 'package:ranch_components/gen/assets.gen.dart';

class Barn extends SpriteComponent with HasGameRef {
  Barn({super.position}) : super(size: Vector2(220.5, 140));

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite(Assets.images.barn.packagePath);
  }
}

class TreeTrio extends SpriteComponent with HasGameRef {
  TreeTrio({super.position}) : super(size: dimensions);
  static final dimensions = Vector2(68.3, 96);

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite(Assets.images.treeTrio.packagePath);
  }
}

class TreeTall extends SpriteComponent with HasGameRef {
  TreeTall({super.position}) : super(size: dimensions);
  static final dimensions = Vector2(24.5, 69);

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite(Assets.images.treeTall.packagePath);
  }
}

class TreeShort extends SpriteComponent with HasGameRef {
  TreeShort({super.position}) : super(size: dimensions);
  static final dimensions = Vector2(24, 51.5);

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite(Assets.images.treeShort.packagePath);
  }
}

class Grass extends SpriteComponent with HasGameRef {
  Grass({super.position}) : super(size: dimensions);
  static final dimensions = Vector2(19, 5);

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite(Assets.images.grass.packagePath);
  }
}

class FlowerSolo extends SpriteComponent with HasGameRef {
  FlowerSolo({super.position}) : super(size: dimensions);
  static final dimensions = Vector2(8.5, 20.5);

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite(Assets.images.flowerSolo.packagePath);
  }
}

class FlowerDuo extends SpriteComponent with HasGameRef {
  FlowerDuo({super.position}) : super(size: dimensions);
  static final dimensions = Vector2(24, 25);

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite(Assets.images.flowerDuo.packagePath);
  }
}

class FlowerGroup extends SpriteComponent with HasGameRef {
  FlowerGroup({super.position}) : super(size: dimensions);
  static final dimensions = Vector2(49, 18.5);

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite(Assets.images.flowerGroup.packagePath);
  }
}
