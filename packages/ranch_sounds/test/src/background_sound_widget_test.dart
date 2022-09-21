import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ranch_sounds/ranch_sounds.dart';

class MockRanchSoundPlayer extends Mock implements RanchSoundPlayer {}

void main() {
  registerFallbackValue(RanchSound.startBackground);

  testWidgets('plays on mount', (tester) async {
    final player = MockRanchSoundPlayer();

    when(() => player.play(RanchSound.startBackground))
        .thenAnswer((Invocation invocation) async {});
    when(() => player.stop(RanchSound.startBackground))
        .thenAnswer((Invocation invocation) async {});

    await tester.pumpWidget(
      BackgroundSoundWidget(
        player: player,
        ranchSound: RanchSound.startBackground,
        volume: 1,
        child: const SizedBox.shrink(),
      ),
    );

    verify(() => player.play(RanchSound.startBackground)).called(1);
  });

  testWidgets('change of volume sets volume', (tester) async {
    final player = MockRanchSoundPlayer();

    when(() => player.play(RanchSound.startBackground))
        .thenAnswer((Invocation invocation) async {});
    when(() => player.setVolume(RanchSound.startBackground, any()))
        .thenAnswer((Invocation invocation) async {});
    when(() => player.stop(RanchSound.startBackground))
        .thenAnswer((Invocation invocation) async {});

    await tester.pumpWidget(
      BackgroundSoundWidget(
        player: player,
        ranchSound: RanchSound.startBackground,
        volume: 1,
        child: const SizedBox.shrink(),
      ),
    );

    await tester.pumpWidget(
      BackgroundSoundWidget(
        player: player,
        ranchSound: RanchSound.startBackground,
        volume: 0.5,
        child: const SizedBox.shrink(),
      ),
    );

    verify(() => player.setVolume(RanchSound.startBackground, 0.5)).called(1);
  });

  testWidgets(
    'change of sound stops the old sound and plays new one',
    (tester) async {
      final player = MockRanchSoundPlayer();

      when(() => player.play(any()))
          .thenAnswer((Invocation invocation) async {});
      when(() => player.stop(any()))
          .thenAnswer((Invocation invocation) async {});

      await tester.pumpWidget(
        BackgroundSoundWidget(
          player: player,
          ranchSound: RanchSound.startBackground,
          volume: 1,
          child: const SizedBox.shrink(),
        ),
      );

      await tester.pumpWidget(
        BackgroundSoundWidget(
          player: player,
          ranchSound: RanchSound.gameBackground,
          volume: 1,
          child: const SizedBox.shrink(),
        ),
      );

      verify(() => player.stop(RanchSound.startBackground)).called(1);
      verify(() => player.play(RanchSound.gameBackground)).called(1);
    },
  );

  testWidgets('stops on unmount', (tester) async {
    final player = MockRanchSoundPlayer();

    when(() => player.play(RanchSound.startBackground))
        .thenAnswer((Invocation invocation) async {});
    when(() => player.stop(RanchSound.startBackground))
        .thenAnswer((Invocation invocation) async {});

    await tester.pumpWidget(
      BackgroundSoundWidget(
        player: player,
        ranchSound: RanchSound.startBackground,
        volume: 1,
        child: const SizedBox.shrink(),
      ),
    );

    await tester.pumpWidget(
      const SizedBox.shrink(),
    );

    verify(() => player.stop(RanchSound.startBackground)).called(1);
  });
}
