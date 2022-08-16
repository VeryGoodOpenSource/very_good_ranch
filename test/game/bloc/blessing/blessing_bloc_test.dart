import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_ranch/game/entities/entities.dart';
import 'package:very_good_ranch/game/game.dart';

void main() {
  group('BlessingBloc', () {
    group('initial state', () {
      test('should have unicorns', () {
        final blessingBloc = BlessingBloc();
        expect(blessingBloc.state, BlessingState.initial());
      });
    });

    group('on unicorn spawn', () {
      blocTest<BlessingBloc, BlessingState>(
        'spawns a baby unicorn',
        build: BlessingBloc.new,
        act: (bloc) {
          bloc.add(UnicornSpawned());
        },
        expect: () {
          return [BlessingState.zero(babyUnicorns: 1)];
        },
      );
    });

    group('on unicorn evolution', () {
      blocTest<BlessingBloc, BlessingState>(
        'from baby until adult',
        build: BlessingBloc.new,
        act: (bloc) {
          bloc
            ..add(UnicornSpawned())
            ..add(const UnicornEvolved(UnicornEvolutionStage.child))
            ..add(const UnicornEvolved(UnicornEvolutionStage.teen))
            ..add(const UnicornEvolved(UnicornEvolutionStage.adult));
        },
        skip: 1,
        expect: () {
          return [
            BlessingState.zero(childUnicorns: 1),
            BlessingState.zero(teenUnicorns: 1),
            BlessingState.zero(adultUnicorns: 1),
          ];
        },
      );

      blocTest<BlessingBloc, BlessingState>(
        'cannot evolve to baby',
        build: BlessingBloc.new,
        act: (bloc) {
          bloc
            ..add(UnicornSpawned())
            ..add(const UnicornEvolved(UnicornEvolutionStage.baby));
        },
        errors: () => [isA<StateError>()],
      );

      blocTest<BlessingBloc, BlessingState>(
        'cannot evolve a unicorn that does not exist',
        build: BlessingBloc.new,
        act: (bloc) {
          bloc.add(const UnicornEvolved(UnicornEvolutionStage.teen));
        },
        errors: () => [isA<StateError>()],
      );
    });

    group('on unicorn de-spawn', () {
      blocTest<BlessingBloc, BlessingState>(
        'de-spawns a baby unicorn',
        build: BlessingBloc.new,
        act: (bloc) {
          bloc

            /// Add baby unicorn
            ..add(UnicornSpawned())

            /// de-spawn baby unicorn
            ..add(const UnicornDespawned(UnicornEvolutionStage.baby));
        },
        skip: 1,
        expect: () {
          return [BlessingState.zero()];
        },
      );

      blocTest<BlessingBloc, BlessingState>(
        'de-spawns a child unicorn',
        build: BlessingBloc.new,
        act: (bloc) {
          bloc

            /// Add baby unicorn
            ..add(UnicornSpawned())

            /// Evolve to child
            ..add(const UnicornEvolved(UnicornEvolutionStage.child))

            /// de-spawn baby unicorn
            ..add(const UnicornDespawned(UnicornEvolutionStage.child));
        },
        skip: 2,
        expect: () {
          return [BlessingState.zero()];
        },
      );

      blocTest<BlessingBloc, BlessingState>(
        'de-spawns a teen unicorn',
        build: BlessingBloc.new,
        act: (bloc) {
          bloc

            /// Add baby unicorn
            ..add(UnicornSpawned())

            /// Evolve to teen
            ..add(const UnicornEvolved(UnicornEvolutionStage.child))
            ..add(const UnicornEvolved(UnicornEvolutionStage.teen))

            /// de-spawn teen unicorn
            ..add(const UnicornDespawned(UnicornEvolutionStage.teen));
        },
        skip: 3,
        expect: () {
          return [BlessingState.zero()];
        },
      );

      blocTest<BlessingBloc, BlessingState>(
        'de-spawns an adult unicorn',
        build: BlessingBloc.new,
        act: (bloc) {
          bloc

            /// Add baby unicorn
            ..add(UnicornSpawned())

            /// Evolve to adult
            ..add(const UnicornEvolved(UnicornEvolutionStage.child))
            ..add(const UnicornEvolved(UnicornEvolutionStage.teen))
            ..add(const UnicornEvolved(UnicornEvolutionStage.adult))

            /// de-spawn adult unicorn
            ..add(const UnicornDespawned(UnicornEvolutionStage.adult));
        },
        skip: 4,
        expect: () {
          return [BlessingState.zero()];
        },
      );

      blocTest<BlessingBloc, BlessingState>(
        'cannot de-spawn un unicorn that doesnt exist',
        build: BlessingBloc.new,
        act: (bloc) {
          bloc.add(const UnicornDespawned(UnicornEvolutionStage.baby));
        },
        errors: () => [isA<StateError>()],
      );
    });
  });
}
