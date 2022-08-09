import 'package:flame/components.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ranch_components/ranch_components.dart';

void main() {
  group('RainbowDrop', () {
    testWithFlameGame('adds the target in the game', (game) async {
      await game.ensureAdd(
        RainbowDrop(
          position: Vector2(0, 0),
          target: CircleComponent(radius: 50),
        ),
      );

      await Future<void>.delayed(const Duration(milliseconds: 600));
      await game.ready();

      expect(
        game.descendants().whereType<CircleComponent>().length,
        greaterThan(0),
      );
    });

    testWithFlameGame('adds a confetti in the game', (game) async {
      await game.ensureAdd(
        RainbowDrop(
          position: Vector2(0, 0),
          target: CircleComponent(radius: 50),
        ),
      );

      await Future<void>.delayed(const Duration(milliseconds: 600));
      await game.ready();

      expect(
        game.descendants().whereType<ConfettiComponent>().length,
        greaterThan(0),
      );
    });

    testWithFlameGame('is removed once finished', (game) async {
      await game.ensureAdd(
        RainbowDrop(
          position: Vector2(0, 0),
          target: CircleComponent(radius: 50),
        ),
      );

      await Future<void>.delayed(const Duration(milliseconds: 600));
      await game.ready();

      expect(
        game.descendants().whereType<RainbowDrop>().length,
        equals(0),
      );
    });
  });
}
