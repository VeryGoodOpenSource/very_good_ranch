import 'dart:math';

import 'package:flame/extensions.dart';
import 'package:flutter/widgets.dart';
import 'package:ranch_components/src/components/background/background_component.dart';
import 'package:ranch_components/src/components/background/background_elements.dart';

/// {@template background_position_delegate}
/// A delegate responsible for defining the position of the several visual
/// elements on a [BackgroundComponent].
/// {@endtemplate}
class BackgroundPositionDelegate {
  /// {@macro background_position_delegate}
  const BackgroundPositionDelegate(
    this._seed,
    this._pastureField, [
    this._config = BackgroundDelegateConfig.def,
  ]);

  final Random _seed;
  final Rect _pastureField;
  final BackgroundDelegateConfig _config;

  /// Get position for the barn.
  Vector2 getPositionForBarn(Vector2 size) {
    final x = _pastureField.left;
    final y = _pastureField.top - 50;
    return Vector2(x, y);
  }

  /// Get position for the sheep.
  Vector2 getPositionForSheep(Vector2 size) {
    final right = _pastureField.right;
    final rangeWidth = _pastureField.width * 0.5;

    final x = right - rangeWidth * 0.8;
    final y = _pastureField.top - 50;
    return Vector2(x, y);
  }

  /// Get position for the small sheep.
  Vector2 getPositionForSheepSmall(Vector2 size) {
    final right = _pastureField.right;
    final rangeWidth = _pastureField.width * 0.5;

    final x = right - rangeWidth * 0.2;
    final y = _pastureField.top - 70;
    return Vector2(x, y);
  }

  /// Get position for the cow.
  Vector2 getPositionForCow(Vector2 size) {
    final right = _pastureField.right;
    final rangeWidth = _pastureField.width * 0.5;

    final x = right - rangeWidth * 0.5;
    final y = _pastureField.top - 80;
    return Vector2(x, y);
  }

  /// Calls [positionTree] to each tree that should be placed in the
  /// background with the corresponding position and tree type.
  List<E> positionSideTrees<E>({
    required double minX,
    required double maxX,
    required E Function(BackgroundTreeType, Vector2) positionTree,
  }) {
    final types = _getTypesOfSideTrees();

    final trees = <E>[];
    for (var i = 0; i < types.length; i++) {
      final type = types[i];
      final position = _getPositionForSideTree(i, minX, maxX);
      trees.add(positionTree(type, position));
    }
    return trees;
  }

  List<BackgroundTreeType> _getTypesOfSideTrees() {
    final sideTreesSpacing = _config.sideTreesSpacing;

    final numTrees = (_pastureField.height / sideTreesSpacing).floor();

    const types = BackgroundTreeType.values;

    return List.generate(numTrees, (index) {
      return types[_seed.nextInt(types.length)];
    });
  }

  Vector2 _getPositionForSideTree(
    int index,
    double minX,
    double maxX,
  ) {
    final sideTreesSpacing = _config.sideTreesSpacing;

    final baseY = _pastureField.top + index * sideTreesSpacing;
    final variationY = _seed.nextDouble() * sideTreesSpacing;

    final y = baseY + variationY;

    final variationX = _seed.nextDouble() * (maxX - minX);
    final x = minX + variationX;

    return Vector2(x, y);
  }

  /// Get positions for all the grasses
  List<Vector2> getPositionsForGrasses(Vector2 size) {
    final numGrass =
        (_pastureField.width * _pastureField.height / _config.grassScatter)
            .floor();

    final res = <Vector2>[];
    for (var i = 0; i < numGrass; i++) {
      final position = Vector2.random(_seed)
        ..multiply(
          _pastureField.size.toVector2(),
        );
      res.add(_pastureField.topLeft.toVector2() + position);
    }

    return res;
  }

  /// Get positions for the lone flowers
  List<Vector2> getPositionsForFlowerSolo(Vector2 size) {
    final numflowers = _config.numFlowersSolo;
    final res = <Vector2>[];
    for (var i = 0; i < numflowers; i++) {
      final position = Vector2.random(_seed)
        ..multiply(
          _pastureField.size.toVector2(),
        );
      res.add(_pastureField.topLeft.toVector2() + position);
    }

    return res;
  }

  /// Get positions for the duo flowers
  List<Vector2> getPositionsForFlowerDuo(Vector2 size) {
    final numflowers = _config.numFlowersDuo;
    final res = <Vector2>[];
    for (var i = 0; i < numflowers; i++) {
      final position = Vector2.random(_seed)
        ..multiply(
          _pastureField.size.toVector2(),
        );
      res.add(_pastureField.topLeft.toVector2() + position);
    }

    return res;
  }

  /// Get positions for the groups of flowers
  List<Vector2> getPositionsForFlowerGroup(Vector2 size) {
    final numGroup = _config.numFlowersGroup;
    final res = <Vector2>[];
    for (var i = 0; i < numGroup; i++) {
      final position = Vector2.random(_seed)
        ..multiply(
          _pastureField.size.toVector2(),
        );
      res.add(_pastureField.topLeft.toVector2() + position);
    }

    return res;
  }
}

/// {@template background_delegate_config}
/// A config for the [BackgroundPositionDelegate].
/// Defaults to [BackgroundDelegateConfig.def];
/// {@endtemplate}
@immutable
class BackgroundDelegateConfig {
  /// {@macro background_delegate_config}
  const BackgroundDelegateConfig({
    required this.sideTreesSpacing,
    required this.grassScatter,
    required this.numFlowersSolo,
    required this.numFlowersDuo,
    required this.numFlowersGroup,
  });

  /// The default configuration for
  static const def = BackgroundDelegateConfig(
    sideTreesSpacing: 200,
    grassScatter: 20000,
    numFlowersSolo: 6,
    numFlowersDuo: 3,
    numFlowersGroup: 2,
  );

  /// The mean spacing between trees to the sides.
  final double sideTreesSpacing;

  /// How much scattered the grasses should be.
  final double grassScatter;

  /// How many lone flowers should be there.
  final int numFlowersSolo;

  /// How many duo flowers should be there.
  final int numFlowersDuo;

  /// How many groups of flowers should be there.
  final int numFlowersGroup;
}
