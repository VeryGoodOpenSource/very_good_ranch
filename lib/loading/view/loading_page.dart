import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_ranch/app/view/game_viewport.dart';
import 'package:very_good_ranch/gen/assets.gen.dart';
import 'package:very_good_ranch/l10n/l10n.dart';
import 'package:very_good_ranch/loading/cubit/cubit.dart';
import 'package:very_good_ranch/title/view/title_page.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final cubit = BlocProvider.of<PreloadCubit>(context);
    cubit.loadSequentially().then((_) {
      onPreloadComplete(cubit);
    });
  }

  Future<void> onPreloadComplete(PreloadCubit cubit) async {
    if (mounted == false) {
      return;
    }
    final navigator = Navigator.of(context);
    await Future<void>.delayed(AnimatedProgressBar.intrinsicAnimationDuration);
    await navigator.pushReplacement<void, void>(TitlePage.route());
  }

  @override
  Widget build(BuildContext context) {
    return const GameViewport(
      child: Scaffold(
        body: ColoredBox(
          color: Color(0xFF46B2A0),
          child: Center(
            child: _LoadingInternal(),
          ),
        ),
      ),
    );
  }
}

class _LoadingInternal extends StatelessWidget {
  const _LoadingInternal();

  @override
  Widget build(BuildContext context) {
    final primaryTextTheme = Theme.of(context).primaryTextTheme;
    final l10n = context.l10n;

    return BlocBuilder<PreloadCubit, PreloadState>(
      builder: (context, state) {
        final loadingLabel = l10n.loadingPhaseLabel(state.currentLabel);
        final loadingMessage = l10n.loading(loadingLabel);
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Assets.images.loading.image(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: AnimatedProgressBar(progress: state.progress),
            ),
            Text(
              loadingMessage,
              style: primaryTextTheme.bodySmall!.copyWith(
                color: const Color(0xFF0C5A4D),
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        );
      },
    );
  }
}

/// A [Widget] that renders a intrinsically animated progress bar
@visibleForTesting
class AnimatedProgressBar extends StatelessWidget {
  const AnimatedProgressBar({super.key, required this.progress})
      : assert(
          progress >= 0.0 && progress <= 1.0,
          'Progress should be set between 0.0 and 1.0',
        );

  final double progress;

  static const Duration intrinsicAnimationDuration =
      Duration(milliseconds: 300);

  @override
  Widget build(BuildContext context) {
    // Outer bar
    return ClipRRect(
      borderRadius: BorderRadius.circular(2),
      child: SizedBox(
        height: 16,
        width: 200,
        child: ColoredBox(
          color: const Color(0xFF0D6052),
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
                    child: const ColoredBox(
                      color: Color(0xFF99FDFF),
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
