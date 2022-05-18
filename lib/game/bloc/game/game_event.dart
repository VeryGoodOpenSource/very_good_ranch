part of 'game_bloc.dart';

abstract class GameEvent extends Equatable {
  const GameEvent();
}

class SpawnFood extends GameEvent {
  const SpawnFood(this.type);

  final FoodType type;

  @override
  List<Object> get props => [type];
}
