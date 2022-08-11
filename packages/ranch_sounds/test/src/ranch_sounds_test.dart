import 'package:audioplayers/audioplayers.dart';
import 'package:flame_audio/bgm.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ranch_sounds/ranch_sounds.dart';

class _MockAudioCache extends Mock implements UnprefixedAudioCache {}

class _MockBgm extends Mock implements Bgm {}

class _MockURI extends Mock implements Uri {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('RanchSoundPlayer', () {
    test('can be instantiated', () {
      expect(RanchSoundPlayer(), isNotNull);
    });

    group('preloadAssets', () {
      test('preloads assets', () async {
        final audioCache = _MockAudioCache();
        when(() => audioCache.load(any())).thenAnswer((_) async => _MockURI());

        final player = RanchSoundPlayer(audioCache: audioCache);

        await player.preloadAssets();

        verify(
          () => audioCache.load(
            'packages/ranch_sounds/assets/music/game_background.wav',
          ),
        ).called(1);

        verify(
          () => audioCache.load(
            'packages/ranch_sounds/assets/music/start_background.wav',
          ),
        ).called(1);

        // no remaining calls
        verifyNever(() => audioCache.load(any()));
      });
    });

    group('dispose', () {
      test('disposes', () async {
        final audioCache = _MockAudioCache();

        when(() => audioCache.load(any())).thenAnswer((_) async => _MockURI());

        when(audioCache.clearAll).thenAnswer((_) async {});

        final bgm = _MockBgm();

        when(() => bgm.audioPlayer)
            .thenReturn(AudioPlayer()..audioCache = audioCache);

        final player = RanchSoundPlayer(
          audioCache: audioCache,
          createBGM: () => bgm,
        );

        await player.preloadAssets();
        await player.dispose();

        verify(audioCache.clearAll).called(1);
        verify(bgm.dispose).called(2);
      });
    });

    group('startBackground', () {
      test('play', () async {
        final audioCache = _MockAudioCache();
        final bgm = _MockBgm();
        final ap = AudioPlayer()..audioCache = audioCache;

        when(() => bgm.audioPlayer).thenReturn(ap);
        when(() => bgm.play(any())).thenAnswer((_) async {});

        final player = RanchSoundPlayer(
          audioCache: audioCache,
          createBGM: () => bgm,
        );

        await player.play(RanchSounds.startBackground);

        verify(
          () => bgm
              .play('packages/ranch_sounds/assets/music/start_background.wav'),
        ).called(1);
      });

      test('stop', () async {
        final audioCache = _MockAudioCache();
        final bgm = _MockBgm();
        final ap = AudioPlayer()..audioCache = audioCache;

        when(() => bgm.audioPlayer).thenReturn(ap);
        when(bgm.stop).thenAnswer((_) async {});

        final player = RanchSoundPlayer(
          audioCache: audioCache,
          createBGM: () => bgm,
        );

        await player.stop(RanchSounds.startBackground);

        verify(bgm.stop).called(1);
      });
    });

    group('gameBackground', () {
      test('play', () async {
        final audioCache = _MockAudioCache();
        final bgm = _MockBgm();
        final ap = AudioPlayer()..audioCache = audioCache;

        when(() => bgm.audioPlayer).thenReturn(ap);
        when(() => bgm.play(any())).thenAnswer((_) async {});

        final player = RanchSoundPlayer(
          audioCache: audioCache,
          createBGM: () => bgm,
        );

        await player.play(RanchSounds.gameBackground);

        verify(
          () => bgm
              .play('packages/ranch_sounds/assets/music/game_background.wav'),
        ).called(1);
      });

      test('stop', () async {
        final audioCache = _MockAudioCache();
        final bgm = _MockBgm();
        final ap = AudioPlayer()..audioCache = audioCache;

        when(() => bgm.audioPlayer).thenReturn(ap);
        when(bgm.stop).thenAnswer((_) async {});

        final player = RanchSoundPlayer(
          audioCache: audioCache,
          createBGM: () => bgm,
        );

        await player.stop(RanchSounds.gameBackground);

        verify(bgm.stop).called(1);
      });
    });
  });
}
