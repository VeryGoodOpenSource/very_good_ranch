import 'package:flutter/material.dart';

class GameViewport extends StatefulWidget {
  const GameViewport({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<GameViewport> createState() => _GameViewportState();
}

class _GameViewportState extends State<GameViewport> {
  static const minAspectRatio = 9 / 21;
  static const maxAspectRatio = 3 / 4;
  late final double aspectRatio = MediaQuery.of(context).size.aspectRatio;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.black,
      child: Center(
        child: AspectRatio(
          // Cannot clamp inline because of https://github.com/dart-lang/sdk/issues/48812
          aspectRatio: aspectRatio.clamp(minAspectRatio, maxAspectRatio),
          child: widget.child,
        ),
      ),
    );
  }
}
