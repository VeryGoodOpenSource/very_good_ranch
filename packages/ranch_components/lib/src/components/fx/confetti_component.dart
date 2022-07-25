import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/particles.dart';
import 'package:flutter/material.dart';

/// {@template confetti_component}
/// A component that spawns confetti at a given position.
/// {@endtemplate}
class ConfettiComponent extends PositionComponent {
  /// {@macro confetti_component}
  ConfettiComponent({super.position, required this.confettiSize});

  /// The size of the confetti.
  final double confettiSize;

  @override
  Future<void> onLoad() async {
    final random = Random();
    final noiseValue = confettiSize / 2;
    final noise = Tween<double>(begin: -noiseValue, end: noiseValue);
    const lifespan = .8;

    await addAll([
      for (var i = 0; i < Colors.accents.length; i++)
        ParticleSystemComponent(
          particle: Particle.generate(
            lifespan: lifespan,
            count: 30,
            generator: (p) {
              return MovingParticle(
                curve: Curves.decelerate,
                to: Vector2(
                      noise.transform(random.nextDouble()),
                      random.nextDouble() * -noiseValue,
                    ) *
                    p.toDouble(),
                child: RotatingParticle(
                  child: ComponentParticle(
                    component: RectangleComponent(
                      anchor: Anchor.center,
                      size: Vector2(confettiSize, confettiSize),
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
