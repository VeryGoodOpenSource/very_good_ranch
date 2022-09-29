import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_ranch/dialog/dialog.dart';

void main() {
  group('SettingsBloc', () {
    test('initial state has max gameplay and music volume', () {
      final settingsBloc = SettingsBloc();
      expect(settingsBloc.state.musicVolume, equals(1));
    });

    group('MusicVolumeChanged', () {
      blocTest<SettingsBloc, SettingsState>(
        'updates music volume',
        build: SettingsBloc.new,
        act: (bloc) {
          bloc.add(const MusicVolumeChanged(0.5));
        },
        expect: () {
          return const [SettingsState(musicVolume: 0.5)];
        },
      );
    });
  });
}
