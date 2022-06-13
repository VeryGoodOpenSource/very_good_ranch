import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ranch_components/ranch_components.dart';
import 'package:very_good_ranch/game/game.dart';

void main() {
  group('GameBloc', () {
    test('initial state has no food to add', () {
      final gameBloc = GameBloc();
      expect(gameBloc.state.food, isNull);
    });

    group('FoodSpawned', () {
      blocTest<GameBloc, GameState>(
        'spawn food',
        build: GameBloc.new,
        act: (bloc) {
          bloc.add(const FoodSpawned(FoodType.cake));
        },
        expect: () {
          return [
            const GameState(food: FoodType.cake),
          ];
        },
      );
    });
  });
}
