import 'package:dashbook/dashbook.dart';
import 'package:flame/game.dart';
import 'package:ranch_components/ranch_components.dart';
import 'package:sandbox/common/common.dart';

void addRanchBackgroundComponentStories(Dashbook dashbook) {
  dashbook.storiesOf('RanchBackgroundComponent').add(
    'type',
    (context) {
      final unicornX = context.numberProperty('unicorn x', 350);
      final unicornY = context.numberProperty('unicorn y', 1200);
      final unicorn = AdultUnicornComponent()..position = Vector2(unicornX, unicornY);
      return GameWidget(
        game: StoryGame(
          RanchBackgroundComponent(children: [
            unicorn
          ]),
        ),
      );
    },
    info: '''
      The RanchBackgroundComponent is a component that render the geenral 
      background of a farm and defines a pasture area

      - It can accommodate unicorns
''',
  );
}
