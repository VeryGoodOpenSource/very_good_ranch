import 'package:dashbook/dashbook.dart';
import 'package:flame/game.dart';
import 'package:ranch_components/ranch_components.dart';
import 'package:sandbox/common/common.dart';

void addGaugeComponentStories(Dashbook dashbook) {
  dashbook.storiesOf('GaugeComponent').add(
    'gauge',
    (context) {
      return GameWidget(
        game: StoryGame(
          ChildUnicornComponent()
            ..add(
              GaugeComponent(
                offset: Vector2(0, 10),
                percentages: [
                  () => 1.0,
                  () => 0.6,
                ],
              ),
            ),
        ),
      );
    },
    info: '''
      The GaugeComponent is a component that shows a set of gauges 
      - It can receive several percentage values. For each, it will show a gauge.
''',
  );
}
