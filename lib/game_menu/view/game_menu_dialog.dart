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
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) {
        late Widget page;
        double? maxWidth;
        double? maxHeight;

        final route = GameMenuRoute.values.firstWhere(
          (element) {
            return element.name == settings.name;
          },
        );

        switch (route) {
          case GameMenuRoute.settings:
            page = const SettingsDialogPage();
            maxHeight = SettingsDialogPage.maxDialogHeight;
            break;
          case GameMenuRoute.instructions:
            page = const InstructionsDialogPage();
            maxWidth = InstructionsDialogPage.maxDialogWidth;
            maxHeight = InstructionsDialogPage.maxDialogHeight;

            break;
          case GameMenuRoute.credits:
            page = const CreditsDialogPage();
            maxWidth = CreditsDialogPage.maxDialogWidth;
            maxHeight = CreditsDialogPage.maxDialogHeight;

            break;
        }

        SchedulerBinding.instance.scheduleFrameCallback((timeStamp) {
          setState(
            () {
              modalConstraints =
                  ModalTheme.defaultTheme.sizeConstraints.copyWith(
                maxWidth: maxWidth,
                maxHeight: maxHeight,
              );
            },
          );
        });
        return page;
      },
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
