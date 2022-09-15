import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ranch_flame/ranch_flame.dart';

class MockRandom extends Mock implements Random {}

const epsilon = 1e-15;

void main() {
  group('exponentialDistribution', () {
    test('distribute values', () {
      final random = MockRandom();

      when(random.nextDouble).thenReturn(0);
      final result1 = exponentialDistribution(random);
      expect(result1, closeTo(-1.0, epsilon));

      when(random.nextDouble).thenReturn(0.3);
      final result2 = exponentialDistribution(random);
      expect(result2, closeTo(-0.16, epsilon));

      when(random.nextDouble).thenReturn(0.7);
      final result3 = exponentialDistribution(random);
      expect(result3, closeTo(0.16, epsilon));

      when(random.nextDouble).thenReturn(1);
      final result4 = exponentialDistribution(random);
      expect(result4, closeTo(1.0, epsilon));
    });
  });
}
