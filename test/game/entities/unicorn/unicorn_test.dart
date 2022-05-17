// ignore_for_file: cascade_invocations

import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ranch_components/ranch_components.dart';
import 'package:very_good_ranch/game/entities/entities.dart';
import 'package:very_good_ranch/game/entities/unicorn/behaviors/behaviors.dart';
import 'package:very_good_ranch/game/entities/unicorn/stages.dart';
import 'package:very_good_ranch/game/very_good_ranch_game.dart';

import '../../../helpers/helpers.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Random seed;

  setUp(() {
    seed = MockRandom();
    when(() => seed.nextInt(any())).thenReturn(0);
    when(() => seed.nextDouble()).thenReturn(0);
    when(() => seed.nextBool()).thenReturn(false);
  });

  final flameTester = FlameTester<VeryGoodRanchGame>(
    () => VeryGoodRanchGame(seed: seed),
  );

  group('Unicorn', () {
    flameTester.test(
      'loads correctly',
      (game) async {
        final unicorn = Unicorn(position: Vector2.zero());
        await game.ready();
        await game.ensureAdd(unicorn);

        expect(game.contains(unicorn), isTrue);
        expect(unicorn.state, UnicornState.idle);
      },
    );

    group('unicorn state', () {
      flameTester.test(
        'is by default idle',
        (game) async {
          final unicorn = Unicorn(position: Vector2.zero());
          await game.ready();
          await game.ensureAdd(unicorn);

          expect(unicorn.state, UnicornState.idle);
        },
      );

      flameTester.test(
        'can be set',
        (game) async {
          final unicorn = Unicorn(position: Vector2.zero());
          await game.ready();
          await game.ensureAdd(unicorn);

          unicorn.state = UnicornState.roaming;

          expect(unicorn.state, UnicornState.roaming);
        },
      );
    });

    group('unicorn stage', () {
      flameTester.test(
        'proxies from the behavior',
        (game) async {
          when(seed.nextDouble).thenReturn(0);

          final unicorn = Unicorn(position: Vector2.zero());
          await game.ready();
          await game.ensureAdd(unicorn);
          unicorn.state = UnicornState.idle;

          expect(unicorn.currentStage, isA<BabyUnicornStage>());
          unicorn.findBehavior<EvolutionBehavior>()!.currentStage.timesFed =
              100;

          when(seed.nextDouble).thenReturn(0);
          await game.ready();
          game.update(10);
          await game.ready();

          expect(unicorn.currentStage, isA<KidUnicornStage>());
        },
      );
    });
  });
}
