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
        'Unicorn evolution stage',
        defaultUnicorn,
        [
          defaultUnicorn,
          ChildUnicornComponent(),
          TeenUnicornComponent(),
          AdultUnicornComponent(),
        ],
      );

      for (final state in UnicornState.values) {
        context.action('play ${state.name}', (context) {
          unicorn.playAnimation(state);
        });
      }

      final game = context.storyGame(component: unicorn);

      return GameWidget(game: game);
    },
    info: 'The UnicornComponent is a component that represents a unicorn.',
  );
}
