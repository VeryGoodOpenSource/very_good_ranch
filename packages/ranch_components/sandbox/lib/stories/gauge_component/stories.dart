import 'package:dashbook/dashbook.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:ranch_components/ranch_components.dart';
import 'package:sandbox/common/common.dart';

void addGaugeComponentStories(Dashbook dashbook) {
  dashbook.storiesOf('GaugeComponent').add(
    'basic',
    (context) {
      final innerGauge = GaugeComponent(
        position: Vector2.zero(),
        size: 100,
        thickness: 20,
        percentage: double.tryParse(context.textProperty('inner', '0.9')) ?? 1,
        color: Colors.lightBlue,
      );

      final outerGauge = GaugeComponent(
        position: Vector2.zero(),
        size: 120,
        thickness: 20,
        percentage: double.tryParse(context.textProperty('outer', '0.7')) ?? 1,
        color: Colors.pink,
      );

      context
        ..action('increase inner', (_) {
          if (innerGauge.percentage == 1) return;
          innerGauge.percentage += 0.1;
        })
        ..action('decrease inner', (_) {
          if (innerGauge.percentage == 0) return;
          innerGauge.percentage -= 0.1;
        })
        ..action('increase outer', (_) {
          if (outerGauge.percentage == 1) return;
          outerGauge.percentage += 0.1;
        })
        ..action('decrease outer', (_) {
          if (outerGauge.percentage == 0) return;
          outerGauge.percentage -= 0.1;
        });

      return GameWidget(
        game: StoryGame(
          PositionComponent(
            children: [
              outerGauge,
              innerGauge,
            ],
          ),
        ),
      );
    },
    info: '''
    The Gauge is a component that can represet a progress of any kind.
''',
  );
}
