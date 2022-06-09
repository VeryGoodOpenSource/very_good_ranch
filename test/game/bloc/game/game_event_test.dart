// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:ranch_components/ranch_components.dart';
import 'package:very_good_ranch/game/game.dart';

void main() {
  group('GameEvent', () {
    group('FoodSpawned', () {
      test('can be instantiated', () {
        expect(FoodSpawned(FoodType.cake), isNotNull);
      });

      test('supports value equality', () {
        expect(
          FoodSpawned(FoodType.cake),
          equals(FoodSpawned(FoodType.cake)),
        );
      });
    });
  });
}
