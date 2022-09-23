import 'dart:ui';

import 'package:dashbook/dashbook.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:ranch_components/ranch_components.dart';

class EvolutionComponentExample extends FlameGame {
  EvolutionComponentExample() {
    images.prefix = '';
    Flame.images.prefix = '';
  }

  @override
  Future<void> onLoad() async {
    await add(
      PositionComponent(
        position: size / 2,
        children: [
          BabyUnicornComponent(),
        ],
      ),
    );
  }

  void evolve() {
    final entity = firstChild<PositionComponent>()!;
    final child = entity.firstChild<PositionComponent>()!;

    late PositionComponent to;

    if (child is BabyUnicornComponent) {
      to = ChildUnicornComponent();
    } else if (child is ChildUnicornComponent) {
      to = TeenUnicornComponent();
    } else if (child is TeenUnicornComponent) {
      to = AdultUnicornComponent();
    } else if (child is AdultUnicornComponent) {
      to = BabyUnicornComponent();
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

void addEvolutionComponentStories(Dashbook dashbook) {
  dashbook.storiesOf('Evolution').add(
    'basic',
    (context) {
      final game = EvolutionComponentExample();
      context.action('evolve', (_) {
        game.evolve();
      });

      return GameWidget(game: game);
    },
  );
}
