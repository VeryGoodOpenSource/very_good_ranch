import 'package:flame/cache.dart';
import 'package:flame/components.dart';
import 'package:ranch_components/gen/assets.gen.dart';

/// Type of food.
enum FoodType {
  /// Cake type.
  cake,

  /// Lollipop type.
  lollipop,

  /// Pancake type.
  pancake,

  /// Ice cream type.
  iceCream;
}

/// NOTE: This should be a 2.17 enum constructor but guess what, coverage
/// doesn't work for that, see: https://github.com/dart-lang/coverage/issues/386
extension FoodTypeX on FoodType {
  /// The nutrition value of the food.
  double get nutrition {
    switch (this) {
      case FoodType.cake:
        return 1;
      case FoodType.lollipop:
        return 2;
      case FoodType.pancake:
        return 3;
      case FoodType.iceCream:
        return 4;
    }
  }

  /// The rarity of the food.
  ///
  /// Each food type has a rarity percentage between 0 and 100, where 0 is the
  /// most rare and 100 is the most common.
  ///
  /// The rarity of a food is used to determine the chance of it being spawned.
  int get rarity {
    switch (this) {
      case FoodType.cake:
        return 40;
      case FoodType.lollipop:
        return 30;
      case FoodType.pancake:
        return 20;
      case FoodType.iceCream:
        return 10;
    }
  }

  /// The size in which the food component shall assime
  Vector2 get size {
    switch (this) {
      case FoodType.lollipop:
        return Vector2(36.4, 66.5);
      case FoodType.pancake:
        return Vector2(75, 38.6);
      case FoodType.iceCream:
        return Vector2(39.2, 70);
      case FoodType.cake:
        return Vector2(43.9, 69.1);
    }
  }
}

/// {@template food_component}
/// A component that represents a food.
/// {@endtemplate}
class FoodComponent extends SpriteComponent with HasGameRef {
  FoodComponent._({
    required this.type,
    required this.spritePath,
  }) : super(size: type.size);

  /// {@macro food_component}
  factory FoodComponent.ofType(FoodType foodType) {
    switch (foodType) {
      case FoodType.cake:
        return FoodComponent._(
          type: foodType,
          spritePath: Assets.food.cake.keyName,
        );

      case FoodType.lollipop:
        return FoodComponent._(
          type: foodType,
          spritePath: Assets.food.lollipop.keyName,
        );
      case FoodType.pancake:
        return FoodComponent._(
          type: foodType,
          spritePath: Assets.food.pancakes.keyName,
        );
      case FoodType.iceCream:
        return FoodComponent._(
          type: foodType,
          spritePath: Assets.food.icecream.keyName,
        );
    }
  }

  /// Preload all background assets into [images].
  static Future<void> preloadAssets(Images images) async {
    await images.loadAll([
      Assets.food.icecream.keyName,
      Assets.food.cake.keyName,
      Assets.food.lollipop.keyName,
      Assets.food.pancakes.keyName,
    ]);
  }

  /// The path to the sprite
  final String spritePath;

  /// The type of food.
  final FoodType type;

  @override
  Future<void>? onLoad() async {
    sprite = await gameRef.loadSprite(spritePath);
  }
}
