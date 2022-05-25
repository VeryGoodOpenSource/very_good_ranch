part of 'game_bloc.dart';

abstract class GameEvent extends Equatable {
  const GameEvent();
}

class FoodSpawned extends GameEvent {
  const FoodSpawned(this.type);

  final FoodType type;

  @override
  List<Object> get props => [type];
}
