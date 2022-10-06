import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:very_good_ranch/game_menu/game_menu.dart';

class MockStorage extends Mock implements Storage {}

void main() {
  group('SettingsBloc', () {
    late Storage storage;

    setUp(() {
      storage = MockStorage();
      when(() => storage.write(any(), any() as dynamic)).thenAnswer(
        (_) async {},
      );
      HydratedBloc.storage = storage;
    });

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

    group('json stuff', () {
      test('fromJson converts from json to state', () {
        final settingsBloc = SettingsBloc();
        final result = settingsBloc.fromJson({'musicVolume': 0.5});
        expect(result, const SettingsState(musicVolume: 0.5));
      });

      test('fromJson converts from extraneous json to null', () {
        final settingsBloc = SettingsBloc();
        final result = settingsBloc.fromJson({});
        expect(result, isNull);
      });
    });

    test('toJson converts from state to json', () {
      final settingsBloc = SettingsBloc();
      final result = settingsBloc.toJson(const SettingsState(musicVolume: 0.5));
      expect(result, {'musicVolume': 0.5});
    });
  });
}
