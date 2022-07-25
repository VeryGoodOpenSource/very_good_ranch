import 'package:flutter/material.dart';
import 'package:ranch_ui/src/progress_bar/theme.dart';

/// {@template animated_progress_bar}
/// A [Widget] that renders a intrinsically animated progress bar.
///
/// [progress] should be between 0 and 1;
/// {@endtemplate}
class AnimatedProgressBar extends StatelessWidget {
  /// {@macro animated_progress_bar}
  const AnimatedProgressBar({super.key, required this.progress})
      : assert(
          progress >= 0.0 && progress <= 1.0,
          'Progress should be set between 0.0 and 1.0',
        );

  /// The current progress for the bar.
  final double progress;

  /// The duration of the animation on [AnimatedProgressBar]
  static const Duration intrinsicAnimationDuration =
      Duration(milliseconds: 300);

  @override
  Widget build(BuildContext context) {
    final theme = AnimatedProgressBarTheme.of(context);

    // Outer bar
    return ClipRRect(
      borderRadius: BorderRadius.circular(2),
      child: SizedBox(
        height: 16,
        width: 200,
        child: ColoredBox(
          color: theme.backgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(2),
            // Animate the progress bar
            child: TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: progress),
              duration: intrinsicAnimationDuration,
              builder: (BuildContext context, double progress, _) {
                // Inner bar
                return FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: progress,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(1),
                    child: ColoredBox(
                      color: theme.foregroundColor,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
