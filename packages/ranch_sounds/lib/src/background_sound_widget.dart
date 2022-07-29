import 'package:flutter/widgets.dart';
import 'package:ranch_sounds/src/ranch_sounds.dart';

/// {@template background_sound_widget}
/// A [Widget] that plays a [ranchSound] while it is mounted.
/// {@endtemplate}
class BackgroundSoundWidget extends StatefulWidget {
  /// {@macro background_sound_widget}
  const BackgroundSoundWidget({
    super.key,
    required this.ranchSound,
    required this.player,
    required this.child,
  });

  /// The sound to be played
  final RanchSounds ranchSound;

  /// The [RanchSoundPlayer] responsible to manage the underlying sound cache.
  final RanchSoundPlayer player;

  /// This widget is supposed to wrap something.
  final Widget child;

  @override
  State<BackgroundSoundWidget> createState() => _BackgroundSoundWidgetState();
}

class _BackgroundSoundWidgetState extends State<BackgroundSoundWidget> {
  bool playingSound = false;

  @override
  void initState() {
    super.initState();
    playingSound = true;
    widget.player.play(widget.ranchSound);
  }

  @override
  void dispose() {
    final playingSound = this.playingSound;

    if (playingSound) {
      widget.player.stop(widget.ranchSound);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
