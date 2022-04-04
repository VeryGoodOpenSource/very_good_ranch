part of 'settings_bloc.dart';

class SettingsState extends Equatable {
  const SettingsState({
    this.musicVolume = 1,
    this.gameplayVolume = 1,
  })  : assert(
          musicVolume >= 0 && musicVolume <= 1,
          'musicVolume must be between 0 and 1',
        ),
        assert(
          gameplayVolume >= 0 && gameplayVolume <= 1,
          'gameplayVolume must be between 0 and 1',
        );

  final double musicVolume;

  final double gameplayVolume;

  SettingsState copyWith({
    double? musicVolume,
    double? gameplayVolume,
  }) {
    return SettingsState(
      musicVolume: musicVolume ?? this.musicVolume,
      gameplayVolume: gameplayVolume ?? this.gameplayVolume,
    );
  }

  @override
  List<Object?> get props => [musicVolume, gameplayVolume];
}
