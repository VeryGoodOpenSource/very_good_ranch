import 'package:dashbook/dashbook.dart';
import 'package:flutter/widgets.dart';
import 'package:ranch_ui/ranch_ui.dart';

void addBoardButtonStories(Dashbook dashbook) {
  dashbook.storiesOf('BoardButton').add('Playground', (context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const BoardButton(
          child: Text('Play'),
        ),
        BoardButtonTheme.minor(
          child: const BoardButton(
            child: Text('Settings'),
          ),
        ),
      ],
    );
  });
}
