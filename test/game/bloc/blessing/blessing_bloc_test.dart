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
        seed: () => BlessingState.zero(babyUnicorns: 1),
        act: (bloc) {
          bloc
            ..add(const UnicornEvolved(to: UnicornEvolutionStage.child))
            ..add(const UnicornEvolved(to: UnicornEvolutionStage.teen))
            ..add(const UnicornEvolved(to: UnicornEvolutionStage.adult));
        },
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
            ..add(const UnicornEvolved(to: UnicornEvolutionStage.baby));
        },
        errors: () => [isA<StateError>()],
      );

      blocTest<BlessingBloc, BlessingState>(
        'cannot evolve a unicorn that does not exist',
        build: BlessingBloc.new,
        act: (bloc) {
          bloc.add(const UnicornEvolved(to: UnicornEvolutionStage.teen));
        },
        errors: () => [isA<StateError>()],
      );
    });

    group('on unicorn de-spawn', () {
      blocTest<BlessingBloc, BlessingState>(
        'de-spawns a baby unicorn',
        build: BlessingBloc.new,
        seed: () => BlessingState.zero(babyUnicorns: 1),
        act: (bloc) {
          bloc.add(const UnicornDespawned(UnicornEvolutionStage.baby));
        },
        expect: () {
          return [BlessingState.zero()];
        },
      );

      blocTest<BlessingBloc, BlessingState>(
        'de-spawns a child unicorn',
        build: BlessingBloc.new,
        seed: () => BlessingState.zero(childUnicorns: 1),
        act: (bloc) {
          bloc.add(const UnicornDespawned(UnicornEvolutionStage.child));
        },
        expect: () {
          return [BlessingState.zero()];
        },
      );

      blocTest<BlessingBloc, BlessingState>(
        'de-spawns a teen unicorn',
        build: BlessingBloc.new,
        seed: () => BlessingState.zero(teenUnicorns: 1),
        act: (bloc) {
          bloc.add(const UnicornDespawned(UnicornEvolutionStage.teen));
        },
        expect: () {
          return [BlessingState.zero()];
        },
      );

      blocTest<BlessingBloc, BlessingState>(
        'de-spawns an adult unicorn',
        build: BlessingBloc.new,
        seed: () => BlessingState.zero(adultUnicorns: 1),
        act: (bloc) {
          bloc.add(const UnicornDespawned(UnicornEvolutionStage.adult));
        },
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
