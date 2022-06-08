import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/widgets.dart';
import 'package:ranch_components/gen/assets.gen.dart';

class RanchBackgroundElementsPositioner {
  const RanchBackgroundElementsPositioner({
    required this.seed,
    required this.pastureArea,
  });

  final Random seed;
  final Rect pastureArea;

  Vector2 getPositionForBarn() {
    return Vector2(30, 30);
  }

  Vector2 getPositionForTreeTrio1(Vector2 size) {
    return Vector2(
      pastureArea.right - size.x - 10,
      pastureArea.top - size.y,
    );
  }

  Vector2 getPositionForTreeTrio2(Vector2 size) {
    final xOffset = pastureArea.width / 2 * seed.nextDouble();
    return Vector2(
      pastureArea.left + xOffset,
      pastureArea.bottom - size.y + 10,
    );
  }

  Vector2 getPositionForTreeTrio3(Vector2 size) {
    final xOffset = pastureArea.width / 2 * seed.nextDouble();
    return Vector2(
      pastureArea.right - size.x - xOffset,
      pastureArea.bottom - size.y + 25,
    );
  }

  List<Vector2> getPositionsForLeftSideTrees(Vector2 size) {
    final numTrees = (pastureArea.height / 100).floor();

    final res = <Vector2>[];
    for (var i = 0; i < numTrees; i++) {
      final base = i * 100;
      final variation = seed.nextDouble() * 100;

      final y = pastureArea.top + base + variation;

      final x = pastureArea.left - (i.isEven ? 5.0 : 15.0);

      res.add(Vector2(x, y));
    }

    return res;
  }

  List<Vector2> getPositionsForRightSideTrees(Vector2 size) {
    final numTrees = (pastureArea.height / 100).floor();

    final res = <Vector2>[];
    for (var i = 0; i < numTrees; i++) {
      final base = i * 100;
      final variation = seed.nextDouble() * 100;
      final y = pastureArea.top + base + variation;

      final x = pastureArea.right - size.x + (i.isEven ? 5.0 : 15.0);

      res.add(pastureArea.topLeft.toVector2() + Vector2(x, y));
    }

    return res;
  }

  List<Vector2> getPositionsForGrasses(Vector2 size) {
    final numGrass = (pastureArea.width * pastureArea.height / 20000).floor();

    final res = <Vector2>[];
    for (var i = 0; i < numGrass; i++) {
      final position = Vector2.random(seed)
        ..multiply(
          pastureArea.size.toVector2(),
        );
      res.add(pastureArea.topLeft.toVector2() + position);
    }

    return res;
  }

  List<Vector2> getPositionsForFlowerSolo(Vector2 size) {
    final numflowers = 6;
    final res = <Vector2>[];
    for (var i = 0; i < numflowers; i++) {
      final position = Vector2.random(seed)
        ..multiply(
          pastureArea.size.toVector2(),
        );
      res.add(pastureArea.topLeft.toVector2() + position);
    }

    return res;
  }

  List<Vector2> getPositionsForFlowerDuo(Vector2 size) {
    final numflowers = 4;
    final res = <Vector2>[];
    for (var i = 0; i < numflowers; i++) {
      final position = Vector2.random(seed)
        ..multiply(
          pastureArea.size.toVector2(),
        );
      res.add(pastureArea.topLeft.toVector2() + position);
    }

    return res;
  }

  List<Vector2> getPositionsForFlowerGroup(Vector2 size) {
    final numGroup = 2;
    final res = <Vector2>[];
    for (var i = 0; i < numGroup; i++) {
      final position = Vector2.random(seed)
        ..multiply(
          pastureArea.size.toVector2(),
        );
      res.add(pastureArea.topLeft.toVector2() + position);
    }

    return res;
  }
}

class RanchBackgroundComponent extends PositionComponent
    with HasGameRef, HasPaint {
  RanchBackgroundComponent({super.children, this.positioner});

  RanchBackgroundElementsPositioner? positioner;

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

    final positioner = this.positioner ??= RanchBackgroundElementsPositioner(
      seed: Random(),
      pastureArea: Rect.fromPoints(
        pastureAreaPosition.toOffset(),
        pastureAreaPosition.toOffset() + pastureAreaSize.toOffset(),
      ),
    );

    // Add barn
    await add(Barn(position: positioner.getPositionForBarn())..priority = -1);

    // Add 3 tree trios:
    // one at the top
    await add(
      TreeTrio(
        position: positioner.getPositionForTreeTrio1(TreeTrio.dimensions),
      )..priority = -1,
    );

    // one at bottom left
    await add(
      TreeTrio(
        position: positioner.getPositionForTreeTrio2(TreeTrio.dimensions),
      ),
    );

    // one at bottom left
    await add(
      TreeTrio(
        position: positioner.getPositionForTreeTrio3(TreeTrio.dimensions),
      ),
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
        positioner.getPositionsForRightSideTrees(TreeShort.dimensions);
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
        )..priority = -1,
      );
    }

    // Add flowers solo
    final soloFlowersPositions =
        positioner.getPositionsForFlowerSolo(FlowerSolo.dimensions);
    for (final soloFlowersPosition in soloFlowersPositions) {
      await add(
        FlowerSolo(
          position: soloFlowersPosition,
        )..priority = -1,
      );
    }

    // Add flowers duo
    final duoFlowersPositions =
        positioner.getPositionsForFlowerDuo(FlowerDuo.dimensions);
    for (final duoFlowersPosition in duoFlowersPositions) {
      await add(
        FlowerDuo(
          position: duoFlowersPosition,
        )..priority = -1,
      );
    }

    // Add groups of flowers
    final flowerGroupPositions =
        positioner.getPositionsForFlowerDuo(FlowerGroup.dimensions);
    for (final flowerGroupPosition in flowerGroupPositions) {
      await add(
        FlowerGroup(
          position: flowerGroupPosition,
        )..priority = -1,
      );
    }
  }

  void render(Canvas canvas) {
    final pastureRect = Rect.fromPoints(
      pastureAreaPosition.toOffset(),
      pastureAreaPosition.toOffset() + pastureAreaSize.toOffset(),
    );
    //canvas.drawRect(pastureRect, paint);
  }
}

class Barn extends SpriteComponent with HasGameRef {
  Barn({super.position}) : super(size: Vector2(220.5, 140.0));

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
