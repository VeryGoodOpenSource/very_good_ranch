part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();
}

class MusicVolumeChanged extends SettingsEvent {
  const MusicVolumeChanged(this.volume);

  final double volume;

  @override
  List<Object> get props => [volume];
}
