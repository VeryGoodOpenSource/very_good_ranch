import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(const SettingsState()) {
    on<MusicVolumeChanged>(_onMusicVolumeChanged);
  }

  void _onMusicVolumeChanged(
    MusicVolumeChanged event,
    Emitter<SettingsState> emit,
  ) {
    emit(state.copyWith(musicVolume: event.volume));
  }
}
