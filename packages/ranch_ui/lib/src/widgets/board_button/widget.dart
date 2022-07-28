import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ranch_ui/gen/assets.gen.dart';
import 'package:ranch_ui/src/widgets/board_button/theme.dart';
import 'package:sprung/sprung.dart';

/// {@template board_button}
/// A [Widget] that renders a button that looks like a piece of wood.
/// {@endtemplate}
class BoardButton extends StatelessWidget {
  /// {@macro board_button}
  const BoardButton({
    super.key,
    required this.child,
    this.onTap,
  });

  /// The contents of the button
  final Widget child;

  /// The callback to be invoked when the button is clicked
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = BoardButtonTheme.of(context);

    return _BoardButtonRotate(
      duration: theme.animationDuration,
      onTap: onTap,
      child: _applyImage(
        SizedBox.fromSize(
          size: theme.size,
          child: Center(
            child: DefaultTextStyle.merge(
              style: theme.textStyle,
              child: child,
            ),
          ),
        ),
      ),
    );
  }

  Widget _applyImage(Widget child) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            Assets.images.board.keyName,
            excludeFromSemantics: true,
          ),
        ),
        child,
      ],
    );
  }
}

class _BoardButtonRotate extends StatefulWidget {
  const _BoardButtonRotate({
    required this.onTap,
    required this.duration,
    required this.child,
  });

  final Duration duration;
  final VoidCallback? onTap;
  final Widget child;

  @override
  State<_BoardButtonRotate> createState() => _BoardButtonRotateState();
}

class _BoardButtonRotateState extends State<_BoardButtonRotate> {
  bool isHover = false;
  bool isDown = false;

  static final tapDownTransform = Matrix4.identity()
    ..rotateZ(5 * pi / 180)
    ..scale(0.9);

  static final originTransform = Matrix4.identity();

  Matrix4 get transform {
    if (isDown) {
      return tapDownTransform;
    }
    if (isHover) {
      return Matrix4Tween(
        begin: originTransform,
        end: tapDownTransform,
      ).lerp(0.25);
    }

    return originTransform;
  }

  void handleTapDown(TapDownDetails details) {
    setState(() {
      isDown = true;
    });
  }

  void handleTapCancel() {
    setState(() {
      isDown = false;
    });
  }

  void handleTapUp(TapUpDetails details) {
    setState(() {
      isDown = false;
    });
    widget.onTap?.call();
  }

  void handleMouseEnter(PointerEnterEvent e) {
    setState(() {
      isHover = true;
    });
  }

  void handleMouseExit(PointerExitEvent e) {
    setState(() {
      isHover = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: handleMouseEnter,
      onExit: handleMouseExit,
      child: GestureDetector(
        onTapDown: handleTapDown,
        onTapUp: handleTapUp,
        onTapCancel: handleTapCancel,
        child: AnimatedContainer(
          curve: Sprung.custom(
            damping: 60,
          ),
          duration: widget.duration,
          transform: transform,
          transformAlignment: Alignment.center,
          child: widget.child,
        ),
      ),
    );
  }
}
