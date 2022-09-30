import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:ranch_ui/ranch_ui.dart';
import 'package:very_good_ranch/game_menu/view/credits_dialog_page.dart';
import 'package:very_good_ranch/game_menu/view/instructions_dialog_page.dart';
import 'package:very_good_ranch/game_menu/view/settings_dialog_page.dart';

enum GameMenuRoute {
  settings,
  instructions,
  credits;
}

class GameMenuDialog extends StatefulWidget {
  const GameMenuDialog._({
    this.initialRoute,
  });

  final GameMenuRoute? initialRoute;

  static Future<void> open(
    BuildContext context, {
    GameMenuRoute? initialRoute,
  }) {
    return showDialog<void>(
      context: context,
      builder: (_) => GameMenuDialog._(
        initialRoute: initialRoute,
      ),
    );
  }

  @override
  State<GameMenuDialog> createState() => _GameMenuDialogState();
}

class _GameMenuDialogState extends State<GameMenuDialog> {
  BoxConstraints modalConstraints =
      ModalTheme.defaultTheme.sizeConstraints.copyWith(
    maxHeight: 100,
  );

  Route<void> onGenerateRoute(RouteSettings settings) {
    late Widget page;
    double? maxHeight;
    double? maxWidth;

    final route = GameMenuRoute.values.firstWhere(
      (element) {
        return element.name == settings.name;
      },
    );

    switch (route) {
      case GameMenuRoute.settings:
        page = const SettingsDialogPage();
        maxHeight = SettingsDialogPage.height;
        break;
      case GameMenuRoute.instructions:
        page = const InstructionsDialogPage();
        maxHeight = InstructionsDialogPage.height;
        maxWidth = InstructionsDialogPage.width;
        break;
      case GameMenuRoute.credits:
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
          initialRoute: (widget.initialRoute ?? GameMenuRoute.settings).name,
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
