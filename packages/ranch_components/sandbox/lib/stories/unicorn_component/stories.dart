import 'package:dashbook/dashbook.dart';
import 'package:flame/game.dart';
import 'package:ranch_components/ranch_components.dart';
import 'package:sandbox/common/common.dart';

void addUnicornComponentStories(Dashbook dashbook) {
  dashbook.storiesOf('UnicornComponent').add(
    'idle',
    (context) {
      return GameWidget(
        game: StoryGame(
          UnicornComponent(position: Vector2.zero()),
        ),
      );
    },
    info: '''
      The UnicornComponent is a component that represents a unicorn.
''',
  ).add(
    'roaming',
    (context) {
      final unicorn = UnicornComponent(position: Vector2.zero());
      unicorn.current = UnicornState.roaming;

      return GameWidget(
        game: StoryGame(unicorn),
      );
    },
    info: '''
      The UnicornComponent is a component that represents a unicorn.
''',
  );
}
