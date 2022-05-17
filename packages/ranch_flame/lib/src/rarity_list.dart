import 'dart:collection';
import 'dart:math';

import 'package:equatable/equatable.dart';

/// {@template rarity}
/// A [Rarity] describes the rarity of a instance of [T].
/// {@endtemplate}
class Rarity<T> extends Equatable {
  /// {@macro rarity}
  const Rarity(this.value, this.weight);

  /// The value of the rarity.
  final T value;

  /// The weight of the rarity.
  final int weight;

  @override
  List<Object?> get props => [value, weight];
}

/// {@template rarity_list}
/// A [RarityList] is a list of [Rarity]s. That can be used to get a random
/// [Rarity] from the list.
/// {@endtemplate}
class RarityList<T> {
  /// {@macro rarity_list}
  RarityList(List<Rarity<T>> rarities)
      : _rarities = rarities..sort((a, b) => a.weight < b.weight ? 1 : -1),
        assert(
          rarities.fold<int>(0, _raritySum) == 100,
          'The sum of the rarities weight has to equal 100%',
        ) {
    _probabilities = _rarities.map((rare) {
      final filler = 100 - _rarities.fold<int>(0, _raritySum);
      return List.filled(rare.weight == 0 ? filler : rare.weight, rare);
    }).fold<List<Rarity<T>>>(<Rarity<T>>[], (p, e) => p..addAll(e));
  }

  /// List of rarities. Sorted by weight.
  List<Rarity<T>> get rarities => UnmodifiableListView(_rarities);
  late final List<Rarity<T>> _rarities;

  /// List of a total of 100 items based on the weight value of each rarity.
  List<Rarity<T>> get probabilities => UnmodifiableListView(_probabilities);
  late final List<Rarity<T>> _probabilities;

  /// Returns a random [Rarity] item.
  T getRandom([Random? rnd]) {
    final index = (rnd ?? Random()).nextInt(100);
    return _probabilities[index].value;
  }

  static int _raritySum(int sum, Rarity rarity) => sum + rarity.weight;
}
