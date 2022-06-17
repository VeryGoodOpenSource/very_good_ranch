import 'dart:math';

import 'package:flame/extensions.dart';
import 'package:flutter/widgets.dart';
import 'package:ranch_components/src/components/background/background_component.dart';

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
    final y = _pastureField.top - size.y;
    return Vector2(x, y);
  }

  /// Get position for the first tree trio.
  Vector2 getPositionForTreeTrio1(Vector2 size) {
    return Vector2(
      _pastureField.right - size.x - 50,
      _pastureField.top - size.y,
    );
  }

  /// Get position for the second tree trio.
  Vector2 getPositionForTreeTrio2(Vector2 size) {
    final xOffset = _pastureField.width / 2 * _seed.nextDouble();
    return Vector2(
      _pastureField.left + xOffset,
      _pastureField.bottom - size.y + 10,
    );
  }

  /// Get position for the third tree trio.
  Vector2 getPositionForTreeTrio3(Vector2 size) {
    final xOffset = _pastureField.width / 2 * _seed.nextDouble();
    return Vector2(
      _pastureField.right - size.x - xOffset,
      _pastureField.bottom - size.y + 25,
    );
  }

  List<Vector2> _getPositionsForSideTrees(
    Vector2 size,
    double minX,
    double maxX,
  ) {
    final sideTreesSpacing = _config.sideTreesSpacing;
    final numTrees = (_pastureField.height / sideTreesSpacing).floor();

    final res = <Vector2>[];
    for (var i = 0; i < numTrees; i++) {
      final baseY = _pastureField.top + i * sideTreesSpacing;
      final variationY = _seed.nextDouble() * sideTreesSpacing;

      final y = baseY + variationY;

      final variationX = _seed.nextDouble() * (maxX - minX);
      final x = minX + variationX;

      res.add(Vector2(x, y));
    }

    return res;
  }

  /// Get positions for the trees to the left
  List<Vector2> getPositionsForLeftSideTrees(Vector2 size) {
    const minX = 0.0;
    final maxX = _pastureField.left - size.x;

    return _getPositionsForSideTrees(size, minX, maxX);
  }

  /// Get positions for the trees to the right
  List<Vector2> getPositionsForRightSideTrees(Vector2 size, double maxX) {
    final minX = _pastureField.right;

    return _getPositionsForSideTrees(size, minX, maxX - size.x);
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
    sideTreesSpacing: 150,
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
