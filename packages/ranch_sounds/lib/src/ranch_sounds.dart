import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flame_audio/bgm.dart';
import 'package:ranch_sounds/gen/assets.gen.dart';
import 'package:ranch_sounds/src/unprefixed_audiocache.dart';

/// Type signature for callbacks that create a [Bgm]
typedef BGMCreator = Bgm Function();

/// A collection of sounds typical of any Unicorn ranch.
enum RanchSound {
  /// A [RanchSound] of a cheerful music.
  startBackground,

  /// A [RanchSound] of a pretty music.
  gameBackground,

  /// It conjures up an image of someone cycling back home after a lovely day,
  /// and thinking about the time they had.
  sunsetMemory,
}

/// {@template ranch_sounds}
/// A helper class to load and maintain the [RanchSound] in a shared
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
      RanchSound.startBackground: _BackgroundSound._(
        Assets.music.startBackground,
        _createBGM(),
      ),
      RanchSound.gameBackground: _BackgroundSound._(
        Assets.music.gameBackground,
        _createBGM(),
      ),
      RanchSound.sunsetMemory: _BackgroundSound._(
        Assets.music.sunsetMemory,
        _createBGM(),
      ),
    };
  }

  late final Map<RanchSound, _RanchSound> _sounds;

  /// The [AudioCache] in wich the sounds are preloaded to.
  final UnprefixedAudioCache audioCache;

  /// Preload all sound assets into [audioCache].
  Future<void> preloadAssets([
    Iterable<RanchSound> sounds = RanchSound.values,
  ]) {
    return Future.wait(
      sounds.map((e) => _sounds[e]!).map((e) => e.load()),
    );
  }

  /// Play a [ranchSound]
  Future<void> play(RanchSound ranchSound, {double volume = 1}) async {
    await _sounds[ranchSound]?.play(volume);
  }

  /// Set the general volume of the [ranchSound]
  Future<void> setVolume(RanchSound ranchSound, double volume) async {
    await _sounds[ranchSound]?.setVolume(volume);
  }

  /// Stop playing a [ranchSound]
  Future<void> stop(RanchSound ranchSound) async {
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

  Future<void> play(double volume);

  Future<void> stop();

  Future<void> setVolume(double volume);

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
  Future<void> play(double volume) async {
    await bgm.play(path, volume: volume);
  }

  @override
  Future<void> setVolume(double volume) async {
    await bgm.audioPlayer.setVolume(volume);
  }

  @override
  Future<void> stop() async {
    await bgm.pause();
  }
}
