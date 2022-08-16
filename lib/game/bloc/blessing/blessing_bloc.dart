import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:very_good_ranch/game/entities/entities.dart';

part 'blessing_event.dart';

part 'blessing_state.dart';

/// Blessing is a collective noun for unicorns.
///
/// This [Bloc] keeps count of how many unicorns ts there in the ranch.
class BlessingBloc extends Bloc<BlessingEvent, BlessingState> {
  BlessingBloc() : super(BlessingState.initial()) {
    on<UnicornSpawned>(_onUnicornSpawned);
    on<UnicornDespawned>(_onUnicornDespawned);
    on<UnicornEvolved>(_onUnicornEvolved);
  }

  void _onUnicornSpawned(UnicornSpawned event, Emitter<BlessingState> emit) {
    emit(state.copyWith(babyUnicorns: state.babyUnicorns + 1));
  }

  void _onUnicornDespawned(
    UnicornDespawned event,
    Emitter<BlessingState> emit,
  ) {
    switch (event.stage) {
      case UnicornEvolutionStage.baby:
        final newValue = state.babyUnicorns - 1;
        return emit(state.copyWith(babyUnicorns: newValue));
      case UnicornEvolutionStage.child:
        final newValue = state.childUnicorns - 1;
        return emit(state.copyWith(childUnicorns: newValue));
      case UnicornEvolutionStage.teen:
        final newValue = state.teenUnicorns - 1;
        return emit(state.copyWith(teenUnicorns: newValue));
      case UnicornEvolutionStage.adult:
        final newValue = state.adultUnicorns - 1;
        return emit(state.copyWith(adultUnicorns: newValue));
    }
  }

  void _onUnicornEvolved(
    UnicornEvolved event,
    Emitter<BlessingState> emit,
  ) {
    switch (event.to) {
      case UnicornEvolutionStage.baby:
        throw StateError('Cannot evolve to a baby unicorn');
      case UnicornEvolutionStage.child:
        final decreasedValue = state.babyUnicorns - 1;
        final increasedValue = state.childUnicorns + 1;
        return emit(
          state.copyWith(
            babyUnicorns: decreasedValue,
            childUnicorns: increasedValue,
          ),
        );
      case UnicornEvolutionStage.teen:
        final decreasedValue = state.childUnicorns - 1;
        final increasedValue = state.teenUnicorns + 1;
        return emit(
          state.copyWith(
            childUnicorns: decreasedValue,
            teenUnicorns: increasedValue,
          ),
        );
      case UnicornEvolutionStage.adult:
        final decreasedValue = state.teenUnicorns - 1;
        final increasedValue = state.adultUnicorns + 1;
        return emit(
          state.copyWith(
            teenUnicorns: decreasedValue,
            adultUnicorns: increasedValue,
          ),
        );
    }
  }
}
