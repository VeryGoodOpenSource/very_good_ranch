// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_ranch/game_menu/game_menu.dart';

void main() {
  group('SettingsEvent', () {
    group('MusicVolumeChanged', () {
      test('can be instantiated', () {
        expect(MusicVolumeChanged(0.5), isNotNull);
      });

      test('supports value equality', () {
        expect(
          MusicVolumeChanged(0.5),
          equals(MusicVolumeChanged(0.5)),
        );
      });
    });
  });
}
