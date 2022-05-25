// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:ranch_components/ranch_components.dart';
import 'package:very_good_ranch/game/game.dart';

void main() {
  group('GameState', () {
    test('supports value equality', () {
      expect(
        GameState(),
        equals(GameState()),
      );
    });

    group('constructor', () {
      test('can be instantiated', () {
        expect(GameState(), isNotNull);
      });
    });

    group('copyWith', () {
      test('returns a new instance with the given food type', () {
        final state = GameState();
        expect(
          state.copyWith(food: FoodType.candy),
          equals(GameState(food: FoodType.candy)),
        );
      });

      test('returns a new instance with the old food type', () {
        final state = GameState(food: FoodType.candy);
        expect(
          state.copyWith(),
          equals(GameState(food: FoodType.candy)),
        );
      });
    });
  });
}
