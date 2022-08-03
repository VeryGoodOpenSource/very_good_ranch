import 'package:flame/components.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ranch_components/ranch_components.dart';

void main() {
  group('ConfettiComponent', () {
    testWithFlameGame('creates particles on load', (game) async {
      await game.ensureAdd(ConfettiComponent(confettiSize: 10));

      expect(
        game.descendants().whereType<ParticleSystemComponent>().length,
        greaterThan(0),
      );
    });

    testWithFlameGame(
      'is removed after all particles have expired',
      (game) async {
        await game.ensureAdd(ConfettiComponent(confettiSize: 10));

        expect(
          game.descendants().whereType<ParticleSystemComponent>().length,
          greaterThan(0),
        );

        game
          ..updateTree(2) // Runs enough time for the particles to expire.
          ..updateTree(0); // Component is removed on the next tick.
        await game.ready();

        expect(
          game.children.length,
          0,
        );
      },
    );
  });
}
