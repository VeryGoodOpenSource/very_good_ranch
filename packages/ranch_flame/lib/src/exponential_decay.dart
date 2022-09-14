import 'dart:math';

/// Decay [initialValue]  by a [rate] given [iterations]
double exponentialDecay(double initialValue, double rate, int iterations) {
  assert(
    rate >= 0.0 && rate <= 1.0,
    'Rate has ot be between 0.0 and 1.0. I was $rate',
  );
  return initialValue * pow(1.0 - rate, iterations);
}
