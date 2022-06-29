import 'package:dashbook/dashbook.dart';
import 'package:flame/components.dart';
import 'package:sandbox/common/story_game.dart';

/// A dashbook's [Property] that keeps a [StoryGame] in the [DashbookContext].
class GameProperty extends Property<StoryGame> {
  GameProperty(StoryGame game) : super('game', game);
}

/// Adds [storyGame] to [DashbookContext]
extension DashbookContextX on DashbookContext {
  /// Keeps an instance of [StoryGame] game alive across builds.
  StoryGame storyGame({
    required PositionComponent component,
    bool center = true,
  }) {
    final existingProperty = properties['game'];

    if (existingProperty is GameProperty) {
      final game = existingProperty.getValue();
      if (component != game.component) {
        game.setComponent(component);
      }
      return game;
    }

    final property = properties['game'] = GameProperty(StoryGame(component));
    return property.getValue();
  }
}
