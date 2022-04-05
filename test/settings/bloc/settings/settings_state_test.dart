// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_ranch/settings/settings.dart';

void main() {
  group('SettingsState', () {
    test('supports value equality', () {
      expect(
        SettingsState(musicVolume: 0.5, gameplayVolume: 0.5),
        equals(const SettingsState(musicVolume: 0.5, gameplayVolume: 0.5)),
      );
    });

    group('constructor', () {
      test('can be instantiated', () {
        expect(const SettingsState(), isNotNull);
      });

      test('throws AssertionError if musicVolume is not between 0 and 1', () {
        expect(() => SettingsState(musicVolume: -0.1), throwsAssertionError);
        expect(() => SettingsState(musicVolume: 1.1), throwsAssertionError);
      });

      test(
        'throws AssertionError if gameplayVolume is not between 0 and 1',
        () {
          expect(
            () => SettingsState(gameplayVolume: -0.1),
            throwsAssertionError,
          );
          expect(
            () => SettingsState(gameplayVolume: 1.1),
            throwsAssertionError,
          );
        },
      );
    });

    group('copyWith', () {
      test('returns a new instance with the given musicVolume', () {
        final state = SettingsState(musicVolume: 0.5);
        expect(
          state.copyWith(musicVolume: 0.6),
          equals(SettingsState(musicVolume: 0.6)),
        );
      });

      test('returns a new instance with the given gameplayVolume', () {
        final state = SettingsState(gameplayVolume: 0.5);
        expect(
          state.copyWith(gameplayVolume: 0.6),
          equals(SettingsState(gameplayVolume: 0.6)),
        );
      });
    });
  });
}
