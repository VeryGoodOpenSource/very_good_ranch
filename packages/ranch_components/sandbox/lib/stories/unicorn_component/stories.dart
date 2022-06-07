import 'package:dashbook/dashbook.dart';
import 'package:flame/game.dart';
import 'package:ranch_components/ranch_components.dart';
import 'package:sandbox/common/common.dart';

void addUnicornComponentStories(Dashbook dashbook) {
  dashbook.storiesOf('UnicornComponent').add(
    'idle',
    (context) {
      final unicorn = context.listProperty<UnicornComponent>(
        'Unicorn stage',
        BabyUnicornComponent(),
        [
          BabyUnicornComponent(),
          ChildUnicornComponent(),
          TeenUnicornComponent(),
          AdultUnicornComponent(),
        ],
      );

      return GameWidget(
        game: StoryGame(unicorn..current = UnicornState.idle),
      );
    },
    info: '''
      The UnicornComponent is a component that represents a unicorn.
''',
  ).add(
    'roaming',
    (context) {
      final unicorn = context.listProperty<UnicornComponent>(
        'Unicorn stage',
        BabyUnicornComponent(),
        [
          BabyUnicornComponent(),
          ChildUnicornComponent(),
          TeenUnicornComponent(),
          AdultUnicornComponent(),
        ],
      );

      return GameWidget(
        game: StoryGame(unicorn..current = UnicornState.roaming),
      );
    },
    info: '''
      The UnicornComponent is a component that represents a unicorn.
''',
  );
}
