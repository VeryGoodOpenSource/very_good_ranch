import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:ranch_ui/ranch_ui.dart';
import 'package:very_good_ranch/dialog/view/credits_dialog_page.dart';
import 'package:very_good_ranch/dialog/view/instructions_dialog_page.dart';
import 'package:very_good_ranch/dialog/view/settings_dialog_page.dart';

const settingsRoute = 'settings';
const instructionsRoute = 'instructions';
const creditsRoute = 'credits';

typedef DialogMaxHeightSetter = void Function(double maxHeight);

class Dialog extends StatefulWidget {
  const Dialog._({
    this.initialRoute,
  });

  final String? initialRoute;

  static Future<void> open(
    BuildContext context, {
    String? initialRoute,
  }) {
    return showDialog<void>(
      context: context,
      builder: (_) => Dialog._(
        initialRoute: initialRoute,
      ),
    );
  }

  @override
  State<Dialog> createState() => _DialogState();
}

class _DialogState extends State<Dialog> {
  BoxConstraints modalConstraints =
      ModalTheme.defaultTheme.sizeConstraints.copyWith(
    maxHeight: 100,
  );

  Route<void> onGenerateRoute(RouteSettings settings) {
    late Widget page;
    double? maxHeight;
    double? maxWidth;
    switch (settings.name) {
      case settingsRoute:
        page = const SettingsDialogPage();
        maxHeight = SettingsDialogPage.height;
        break;
      case instructionsRoute:
        page = const InstructionsDialogPage();
        maxHeight = InstructionsDialogPage.height;
        maxWidth = InstructionsDialogPage.width;
        break;
      case creditsRoute:
        page = const CreditsDialogPage();
        maxHeight = CreditsDialogPage.height;
        maxWidth = CreditsDialogPage.width;
        break;
    }

    SchedulerBinding.instance.scheduleFrameCallback((timeStamp) {
      setState(
        () {
          modalConstraints = ModalTheme.defaultTheme.sizeConstraints.copyWith(
            maxHeight: maxHeight,
            maxWidth: maxWidth,
          );
        },
      );
    });

    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: Duration.zero,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ModalTheme(
      data: ModalTheme.defaultTheme.withConstraints(
        modalConstraints.normalize(),
      ),
      child: Modal(
        content: Navigator(
          initialRoute: widget.initialRoute ?? settingsRoute,
          onGenerateRoute: onGenerateRoute,
        ),
      ),
    );
  }
}

extension on ModalThemeData {
  ModalThemeData withConstraints(BoxConstraints sizeConstraints) {
    return ModalThemeData(
      outerPadding: outerPadding,
      innerPadding: innerPadding,
      sliderThemeData: sliderThemeData,
      dividerThemeData: dividerThemeData,
      elevatedButtonThemeData: elevatedButtonThemeData,
      contentResizeDuration: contentResizeDuration,
      sizeConstraints: sizeConstraints,
      cardDecoration: cardDecoration,
      cardBorderRadius: cardBorderRadius,
      cardColor: cardColor,
      closeButtonDecoration: closeButtonDecoration,
      closeButtonIconColor: closeButtonIconColor,
      titleTextStyle: titleTextStyle,
      titleTextAlign: titleTextAlign,
    );
  }
}
