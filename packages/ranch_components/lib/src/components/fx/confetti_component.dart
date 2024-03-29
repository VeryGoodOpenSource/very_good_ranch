import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/particles.dart';
import 'package:flutter/material.dart';

/// {@template confetti_component}
/// A component that spawns confetti at a given position.
/// {@endtemplate}
class ConfettiComponent extends PositionComponent {
  /// {@macro confetti_component}
  ConfettiComponent({
    super.position,
    required this.confettiSize,
    this.maxLifespan = .8,
    super.priority,
  });

  /// The size of the confetti.
  final double confettiSize;

  /// The max possible lifespan value of a confetti particle. (In seconds).
  final double maxLifespan;

  @override
  Future<void> onLoad() async {
    final random = Random();
    final noiseValue = confettiSize / 2;
    final noise = Tween<double>(begin: -noiseValue, end: noiseValue);

    await addAll([
      for (var i = 0; i < Colors.accents.length; i++)
        ParticleSystemComponent(
          particle: Particle.generate(
            count: 30,
            lifespan: (maxLifespan * .6) +
                min(
                  maxLifespan * .4,
                  random.nextDouble() * maxLifespan,
                ),
            generator: (p) {
              final xDirection = noise.transform(random.nextDouble());
              return MovingParticle(
                curve: Curves.decelerate,
                to: Vector2(
                      xDirection,
                      random.nextDouble() * -noiseValue,
                    ) *
                    p.toDouble(),
                child: RotatingParticle(
                  to: xDirection > 0 ? -pi / 2 : pi / 2,
                  child: ComponentParticle(
                    component: RectangleComponent(
                      anchor: Anchor.center,
                      size: Vector2(confettiSize, confettiSize) *
                          max(
                            0.2,
                            random.nextDouble(),
                          ),
                      paint: Paint()..color = Colors.accents[i],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
    ]);
  }

  @override
  void update(double dt) {
    if (children.isEmpty) {
      removeFromParent();
    }
  }
}
