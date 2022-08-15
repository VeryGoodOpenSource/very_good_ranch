import 'dart:math';

import 'package:flame/game.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ranch_flame/src/seed_game.dart';

class _TestSeedGame extends FlameGame with SeedGame {
  @override
  final seed = Random();
}

void main() {
  group('SeedGame', () {
    test('has seed', () {
      expect(_TestSeedGame().seed, isA<Random>());
    });
  });
}
