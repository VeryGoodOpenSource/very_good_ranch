import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ranch_components/src/components/gauge_component.dart';

import '../helpers/test_game.dart';

class SquareComponent extends PositionComponent {
  SquareComponent({
    super.position,
    super.size,
    super.scale,
    super.angle,
    super.anchor,
    super.children,
    super.priority,
  });

  @override
  void render(Canvas canvas) {
    canvas.drawRect(size.toRect(), debugPaint);
    super.render(canvas);
  }
}

void main() {
  final flameTester = FlameTester(() => TestGame(center: true));

  group('GaugeComponent', () {
    group('style', () {
      group('sets default style', () {
        flameTester.testGameWidget(
          'for all levels',
          setUp: (game, tester) async {
            await game.add(
              SquareComponent(
                children: [
                  GaugeComponent(
                    percentages: [
                      () => 0.0,
                      () => 0.25,
                      () => 0.50,
                      () => 0.75,
                      () => 1.0,
                    ],
                  )
                ],
              ),
            );
          },
          verify: (game, tester) async {
            await expectLater(
              find.byGame<TestGame>(),
              matchesGoldenFile('golden/gauge_component/default_style.png'),
            );
          },
        );
      });
      group('sets custom style', () {
        flameTester.testGameWidget(
          'for all levels',
          setUp: (game, tester) async {
            await game.add(
              SquareComponent(
                children: [
                  GaugeComponent(
                    foregroundColorGetter: (percentage) {
                      if (percentage > 0.66) return const Color(0xFF00FF89);
                      if (percentage > 0.33) return const Color(0xFF2000A0);

                      return const Color(0xFFFF00B2);
                    },
                    inactiveForegroundColor: const Color(0xFF444444),
                    backgroundColor: const Color(0xFF000000),
                    marginExtent: 4,
                    gaugeHeight: 6,
                    overallWidth: 100,
                    borderRadius: 1,
                    percentages: [
                      () => 0.0,
                      () => 0.25,
                      () => 0.50,
                      () => 0.75,
                      () => 1.0,
                    ],
                  )
                ],
              ),
            );
          },
          verify: (game, tester) async {
            await expectLater(
              find.byGame<TestGame>(),
              matchesGoldenFile('golden/gauge_component/custom_style.png'),
            );
          },
        );
      });
    });
    group('positionGetter', () {
      flameTester.testGameWidget(
        'positions from parent',
        setUp: (game, tester) async {
          await game.add(
            SquareComponent(
              position: Vector2.all(20),
              size: Vector2.all(100),
              children: [
                GaugeComponent(
                  positionGetter: (GaugeComponent thisGauge) =>
                      thisGauge.parent.positionOfAnchor(Anchor.bottomCenter),
                  percentages: [
                    () => 0.50,
                    () => 1.0,
                  ],
                )
              ],
            ),
          );
        },
        verify: (game, tester) async {
          await tester.pump();
          await expectLater(
            find.byGame<TestGame>(),
            matchesGoldenFile('golden/gauge_component/position_getter.png'),
          );
        },
      );
      group('offset', () {
        flameTester.testGameWidget(
          'positions from parent with an offset',
          setUp: (game, tester) async {
            await game.add(
              SquareComponent(
                position: Vector2.all(20),
                size: Vector2.all(100),
                children: [
                  GaugeComponent(
                    positionGetter: (GaugeComponent thisGauge) =>
                        thisGauge.parent.positionOfAnchor(Anchor.bottomCenter),
                    offset: Vector2(100, 100),
                    percentages: [
                      () => 0.50,
                      () => 1.0,
                    ],
                  )
                ],
              ),
            );
          },
          verify: (game, tester) async {
            await tester.pump();
            await expectLater(
              find.byGame<TestGame>(),
              matchesGoldenFile(
                'golden/gauge_component/position_getter_offset.png',
              ),
            );
          },
        );
      });
    });
    group('visibilityPredicate', () {
      var visible = true;
      flameTester.testGameWidget(
        'shows component depending on predicate',
        setUp: (game, tester) async {
          await game.add(
            SquareComponent(
              children: [
                GaugeComponent(
                  visibilityPredicate: () => visible,
                  percentages: [
                    () => 0.50,
                    () => 1.0,
                  ],
                )
              ],
            ),
          );
        },
        verify: (game, tester) async {
          visible = true;
          await expectLater(
            find.byGame<TestGame>(),
            matchesGoldenFile(
              'golden/gauge_component/visibility_visible.png',
            ),
          );

          visible = false;
          await tester.pump();
          await expectLater(
            find.byGame<TestGame>(),
            matchesGoldenFile(
              'golden/gauge_component/visibility_invisible.png',
            ),
          );
        },
      );
    });
  });
}
