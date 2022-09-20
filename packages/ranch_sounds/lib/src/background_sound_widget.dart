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
    required this.volume,
  });

  /// The sound to be played
  final RanchSound ranchSound;

  /// The [RanchSoundPlayer] responsible to manage the underlying sound cache.
  final RanchSoundPlayer player;

  /// This widget is supposed to wrap something.
  final Widget child;

  /// The volume in which the sound is supposed to played at.
  final double volume;

  @override
  State<BackgroundSoundWidget> createState() => _BackgroundSoundWidgetState();
}

class _BackgroundSoundWidgetState extends State<BackgroundSoundWidget> {
  @override
  void initState() {
    super.initState();
    widget.player.play(widget.ranchSound, volume: widget.volume);
  }

  @override
  void didUpdateWidget(covariant BackgroundSoundWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.ranchSound != widget.ranchSound) {
      widget.player.stop(oldWidget.ranchSound);
      widget.player.play(widget.ranchSound, volume: widget.volume);
      return;
    }

    if (oldWidget.volume != widget.volume) {
      widget.player.setVolume(widget.ranchSound, volume: widget.volume);
    }
  }

  @override
  void dispose() {
    widget.player.stop(widget.ranchSound);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
