// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:ranch_components/ranch_components.dart';
import 'package:very_good_ranch/inventory/inventory.dart';

void main() {
  group('InventoryEvent', () {
    group('FoodItemAdded', () {
      test('can be instantiated', () {
        expect(FoodItemAdded(FoodType.cake), isNotNull);
      });

      test('supports value equality', () {
        expect(
          FoodItemAdded(FoodType.cake),
          equals(FoodItemAdded(FoodType.cake)),
        );
      });
    });

    group('FoodItemRemoved', () {
      test('can be instantiated', () {
        expect(FoodItemRemoved(FoodType.cake), isNotNull);
      });

      test('supports value equality', () {
        expect(
          FoodItemRemoved(FoodType.cake),
          equals(FoodItemRemoved(FoodType.cake)),
        );
      });
    });
  });
}
