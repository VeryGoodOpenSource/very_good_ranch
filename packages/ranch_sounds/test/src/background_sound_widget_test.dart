import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ranch_sounds/ranch_sounds.dart';

class MockRanchSoundPlayer extends Mock implements RanchSoundPlayer {}

void main() {
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
