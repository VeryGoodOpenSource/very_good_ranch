

import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:very_good_ranch/game/entities/entities.dart';

class PetBehavior extends Behavior<Unicorn> with Tappable {

  bool onTapDown(TapDownInfo info) {

    return true;
  }
}