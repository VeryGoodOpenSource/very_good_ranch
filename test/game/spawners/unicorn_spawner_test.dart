// ignore_for_file: cascade_invocations

import 'dart:math';

import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:very_good_ranch/game/entities/entities.dart';
import 'package:very_good_ranch/game/spawners/spawners.dart';

import '../../helpers/helpers.dart';

void main() {
  late Random seed;

  setUp(() {
    seed = MockRandom();
    when(() => seed.nextInt(any())).thenReturn(0);
    when(seed.nextDouble).thenReturn(0);
    when(seed.nextBool).thenReturn(false);
  });

  final flameTester = FlameTester<TestGame>(TestGame.new);

  group('UnicornSpawner', () {
    flameTester.testGameWidget(
      'spawns a unicorn',
      setUp: (game, tester) async {
        when(() => seed.nextDouble()).thenReturn(1);
        await game.add(UnicornSpawner(seed: seed));

        await game.ready();
        game.update(20);
        await game.ready();
      },
      verify: (game, tester) async {
        final unicornComponents = game.children.whereType<Unicorn>();
        expect(unicornComponents.length, 1);
        expect(unicornComponents.first.position, game.size);
      },
    );
  });
}
