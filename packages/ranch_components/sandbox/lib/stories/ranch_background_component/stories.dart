import 'package:dashbook/dashbook.dart';
import 'package:flame/game.dart';
import 'package:ranch_components/ranch_components.dart';
import 'package:sandbox/common/common.dart';

void addBackgroundComponentStories(Dashbook dashbook) {
  dashbook.storiesOf('BackgroundComponent').add(
    'type',
    (context) {
      final unicornX = context.numberProperty('unicorn x', 350);
      final unicornY = context.numberProperty('unicorn y', 1200);
      final unicorn = AdultUnicornComponent()
        ..position = Vector2(unicornX, unicornY);
      return GameWidget(
        game: StoryGame(
          center: false,
          BackgroundComponent(
            children: [unicorn],
          ),
        ),
      );
    },
    info: '''
      The BackgroundComponent is a component that render the general 
      background of a farm and defines a pasture field

      - It can accommodate unicorns
''',
  );
}
