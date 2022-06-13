import 'package:dashbook/dashbook.dart';
import 'package:flame/game.dart';
import 'package:ranch_components/ranch_components.dart';
import 'package:sandbox/common/common.dart';

void addFoodComponentStories(Dashbook dashbook) {
  dashbook.storiesOf('FoodComponent').add(
    'type',
    (context) {
      final foodType = context.optionsProperty<FoodType>(
        'type',
        FoodType.cake,
        FoodType.values
            .map((e) => PropertyOption(e.name.split(' ').last, e))
            .toList(),
      );
      return GameWidget(
        game: StoryGame(
          FoodComponent.ofType(foodType),
        ),
      );
    },
    info: '''
      The FoodComponent is a component that represents a food.

      - It can be of different types.
''',
  );
}
