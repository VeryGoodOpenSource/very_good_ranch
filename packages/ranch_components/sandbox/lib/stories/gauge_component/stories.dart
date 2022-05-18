import 'package:dashbook/dashbook.dart';
import 'package:flame/game.dart';
import 'package:ranch_components/ranch_components.dart';
import 'package:sandbox/common/common.dart';

void addGaugeComponentStories(Dashbook dashbook) {
  dashbook.storiesOf('GaugeComponent').add(
    'basic',
    (context) {
      final gauge = GaugeComponent(
        position: Vector2.zero(),
        size: 100,
        percent: double.tryParse(context.textProperty('percent', '0.5')) ?? 1,
      );

      context
        ..action('increase', (_) {
          if (gauge.percent == 1) return;
          gauge.percent += 0.1;
        })
        ..action('decrease', (_) {
          if (gauge.percent == 0) return;
          gauge.percent -= 0.1;
        });

      return GameWidget(
        game: StoryGame(gauge),
      );
    },
    info: '''
    The Gauge is a component that can represet a progress of any kind.
''',
  );
}
