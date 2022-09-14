import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ranch_flame/ranch_flame.dart';

class MockRandom extends Mock implements Random {}

const epsilon = 1e-15;

void main() {
  group('exponentialDecay', () {
    test('decay values', () {
      expect(exponentialDecay(100, 0.1, 0), closeTo(100, epsilon));
      expect(exponentialDecay(100, 0.1, 1), closeTo(90, epsilon));
      expect(exponentialDecay(100, 0.1, 2), closeTo(81, epsilon));
    });
  });
}
