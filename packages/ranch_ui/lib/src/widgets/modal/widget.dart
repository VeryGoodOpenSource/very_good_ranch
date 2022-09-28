import 'package:flutter/material.dart';
import 'package:ranch_ui/src/theme/theme.dart';
import 'package:ranch_ui/src/widgets/modal/theme.dart';

/// {@template modal}
/// A [Widget] that renders a very good modal.
/// {@endtemplate}
class Modal extends StatelessWidget {
  /// {@macro modal}
  const Modal({
    super.key,
    this.showCloseButton = true,
    required this.title,
    required this.content,
    required this.footer,
  });

  /// Either show or not show a close button
  final bool showCloseButton;

  /// The title of the modal
  final Widget title;

  /// The contents of the modal
  final Widget content;

  /// The footer of the modal
  final Widget footer;

  @override
  Widget build(BuildContext context) {
    final theme = ModalTheme.of(context);

    return ElevatedButtonTheme(
      data: theme.elevatedButtonThemeData,
      child: DividerTheme(
        data: theme.dividerThemeData,
        child: DefaultTextStyle.merge(
          style: RanchUITheme.minorFontTextStyle,
          child: SliderTheme(
            data: theme.sliderThemeData,
            child: Center(
              child: _ModalCard(
                showCloseButton: showCloseButton,
                theme: theme,
                head: _ModalTitle(
                  theme: theme,
                  child: title,
                ),
                body: _ModalContent(
                  theme: theme,
                  child: content,
                ),
                footer: _ModalFooter(
                  theme: theme,
                  child: footer,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ModalCard extends StatelessWidget {
  const _ModalCard({
    required this.head,
    required this.body,
    required this.footer,
    required this.theme,
    required this.showCloseButton,
  });

  final Widget head;

  final Widget body;

  final Widget footer;

  final bool showCloseButton;

  final ModalThemeData theme;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: theme.sizeConstraints,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Padding(
            padding: theme.outerPadding,
            child: DecoratedBox(
              decoration: theme.cardDecoration,
              child: ClipRRect(
                borderRadius: theme.cardBorderRadius,
                child: ColoredBox(
                  color: theme.cardColor,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: theme.innerPadding.left,
                      right: theme.innerPadding.right,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        head,
                        Flexible(child: body),
                        footer,
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (showCloseButton)
            ModalCloseButton(
              onTap: () => Navigator.of(context).pop(),
              theme: theme,
            ),
        ],
      ),
    );
  }
}

@visibleForTesting
// ignore: public_member_api_docs
class ModalCloseButton extends StatelessWidget {
  // ignore: public_member_api_docs
  const ModalCloseButton({
    super.key,
    required this.onTap,
    required this.theme,
  });

  // ignore: public_member_api_docs
  final VoidCallback onTap;

  // ignore: public_member_api_docs
  final ModalThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: theme.outerPadding.top - 16,
      right: theme.outerPadding.right - 16,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: onTap,
          child: SizedBox.fromSize(
            size: const Size.square(40),
            child: DecoratedBox(
              decoration: theme.closeButtonDecoration,
              child: Center(
                child: Icon(
                  Icons.close,
                  color: theme.closeButtonIconColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ModalTitle extends StatelessWidget {
  const _ModalTitle({
    required this.child,
    required this.theme,
  });

  final Widget child;

  final ModalThemeData theme;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle.merge(
      textAlign: theme.titleTextAlign,
      style: theme.titleTextStyle,
      child: Padding(
        padding: EdgeInsets.only(
          top: theme.innerPadding.top,
          bottom: theme.innerPadding.bottom,
        ),
        child: child,
      ),
    );
  }
}

class _ModalContent extends StatelessWidget {
  const _ModalContent({
    required this.child,
    required this.theme,
  });

  final Widget child;

  final ModalThemeData theme;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AnimatedSize(
        duration: theme.contentResizeDuration,
        child: Material(
          color: Colors.transparent,
          child: child,
        ),
      ),
    );
  }
}

class _ModalFooter extends StatelessWidget {
  const _ModalFooter({
    required this.child,
    required this.theme,
  });

  final Widget child;

  final ModalThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: theme.innerPadding.top,
        bottom: theme.innerPadding.bottom,
      ),
      child: child,
    );
  }
}
