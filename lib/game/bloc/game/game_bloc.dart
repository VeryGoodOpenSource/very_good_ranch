import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ranch_components/ranch_components.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc() : super(const GameState()) {
    on<SpawnFood>(_onSpawnFood);
  }

  void _onSpawnFood(SpawnFood event, Emitter<GameState> emit) {
    emit(GameState(food: event.type));
  }
}
