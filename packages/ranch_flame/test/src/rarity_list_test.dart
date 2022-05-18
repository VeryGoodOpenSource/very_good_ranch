// ignore_for_file: prefer_const_constructors

import 'dart:collection';
import 'dart:math';

import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ranch_flame/ranch_flame.dart';

class MockRandom extends Mock implements Random {}

void main() {
  group('RarityList', () {
    late Random rnd;

    setUp(() {
      rnd = MockRandom();
    });

    test(
      'throws assertion error when the total weight does not equal 100',
      () {
        expect(
          () => RarityList([Rarity(1, 10), Rarity(2, 20)]),
          failsAssert('The sum of the rarities weight has to equal 100%'),
        );

        expect(
          () => RarityList([Rarity(1, 100), Rarity(2, 20)]),
          failsAssert('The sum of the rarities weight has to equal 100%'),
        );
      },
    );

    test('sorts list of rarity by weight', () {
      final list = RarityList(
        [Rarity(1, 40), Rarity(2, 30), Rarity(4, 10), Rarity(3, 20)],
      );

      expect(
        list.rarities,
        equals(
          UnmodifiableListView(
            [Rarity(1, 40), Rarity(2, 30), Rarity(3, 20), Rarity(4, 10)],
          ),
        ),
      );
    });

    test('generates a sorted probability list', () {
      final list = RarityList(
        [Rarity(1, 40), Rarity(2, 30), Rarity(4, 10), Rarity(3, 20)],
      );

      expect(
        list.probabilities,
        equals(
          UnmodifiableListView([
            for (var i = 0; i < 40; i++) Rarity(1, 40),
            for (var i = 0; i < 30; i++) Rarity(2, 30),
            for (var i = 0; i < 20; i++) Rarity(3, 20),
            for (var i = 0; i < 10; i++) Rarity(4, 10),
          ]),
        ),
      );
    });

    test('returns a random item', () {
      when(() => rnd.nextInt(100)).thenReturn(50);

      final list = RarityList<int>(
        [Rarity(1, 50), Rarity(2, 30), Rarity(3, 20)],
      );

      when(() => rnd.nextInt(100)).thenReturn(0);
      expect(list.getRandom(rnd), 1);

      when(() => rnd.nextInt(100)).thenReturn(50);
      expect(list.getRandom(rnd), 2);

      when(() => rnd.nextInt(100)).thenReturn(80);
      expect(list.getRandom(rnd), 3);
    });
  });
}
