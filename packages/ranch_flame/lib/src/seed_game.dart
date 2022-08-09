import 'dart:math';

import 'package:flame/game.dart';

/// A  mixin for [FlameGame] subclasses that have a [Random] seed.
mixin SeedGame on FlameGame {
  /// The random number generator for a game, allowing it to be seed-able.
  Random get seed;
}
