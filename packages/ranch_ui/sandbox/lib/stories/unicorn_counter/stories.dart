import 'package:dashbook/dashbook.dart';
import 'package:flutter/widgets.dart';
import 'package:ranch_ui/ranch_ui.dart';

void addUnicornCounterStories(Dashbook dashbook) {
  dashbook.storiesOf('UnicornCounter').add('Playground', (context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        UnicornCounterTheme(
          data: UnicornCounterTheme.defaultTheme,
          child: const UnicornCounter(
            isActive: true,
            type: UnicornType.baby,
            child: Text('1'),
          ),
        ),
        const SizedBox(height: 16),
        UnicornCounterTheme(
          data: UnicornCounterTheme.defaultTheme,
          child: const UnicornCounter(
            isActive: true,
            type: UnicornType.child,
            child: Text('1'),
          ),
        ),
        const SizedBox(height: 16),
        UnicornCounterTheme(
          data: UnicornCounterTheme.defaultTheme,
          child: const UnicornCounter(
            isActive: true,
            type: UnicornType.teen,
            child: Text('1'),
          ),
        ),
        const SizedBox(height: 16),
        UnicornCounterTheme(
          data: UnicornCounterTheme.defaultTheme,
          child: const UnicornCounter(
            isActive: true,
            type: UnicornType.adult,
            child: Text('0'),
          ),
        ),
      ],
    );
  });
}
