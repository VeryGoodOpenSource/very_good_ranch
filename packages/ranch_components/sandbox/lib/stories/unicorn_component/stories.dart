import 'package:dashbook/dashbook.dart';
import 'package:flame/game.dart';
import 'package:ranch_components/ranch_components.dart';
import 'package:sandbox/common/common.dart';

void addUnicornComponentStories(Dashbook dashbook) {
  dashbook.storiesOf('UnicornComponent').add(
    'Playground',
    (context) {
      final defaultUnicorn = BabyUnicornComponent();
      final unicorn = context.listProperty<UnicornComponent>(
        'Unicorn stage',
        defaultUnicorn,
        [
          defaultUnicorn,
          ChildUnicornComponent(),
          TeenUnicornComponent(),
          AdultUnicornComponent(),
        ],
      );
      final unicornState = context.listProperty<UnicornState>(
        'Unicorn state',
        UnicornState.walking,
        UnicornState.values,
      );
      unicorn.state = unicornState;

      final game = context.storyGame(component: unicorn);

      return GameWidget(game: game);
    },
    info: 'The UnicornComponent is a component that represents a unicorn.',
  );
}
