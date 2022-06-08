import 'package:flame/components.dart';
import 'package:flutter/widgets.dart';
import 'package:ranch_components/gen/assets.gen.dart';

class RanchBackgroundComponent extends PositionComponent
    with HasGameRef, HasPaint {
  RanchBackgroundComponent({super.children});

  static const padding = EdgeInsets.only(
    top: 170,
    left: 30,
    right: 30,
    bottom: 30,
  );

  late final Vector2 pastureAreaPosition;
  late final Vector2 pastureAreaSize;

  @override
  Future<void> onLoad() async {
    final gameSize = gameRef.camera.viewport.effectiveSize;
    final paddingDeflection = Vector2(padding.horizontal, padding.vertical);
    final paddingPosition = Vector2(padding.left, padding.top);
    pastureAreaSize = gameSize - paddingDeflection;
    pastureAreaPosition = paddingPosition;

    size = gameRef.size;

    // Add barn at fixed position
    await add(Barn(position: Vector2(30, 30))..priority = -1);
  }

  void render(Canvas canvas) {
    final pastureRect = Rect.fromPoints(
      pastureAreaPosition.toOffset(),
      pastureAreaPosition.toOffset() + pastureAreaSize.toOffset(),
    );
    canvas.drawRect(pastureRect, paint);
  }
}

class Barn extends SpriteComponent with HasGameRef {
  Barn({super.position}) : super(size: Vector2(220.5, 140.0));

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite(Assets.images.barn.packagePath);
  }
}


class Barn extends SpriteComponent with HasGameRef {
  Barn({super.position}) : super(size: Vector2(220.5, 140.0));

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite(Assets.images.barn.packagePath);
  }
}
