import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'settings_event.dart';

part 'settings_state.dart';

class SettingsBloc extends HydratedBloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(const SettingsState()) {
    on<MusicVolumeChanged>(_onMusicVolumeChanged);
  }

  void _onMusicVolumeChanged(
    MusicVolumeChanged event,
    Emitter<SettingsState> emit,
  ) {
    emit(state.copyWith(musicVolume: event.volume));
  }

  @override
  SettingsState? fromJson(Map<String, dynamic> json) {
    final musicVolume = json['musicVolume'] as double?;
    if (musicVolume == null) {
      return null;
    }
    return SettingsState(musicVolume: musicVolume);
  }

  @override
  Map<String, dynamic>? toJson(SettingsState state) {
    return {'musicVolume': state.musicVolume};
  }
}
