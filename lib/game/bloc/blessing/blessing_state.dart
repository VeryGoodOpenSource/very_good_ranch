part of 'blessing_bloc.dart';

class BlessingState extends Equatable {
  BlessingState.initial()
      : this._(
          babyUnicorns: 0,
          childUnicorns: 0,
          teenUnicorns: 0,
          adultUnicorns: 0,
        );

  @visibleForTesting
  BlessingState.zero({
    int babyUnicorns = 0,
    int childUnicorns = 0,
    int teenUnicorns = 0,
    int adultUnicorns = 0,
  }) : this._(
          babyUnicorns: babyUnicorns,
          childUnicorns: childUnicorns,
          teenUnicorns: teenUnicorns,
          adultUnicorns: adultUnicorns,
        );

  BlessingState._({
    required this.babyUnicorns,
    required this.childUnicorns,
    required this.teenUnicorns,
    required this.adultUnicorns,
  }) {
    if (babyUnicorns < 0 ||
        childUnicorns < 0 ||
        teenUnicorns < 0 ||
        adultUnicorns < 0) {
      throw StateError(
        'Cannot initialize BlessingState with negative count values: $this',
      );
    }
  }

  final int babyUnicorns;
  final int childUnicorns;
  final int teenUnicorns;
  final int adultUnicorns;

  BlessingState copyWith({
    int? babyUnicorns,
    int? childUnicorns,
    int? teenUnicorns,
    int? adultUnicorns,
  }) {
    return BlessingState._(
      babyUnicorns: babyUnicorns ?? this.babyUnicorns,
      childUnicorns: childUnicorns ?? this.childUnicorns,
      teenUnicorns: teenUnicorns ?? this.teenUnicorns,
      adultUnicorns: adultUnicorns ?? this.adultUnicorns,
    );
  }

  @override
  List<Object?> get props => [
        babyUnicorns,
        childUnicorns,
        teenUnicorns,
        adultUnicorns,
      ];
}
