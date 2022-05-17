import 'package:flutter_test/flutter_test.dart';
import 'package:ranch_components/ranch_components.dart';
import 'package:very_good_ranch/game/entities/unicorn/stages.dart';

void main() {
  group('UnicornStage', () {
    group('BabyUnicornStage', () {
      group('preferredFoodType', () {
        test('should be pancake', () {
          final stage = BabyUnicornStage();
          expect(stage.preferredFoodType, FoodType.pancake);
        });
      });

      group('shouldEvolve', () {
        test('should be false when not fed enough', () {
          final stage = BabyUnicornStage()
            ..timesFed = 3
            ..enjoymentFactor = 1
            ..fullnessFactor = 1;
          expect(stage.shouldEvolve, false);
        });

        test('should be false when not happy enough', () {
          final stage = BabyUnicornStage()
            ..timesFed = 4
            ..enjoymentFactor = 1
            ..fullnessFactor = 0;
          expect(stage.shouldEvolve, false);

          final stage2 = BabyUnicornStage()
            ..timesFed = 4
            ..enjoymentFactor = 0
            ..fullnessFactor = 1;
          expect(stage2.shouldEvolve, false);
        });

        test('should be true when everything is ok', () {
          final stage = BabyUnicornStage()
            ..timesFed = 4
            ..enjoymentFactor = 1
            ..fullnessFactor = 1;
          expect(stage.shouldEvolve, true);
        });
      });

      group('evolve', () {
        test('should evolve to a kid', () {
          final stage = BabyUnicornStage();
          expect(stage.evolve(), isA<KidUnicornStage>());
        });
      });
    });

    group('KidUnicornStage', () {
      group('preferredFoodType', () {
        test('should be lollipop', () {
          final stage = KidUnicornStage();
          expect(stage.preferredFoodType, FoodType.lollipop);
        });
      });

      group('shouldEvolve', () {
        test('should be false when not fed enough', () {
          final stage = KidUnicornStage()
            ..timesFed = 7
            ..enjoymentFactor = 1
            ..fullnessFactor = 1;
          expect(stage.shouldEvolve, false);
        });

        test('should be false when not happy enough', () {
          final stage = KidUnicornStage()
            ..timesFed = 8
            ..enjoymentFactor = 1
            ..fullnessFactor = 0;
          expect(stage.shouldEvolve, false);

          final stage2 = KidUnicornStage()
            ..timesFed = 8
            ..enjoymentFactor = 0
            ..fullnessFactor = 1;
          expect(stage2.shouldEvolve, false);
        });

        test('should be true when everything is ok', () {
          final stage = KidUnicornStage()
            ..timesFed = 8
            ..enjoymentFactor = 1
            ..fullnessFactor = 1;
          expect(stage.shouldEvolve, true);
        });
      });

      group('evolve', () {
        test('should evolve to a teenager', () {
          final stage = KidUnicornStage();
          expect(stage.evolve(), isA<TeenagerUnicornStage>());
        });
      });
    });

    group('TeenagerUnicornStage', () {
      group('preferredFoodType', () {
        test('should be candy', () {
          final stage = TeenagerUnicornStage();
          expect(stage.preferredFoodType, FoodType.candy);
        });
      });

      group('shouldEvolve', () {
        test('should be false when not fed enough', () {
          final stage = TeenagerUnicornStage()
            ..timesFed = 11
            ..enjoymentFactor = 1
            ..fullnessFactor = 1;
          expect(stage.shouldEvolve, false);
        });

        test('should be false when not happy enough', () {
          final stage = TeenagerUnicornStage()
            ..timesFed = 12
            ..enjoymentFactor = 0
            ..fullnessFactor = 1;
          expect(stage.shouldEvolve, false);

          final stage2 = TeenagerUnicornStage()
            ..timesFed = 12
            ..enjoymentFactor = 1
            ..fullnessFactor = 0;
          expect(stage2.shouldEvolve, false);
        });

        test('should be true when everything is ok', () {
          final stage = TeenagerUnicornStage()
            ..timesFed = 12
            ..enjoymentFactor = 1
            ..fullnessFactor = 1;
          expect(stage.shouldEvolve, true);
        });
      });

      group('evolve', () {
        test('should evolve to an adult', () {
          final stage = TeenagerUnicornStage();
          expect(stage.evolve(), isA<AdultUnicornStage>());
        });
      });
    });

    group('AdultUnicornStage', () {
      group('preferredFoodType', () {
        test('should be iceCream', () {
          final stage = AdultUnicornStage();
          expect(stage.preferredFoodType, FoodType.iceCream);
        });
      });

      group('shouldEvolve', () {
        test('should be false when not fed enough', () {
          final stage = AdultUnicornStage()
            ..timesFed = 0
            ..enjoymentFactor = 1
            ..fullnessFactor = 1;
          expect(stage.shouldEvolve, false);
        });

        test('should be false when not happy enough', () {
          final stage = AdultUnicornStage()
            ..timesFed = 17758
            ..enjoymentFactor = 0
            ..fullnessFactor = 0;
          expect(stage.shouldEvolve, false);
        });

        test('should be false even when everything is ok', () {
          final stage = AdultUnicornStage()
            ..timesFed = 17758
            ..enjoymentFactor = 1
            ..fullnessFactor = 1;
          expect(stage.shouldEvolve, false);
        });
      });

      group('evolve', () {
        test('should throw error', () {
          final stage = AdultUnicornStage();
          expect(stage.evolve, throwsA(isA<StateError>()));
        });
      });
    });
  });
}
