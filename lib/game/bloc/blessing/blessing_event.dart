part of 'blessing_bloc.dart';

abstract class BlessingEvent extends Equatable {
  const BlessingEvent();
}

class UnicornSpawned extends BlessingEvent {
  @override
  List<Object?> get props => [];
}

class UnicornDespawned extends BlessingEvent {
  const UnicornDespawned(this.evolutionStage);

  final UnicornEvolutionStage evolutionStage;

  @override
  List<Object?> get props => [evolutionStage];
}

class UnicornEvolved extends BlessingEvent {
  const UnicornEvolved({required this.to});

  final UnicornEvolutionStage to;

  @override
  List<Object?> get props => [to];
}
