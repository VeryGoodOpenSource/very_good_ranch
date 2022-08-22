import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_ranch/game/game.dart';

void main() {
  group('BlessingState', () {
    test('can be instantiated', () {
      expect(BlessingState.initial(), BlessingState.zero());
    });
    test('supports value equality', () {
      expect(
        BlessingState.zero(
          babyUnicorns: 1,
          adultUnicorns: 2,
          childUnicorns: 3,
          teenUnicorns: 4,
        ),
        equals(
          BlessingState.zero(
            babyUnicorns: 1,
            adultUnicorns: 2,
            childUnicorns: 3,
            teenUnicorns: 4,
          ),
        ),
      );
    });

    group('copyWith', () {
      test('copies informed with values', () {
        final state = BlessingState.zero(
          babyUnicorns: 1,
          adultUnicorns: 2,
          childUnicorns: 3,
          teenUnicorns: 4,
        );

        expect(
          state.copyWith(
            babyUnicorns: 4,
            adultUnicorns: 4,
            childUnicorns: 4,
            teenUnicorns: 4,
          ),
          equals(
            BlessingState.zero(
              babyUnicorns: 4,
              adultUnicorns: 4,
              childUnicorns: 4,
              teenUnicorns: 4,
            ),
          ),
        );
      });
      test('maintains omitted values', () {
        final state = BlessingState.zero(
          babyUnicorns: 1,
          adultUnicorns: 2,
          childUnicorns: 3,
          teenUnicorns: 4,
        );

        expect(
          state.copyWith(),
          equals(
            BlessingState.zero(
              babyUnicorns: 1,
              adultUnicorns: 2,
              childUnicorns: 3,
              teenUnicorns: 4,
            ),
          ),
        );
      });
    });

    group('Cannot initialize BlessingState with negative count values', () {
      test('on construction', () {
        expect(
          () => BlessingState.zero(
            babyUnicorns: -1,
          ),
          throwsA(
            isA<StateError>(),
          ),
        );
      });
      test('on copy', () {
        expect(
          () => BlessingState.initial().copyWith(
            babyUnicorns: -1,
          ),
          throwsA(
            isA<StateError>(),
          ),
        );
      });
    });
  });
}
