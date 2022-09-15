// ignore_for_file: cascade_invocations
import 'dart:math';

import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';

import 'package:ranch_components/ranch_components.dart';
import 'package:very_good_ranch/game/entities/entities.dart';

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

        var rainbowCarryingUnicorns =
            backgroundComponent.children.whereType<RainbowDrop>();

        expect(rainbowCarryingUnicorns.length, equals(1));

        game.update(20);

        rainbowCarryingUnicorns =
            backgroundComponent.children.whereType<RainbowDrop>();

        expect(rainbowCarryingUnicorns.length, equals(1));
      },
    );

    flameTester.test('adds gauges to background', (game) async {
      when(() => seed.nextDouble()).thenReturn(1);
      await Future<void>.delayed(const Duration(milliseconds: 550));
      await game.ready();
      game.update(1);

      final unicorns = game.background.children.whereType<Unicorn>();
      expect(unicorns.length, 1);
      final gauges = game.background.children.whereType<GaugeComponent>();
      expect(gauges.length, 1);

      unicorns.first.removeFromParent();
      await game.ready();

      final gaugesAfterRemoval =
          game.background.children.whereType<GaugeComponent>();
      expect(gaugesAfterRemoval.length, 0);
    });

    flameTester.test('spawns unicorns timely', (game) async {
      when(() => seed.nextDouble()).thenReturn(0.5);

      verify(() => blessingBloc.add(UnicornSpawned())).called(1);

      game.update(30);

      verify(() => blessingBloc.add(UnicornSpawned())).called(1);

      when(() => seed.nextDouble()).thenReturn(0);

      game.update(25);

      verify(() => blessingBloc.add(UnicornSpawned())).called(1);

      game.update(17.5);

      verify(() => blessingBloc.add(UnicornSpawned())).called(1);
    });
  });
}
