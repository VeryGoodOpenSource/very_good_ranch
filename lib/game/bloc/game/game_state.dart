part of 'game_bloc.dart';

class GameState extends Equatable {
  const GameState({
    this.food,
  });

  final FoodType? food;

  GameState copyWith({
    FoodType? food,
  }) {
    return GameState(
      food: food ?? this.food,
    );
  }

  @override
  List<Object?> get props => [food];
}
