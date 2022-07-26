import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ranch_ui/ranch_ui.dart';

void main() {
  group('AnimatedProgressBar', () {
    testWidgets('0%', (tester) async {
      await tester.pumpWidget(
        const Center(
          child: AnimatedProgressBar(
            progress: 0,
          ),
        ),
      );

      /// flush animation timers
      await tester.pumpAndSettle();

      await expectLater(
        find.byType(AnimatedProgressBar),
        matchesGoldenFile('golden/progressbar/0.png'),
      );
    });

    testWidgets('50%', (tester) async {
      await tester.pumpWidget(
        const Center(
          child: AnimatedProgressBar(
            progress: 0.5,
          ),
        ),
      );

      /// flush animation timers
      await tester.pumpAndSettle();

      await expectLater(
        find.byType(AnimatedProgressBar),
        matchesGoldenFile('golden/progressbar/50.png'),
      );
    });

    testWidgets('100%', (tester) async {
      await tester.pumpWidget(
        const Center(
          child: AnimatedProgressBar(
            progress: 1,
          ),
        ),
      );

      /// flush animation timers
      await tester.pumpAndSettle();

      await expectLater(
        find.byType(AnimatedProgressBar),
        matchesGoldenFile('golden/progressbar/100.png'),
      );
    });

    testWidgets('custom theme', (tester) async {
      await tester.pumpWidget(
        const AnimatedProgressBarTheme(
          data: AnimatedProgressBarThemeData(
            Color(0xFF2A020B),
            Color(0xFF99ADFF),
          ),
          child: Center(
            child: AnimatedProgressBar(
              progress: 0.5,
            ),
          ),
        ),
      );

      /// flush animation timers
      await tester.pumpAndSettle();

      await expectLater(
        find.byType(AnimatedProgressBar),
        matchesGoldenFile('golden/progressbar/theme.png'),
      );

      await tester.pumpWidget(
        const AnimatedProgressBarTheme(
          data: AnimatedProgressBarThemeData(
            Color(0xFFFF003A),
            Color(0xFF9DFF00),
          ),
          child: Center(
            child: AnimatedProgressBar(
              progress: 0.5,
            ),
          ),
        ),
      );

      await expectLater(
        find.byType(AnimatedProgressBar),
        matchesGoldenFile('golden/progressbar/theme-2.png'),
      );
    });

    testWidgets('throws AssertionError if progress is not between 0 and 1',
        (tester) async {
      await expectLater(
        () => tester.pumpWidget(
          Center(
            child: AnimatedProgressBar(
              progress: 2,
            ),
          ),
        ),
        throwsAssertionError,
      );
    });
  });
}
