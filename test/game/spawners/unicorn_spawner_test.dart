// ignore_for_file: cascade_invocations

import 'dart:math';

import 'package:flame/extensions.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';

import 'package:ranch_components/ranch_components.dart';

import 'package:very_good_ranch/game/entities/entities.dart';
import 'package:very_good_ranch/game/game.dart';
import 'package:very_good_ranch/game/spawners/spawners.dart';
import 'package:very_good_ranch/l10n/l10n.dart';

import '../../helpers/helpers.dart';

void main() {
  late Random seed;
  late GameBloc gameBloc;
  late AppLocalizations l10n;

  setUp(() {
    seed = MockRandom();
    when(() => seed.nextInt(any())).thenReturn(0);
    when(() => seed.nextDouble()).thenReturn(0);
    when(() => seed.nextBool()).thenReturn(false);

    gameBloc = MockGameBloc();
    when(() => gameBloc.state).thenReturn(const GameState());

    l10n = MockAppLocalizations();
    when(() => l10n.score).thenReturn('score');
  });

  final flameTester = FlameTester<VeryGoodRanchGame>(
    () => VeryGoodRanchGame(
      seed: seed,
      gameBloc: gameBloc,
      inventoryBloc: MockInventoryBloc(),
      l10n: l10n,
    ),
  );

  group('UnicornSpawner', () {
    flameTester.testGameWidget(
      'spawns a unicorn',
      setUp: (game, tester) async {
        when(() => seed.nextDouble()).thenReturn(1);
        await game.add(
          BackgroundComponent(
            children: [
              UnicornSpawner(seed: seed),
            ],
          ),
        );

        await game.ready();
        game.update(20);
        await game.ready();
      },
      verify: (game, tester) async {
        final backgroundComponent =
            game.children.whereType<BackgroundComponent>().first;
        final unicornComponents =
            backgroundComponent.children.whereType<Unicorn>();

        expect(unicornComponents.length, 1);
        expect(
          unicornComponents.first.position,
          backgroundComponent.pastureField.bottomRight.toVector2() -
              unicornComponents.first.size,
        );
      },
    );
  });
}
