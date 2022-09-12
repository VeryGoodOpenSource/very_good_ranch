// ignore_for_file: cascade_invocations

import 'dart:math';

import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';

import 'package:ranch_components/ranch_components.dart';

import 'package:very_good_ranch/game/game.dart';

import '../../helpers/helpers.dart';

void main() {
  late Random seed;
  late GameBloc gameBloc;
  late BlessingBloc blessingBloc;

  setUp(() {
    seed = MockRandom();
    when(() => seed.nextInt(any())).thenReturn(0);
    when(() => seed.nextDouble()).thenReturn(0);
    when(() => seed.nextBool()).thenReturn(false);

    blessingBloc = MockBlessingBloc();

    gameBloc = MockGameBloc();
    when(() => gameBloc.state).thenReturn(const GameState());
  });

  final flameTester = FlameTester<VeryGoodRanchGame>(
    () => VeryGoodRanchGame(
      seed: seed,
      gameBloc: gameBloc,
      blessingBloc: blessingBloc,
      inventoryBloc: MockInventoryBloc(),
    ),
  );

  group('UnicornSpawner', () {
    TestWidgetsFlutterBinding.ensureInitialized();
    flameTester.test(
      'spawns a unicorn',
      (game) async {
        when(() => seed.nextDouble()).thenReturn(1);
        final backgroundComponent =
            game.descendants().whereType<BackgroundComponent>().first;

        var rainbowCarringUnicorns =
            backgroundComponent.children.whereType<RainbowDrop>();

        expect(rainbowCarringUnicorns.length, equals(1));

        game.update(20);

        rainbowCarringUnicorns =
            backgroundComponent.children.whereType<RainbowDrop>();

        expect(rainbowCarringUnicorns.length, equals(1));
      },
    );
  });
}
