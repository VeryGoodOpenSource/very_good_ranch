// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_ranch/game/entities/entities.dart';
import 'package:very_good_ranch/game/game.dart';

void main() {
  group('BlessingEvent', () {
    group('UnicornSpawned', () {
      test('can be instantiated', () {
        expect(UnicornSpawned(), isNotNull);
      });
      test('supports value equality', () {
        expect(
          UnicornSpawned(),
          equals(UnicornSpawned()),
        );
      });
    });
    group('UnicornDespawned', () {
      test('can be instantiated', () {
        expect(const UnicornDespawned(UnicornEvolutionStage.teen), isNotNull);
      });
      test('supports value equality', () {
        expect(
          UnicornDespawned(UnicornEvolutionStage.child),
          equals(UnicornDespawned(UnicornEvolutionStage.child)),
        );
      });
    });
    group('UnicornEvolved', () {
      test('can be instantiated', () {
        expect(const UnicornEvolved(UnicornEvolutionStage.adult), isNotNull);
      });
      test('supports value equality', () {
        expect(
          UnicornEvolved(UnicornEvolutionStage.teen),
          equals(UnicornEvolved(UnicornEvolutionStage.teen)),
        );
      });
    });
  });
}
