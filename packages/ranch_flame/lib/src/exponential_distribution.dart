import 'dart:math';

/// Generates a random value between -1.0 and 1.0 in a exponential distribution.
double exponentialDistribution(Random seed, [double exponent = 2]) {
  final randomDouble = seed.nextDouble();

  final linearFactor = (randomDouble * 2) - 1;
  final isNegative = linearFactor < 0;

  final exponentialFactor = pow(linearFactor, exponent);

  return exponentialFactor * (isNegative ? -1 : 1);
}
