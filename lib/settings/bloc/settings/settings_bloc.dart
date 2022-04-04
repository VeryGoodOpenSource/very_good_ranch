import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(const SettingsState()) {
    on<MusicVolumeChanged>((event, emit) {
      emit(state.copyWith(musicVolume: event.volume));
    });
    on<GameplayVolumeChanged>((event, emit) {
      emit(state.copyWith(gameplayVolume: event.volume));
    });
  }
}
