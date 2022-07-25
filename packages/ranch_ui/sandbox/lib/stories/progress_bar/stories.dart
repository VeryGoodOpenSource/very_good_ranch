import 'package:dashbook/dashbook.dart';
import 'package:flutter/widgets.dart';
import 'package:ranch_ui/ranch_ui.dart';

void addProgressBarStories(Dashbook dashbook) {
  dashbook.storiesOf('AnimatedProgressBar').add('Playground', (context) {
    final progressProperty = context.numberProperty('percentage', 50);

    return Center(
      child: AnimatedProgressBar(
        progress: (progressProperty / 100).clamp(0.0, 1.0),
      ),
    );
  });
}
