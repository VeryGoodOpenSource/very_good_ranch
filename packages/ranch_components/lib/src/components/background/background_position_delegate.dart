import 'dart:math';

import 'package:flame/extensions.dart';
import 'package:flutter/widgets.dart';
import 'package:ranch_components/src/components/background/background_component.dart';

/// A delegate responsible for defining the position of the several visual
/// elements on a [BackgroundComponent].
class BackgroundPositionDelegate {
  const BackgroundPositionDelegate({
    required this.seed,
    required this.pastureField,
    this.config = RanchBackgroundConfig.def,
  });

  final Random seed;
  final Rect pastureField;
  final RanchBackgroundConfig config;

  Vector2 getPositionForBarn() {
    return Vector2(30, 30);
  }

  Vector2 getPositionForTreeTrio1(Vector2 size) {
    return Vector2(
      pastureField.right - size.x - 10,
      pastureField.top - size.y,
    );
  }

  Vector2 getPositionForTreeTrio2(Vector2 size) {
    final xOffset = pastureField.width / 2 * seed.nextDouble();
    return Vector2(
      pastureField.left + xOffset,
      pastureField.bottom - size.y + 10,
    );
  }

  Vector2 getPositionForTreeTrio3(Vector2 size) {
    final xOffset = pastureField.width / 2 * seed.nextDouble();
    return Vector2(
      pastureField.right - size.x - xOffset,
      pastureField.bottom - size.y + 25,
    );
  }

  List<Vector2> _getPositionsForSideTrees(
    Vector2 size,
    double minX,
    double maxX,
  ) {
    final sideTreesSpacing = config.sideTreesSpacing;
    final numTrees = (pastureField.height / sideTreesSpacing).floor();

    final res = <Vector2>[];
    for (var i = 0; i < numTrees; i++) {
      final baseY = pastureField.top + i * sideTreesSpacing;
      final variationY = seed.nextDouble() * sideTreesSpacing;

      final y = baseY + variationY;

      final variationX = seed.nextDouble() * (maxX - minX);
      final x = minX + variationX;

      res.add(Vector2(x, y));
    }

    return res;
  }

  List<Vector2> getPositionsForLeftSideTrees(Vector2 size) {
    const minX = 0.0;
    final maxX = pastureField.left - size.x;

    return _getPositionsForSideTrees(size, minX, maxX);
  }

  List<Vector2> getPositionsForRightSideTrees(Vector2 size, double maxX) {
    final minX = pastureField.right;

    return _getPositionsForSideTrees(size, minX, maxX - size.x);
  }

  List<Vector2> getPositionsForGrasses(Vector2 size) {
    final numGrass =
        (pastureField.width * pastureField.height / config.grassScatter).floor();

    final res = <Vector2>[];
    for (var i = 0; i < numGrass; i++) {
      final position = Vector2.random(seed)
        ..multiply(
          pastureField.size.toVector2(),
        );
      res.add(pastureField.topLeft.toVector2() + position);
    }

    return res;
  }

  List<Vector2> getPositionsForFlowerSolo(Vector2 size) {
    final numflowers = config.numFlowersSolo;
    final res = <Vector2>[];
    for (var i = 0; i < numflowers; i++) {
      final position = Vector2.random(seed)
        ..multiply(
          pastureField.size.toVector2(),
        );
      res.add(pastureField.topLeft.toVector2() + position);
    }

    return res;
  }

  List<Vector2> getPositionsForFlowerDuo(Vector2 size) {
    final numflowers = config.numFlowersDuo;
    final res = <Vector2>[];
    for (var i = 0; i < numflowers; i++) {
      final position = Vector2.random(seed)
        ..multiply(
          pastureField.size.toVector2(),
        );
      res.add(pastureField.topLeft.toVector2() + position);
    }

    return res;
  }

  List<Vector2> getPositionsForFlowerGroup(Vector2 size) {
    final numGroup = config.numFlowersGroup;
    final res = <Vector2>[];
    for (var i = 0; i < numGroup; i++) {
      final position = Vector2.random(seed)
        ..multiply(
          pastureField.size.toVector2(),
        );
      res.add(pastureField.topLeft.toVector2() + position);
    }

    return res;
  }
}

@immutable
class RanchBackgroundConfig {
  const RanchBackgroundConfig({
    required this.sideTreesSpacing,
    required this.grassScatter,
    required this.numFlowersSolo,
    required this.numFlowersDuo,
    required this.numFlowersGroup,
  });

  static const def = RanchBackgroundConfig(
    sideTreesSpacing: 150,
    grassScatter: 20000,
    numFlowersSolo: 6,
    numFlowersDuo: 3,
    numFlowersGroup: 2,
  );

  final double sideTreesSpacing;
  final double grassScatter;
  final int numFlowersSolo;
  final int numFlowersDuo;
  final int numFlowersGroup;
}
