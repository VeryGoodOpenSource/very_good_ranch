import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flame_audio/bgm.dart';
import 'package:ranch_sounds/gen/assets.gen.dart';
import 'package:ranch_sounds/src/unprefixed_audiocache.dart';

/// Type signature for callbacks that create a [Bgm]
typedef BGMCreator = Bgm Function();

/// A collection of sounds typical of any Unicorn ranch.
enum RanchSounds {
  /// A [_RanchSound] of a cheerful music.
  startBackground,

  /// A [_RanchSound] of a pretty music.
  gameBackground,
}

/// {@template ranch_sounds}
/// A helper class to load and maintain the [RanchSounds] in a shared
/// [AudioCache].
/// {@endtemplate}
class RanchSoundPlayer {
  /// {@macro ranch_sounds}
  RanchSoundPlayer({
    UnprefixedAudioCache? audioCache,
    BGMCreator? createBGM,
  }) : audioCache = audioCache ?? UnprefixedAudioCache() {
    final _createBGM = createBGM ??
        () {
          return Bgm(audioCache: this.audioCache);
        };

    _sounds = {
      RanchSounds.startBackground: _BackgroundSound._(
        Assets.music.startBackground,
        _createBGM(),
      ),
      RanchSounds.gameBackground: _BackgroundSound._(
        Assets.music.gameBackground,
        _createBGM(),
      ),
    };
  }

  late final Map<RanchSounds, _RanchSound> _sounds;

  /// The [AudioCache] in wich the sounds are preloaded to.
  final UnprefixedAudioCache audioCache;

  /// Preload all sound assets into [audioCache].
  Future<void> preloadAssets() {
    return Future.wait(_sounds.values.map((e) => e.load()));
  }

  /// Play a [ranchSound]
  Future<void> play(RanchSounds ranchSound) async {
    await _sounds[ranchSound]?.play();
  }

  /// Stop playing a [ranchSound]
  Future<void> stop(RanchSounds ranchSound) async {
    await _sounds[ranchSound]?.stop();
  }

  /// Dispose the existing audio elements (such as bgm) and clear cache
  Future<void> dispose() async {
    for (final sound in _sounds.values) {
      sound.dispose();
    }
    await audioCache.clearAll();
  }
}

String _prefixFile(String file) {
  return 'packages/ranch_sounds/$file';
}

abstract class _RanchSound {
  _RanchSound._(String path) {
    this.path = _prefixFile(path);
  }

  late final String path;

  Future<void> load();

  Future<void> play();

  Future<void> stop();

  void dispose();
}

class _BackgroundSound extends _RanchSound {
  _BackgroundSound._(super.path, this.bgm) : super._();

  final Bgm bgm;

  @override
  Future<void> load() async {
    bgm.initialize();
    await bgm.audioPlayer.audioCache.load(path);
  }

  @override
  void dispose() {
    bgm.dispose();
  }

  @override
  Future<void> play() async {
    await bgm.play(path);
  }

  @override
  Future<void> stop() async {
    await bgm.stop();
  }
}
