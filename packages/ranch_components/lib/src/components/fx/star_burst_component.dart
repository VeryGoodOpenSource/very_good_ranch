import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/particles.dart';
import 'package:flutter/material.dart';

/// {@template star_burst_component}
/// A component that spawns star_burst at a given position.
/// {@endtemplate}
class StarBurstComponent extends PositionComponent {
  /// {@macro star_burst_component}
  StarBurstComponent({
    super.position,
    required this.starSize,
    this.maxLifespan = 1,
    super.priority,
  });

  /// The size of the star_burst.
  final double starSize;

  /// The max possible lifespan value of a star particle. (In seconds).
  final double maxLifespan;

  @override
  Future<void> onLoad() async {
    final random = Random();
    final noiseValue = starSize;
    final noise = Tween<double>(begin: -noiseValue, end: noiseValue);

    const burstCount = 4;

    await addAll([
      for (var i = 0; i < burstCount; i++)
        ParticleSystemComponent(
          particle: Particle.generate(
            count: 5,
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
                    component: Star(starSize * min(0.4, random.nextDouble())),
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

/// {@template star}
/// A component that renders a star.
/// {@endtemplate}
class Star extends PositionComponent {
  /// {@macro star}
  Star(double starSize) {
    final smallR = starSize / 4;
    final bigR = starSize / 2;
    const tau = 2 * pi;
    _shape = Path()..moveTo(bigR, 0);
    for (var i = 1; i < 10; i++) {
      final r = i.isEven ? bigR : smallR;
      final a = i / 10 * tau;
      _shape.lineTo(r * cos(a), r * sin(a));
    }
    _shape.close();
  }

  late final Path _shape;
  late final Paint _paint = Paint()..color = const Color(0x88FFD645);

  @override
  void render(Canvas canvas) {
    canvas.drawPath(_shape, _paint);
  }
}
