import 'dart:ui';

import 'package:dashbook/dashbook.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:ranch_components/ranch_components.dart';

class EvolveComponentExample extends FlameGame {
  EvolveComponentExample() {
    images.prefix = '';
    Flame.images.prefix = '';
  }

  @override
  Future<void> onLoad() async {
    await add(
      PositionComponent(
        position: size / 2,
        children: [
          BabyUnicornComponent()..anchor = Anchor.bottomCenter,
        ],
      ),
    );
  }

  void evolve() {
    final entity = firstChild<PositionComponent>()!;
    final child = entity.firstChild<PositionComponent>()!;

    late PositionComponent to;

    if (child is BabyUnicornComponent) {
      to = ChildUnicornComponent()..anchor = Anchor.bottomCenter;
    } else if (child is ChildUnicornComponent) {
      to = TeenUnicornComponent()..anchor = Anchor.bottomCenter;
    } else if (child is TeenUnicornComponent) {
      to = AdultUnicornComponent()..anchor = Anchor.bottomCenter;
    } else if (child is AdultUnicornComponent) {
      to = BabyUnicornComponent()..anchor = Anchor.bottomCenter;
    }

    entity.add(
      Evolution(
        from: child,
        to: to,
      ),
    );
  }

  @override
  Color backgroundColor() => const Color(0xFF52C1B1);
}

void addEvolveComponentStories(Dashbook dashbook) {
  dashbook.storiesOf('EvolveComponent').add(
    'basic',
    (context) {
      final game = EvolveComponentExample();
      context.action('evolve', (_) {
        game.evolve();
      });

      return GameWidget(game: game);
    },
  );
}
