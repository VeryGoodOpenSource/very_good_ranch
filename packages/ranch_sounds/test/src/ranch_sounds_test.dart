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

  group('RanchSounds', () {
    test('can be instantiated', () {
      expect(RanchSounds(audioCache: UnprefixedAudioCache()), isNotNull);
    });

    group('preloadAssets', () {
      test('preloads assets', () async {
        final audioCache = _MockAudioCache();
        when(() => audioCache.load(any()))
            .thenAnswer((invocation) async => _MockURI());

        final sounds = RanchSounds(audioCache: audioCache);

        await sounds.preloadAssets();

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

        when(() => audioCache.load(any()))
            .thenAnswer((invocation) async => _MockURI());

        final bgm = _MockBgm();

        when(() => bgm.audioPlayer)
            .thenReturn(AudioPlayer()..audioCache = audioCache);

        final sounds = RanchSounds(
          audioCache: audioCache,
          createBGM: () => bgm,
        );

        await sounds.preloadAssets();
        sounds.dispose();

        verify(bgm.dispose).called(2);
      });
    });

    group('startBackground', () {
      test('play', () async {
        final audioCache = _MockAudioCache();
        final bgm = _MockBgm();
        final ap = AudioPlayer()..audioCache = audioCache;

        when(() => bgm.audioPlayer).thenReturn(ap);
        when(() => bgm.play(any())).thenAnswer((invocation) async {});

        final startBackground = RanchSounds(
          audioCache: audioCache,
          createBGM: () => bgm,
        ).startBackground;

        final result = await startBackground.play();

        expect(result, ap);

        verify(
          () => bgm
              .play('packages/ranch_sounds/assets/music/start_background.wav'),
        ).called(1);
      });
    });

    group('gameBackground', () {
      test('play', () async {
        final audioCache = _MockAudioCache();
        final bgm = _MockBgm();
        final ap = AudioPlayer()..audioCache = audioCache;

        when(() => bgm.audioPlayer).thenReturn(ap);
        when(() => bgm.play(any())).thenAnswer((invocation) async {});

        final gameBackground = RanchSounds(
          audioCache: audioCache,
          createBGM: () => bgm,
        ).gameBackground;

        final result = await gameBackground.play();

        expect(result, ap);

        verify(
          () => bgm
              .play('packages/ranch_sounds/assets/music/game_background.wav'),
        ).called(1);
        ;
      });
    });
  });
}
