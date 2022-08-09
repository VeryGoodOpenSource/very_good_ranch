import 'dart:math';
import 'dart:ui';

import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:ranch_flame/ranch_flame.dart';

class TestGame extends FlameGame
    with HasTappables, HasDraggables, HasCollisionDetection, SeedGame {
  TestGame() {
    images.prefix = '';
    Flame.images.prefix = '';
  }

  @override
  final seed = Random();

  @override
  Color backgroundColor() => const Color(0xFFFFFFFF);
}
