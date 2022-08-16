part of 'blessing_bloc.dart';

abstract class BlessingEvent extends Equatable {
  const BlessingEvent();
}

class UnicornSpawned extends BlessingEvent {
  @override
  List<Object?> get props => [];
}

class UnicornDespawned extends BlessingEvent {
  const UnicornDespawned(this.stage);

  final UnicornEvolutionStage stage;

  @override
  List<Object?> get props => [stage];
}

class UnicornEvolved extends BlessingEvent {
  const UnicornEvolved(this.to);

  final UnicornEvolutionStage to;

  @override
  List<Object?> get props => [to];
}
