import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flame_audio/bgm.dart';
import 'package:ranch_sounds/gen/assets.gen.dart';
import 'package:ranch_sounds/src/no_prefix_audiocache.dart';

/// Type signature for callbacks that create a [Bgm] with an [audioCache]
typedef CreateBGM = Bgm Function();

/// {@template ranch_sounds}
/// A collection of sounds typical of any Unicorn ranch
/// that share the same [audioCache].
/// {@endtemplate}
class RanchSounds {
  /// {@macro ranch_sounds}
  RanchSounds({
    required this.audioCache,
    CreateBGM? createBGM,
  }) {
    final _createBGM = createBGM ?? () => Bgm(audioCache: audioCache);
    startBackground = BackgroundSound._(
      Assets.music.startBackground,
      _createBGM(),
    );
    gameBackground = BackgroundSound._(
      Assets.music.gameBackground,
      _createBGM(),
    );
  }

  /// Preload all sound assets into [audioCache].
  Future<void> preloadAssets() {
    return Future.wait([
      startBackground._load(),
      gameBackground._load(),
    ]);
  }

  /// The [AudioCache] in wich the sounds are preloaded to.
  final UnprefixedAudioCache audioCache;

  /// A [RanchSound] of a pretty music.
  late final RanchSound startBackground;

  /// A [RanchSound] of a cheerful music.
  late final RanchSound gameBackground;

  void dispose() async {
    startBackground._dispose();
    gameBackground._dispose();
  }
}

String _prefixFile(String file) {
  return 'packages/ranch_sounds/$file';
}

/// Represents a
abstract class RanchSound {
  RanchSound._(String path) {
    this.path = _prefixFile(path);
  }

  late final String path;

  Future<void> _load();

  Future<AudioPlayer> play();

  void _dispose();
}

class BackgroundSound extends RanchSound {
  BackgroundSound._(String path, this.bgm) : super._(path);

  final Bgm bgm;

  @override
  Future<void> _load() async {
    bgm.initialize();
    await bgm.audioPlayer.audioCache.load(path);
  }

  @override
  FutureOr<void> _dispose() {
    bgm.dispose();
  }

  @override
  Future<AudioPlayer> play() async {
    await bgm.play(path);

    return bgm.audioPlayer;
  }
}
