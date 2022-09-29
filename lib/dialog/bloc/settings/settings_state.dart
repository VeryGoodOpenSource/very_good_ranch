part of 'settings_bloc.dart';

class SettingsState extends Equatable {
  const SettingsState({
    this.musicVolume = 1,
  }) : assert(
          musicVolume >= 0 && musicVolume <= 1,
          'musicVolume must be between 0 and 1',
        );

  final double musicVolume;

  SettingsState copyWith({
    double? musicVolume,
  }) {
    return SettingsState(
      musicVolume: musicVolume ?? this.musicVolume,
    );
  }

  @override
  List<Object> get props => [musicVolume];
}
