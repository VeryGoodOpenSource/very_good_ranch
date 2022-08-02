// ignore_for_file: prefer_const_constructors

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ranch_ui/ranch_ui.dart';

void main() {
  group('UnicornCounter', () {
    testWidgets('renders baby counter', (tester) async {
      await tester.pumpWidget(
        const Center(
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: UnicornCounter(
              isActive: true,
              type: UnicornType.baby,
              child: SizedBox(),
            ),
          ),
        ),
      );

      await expectLater(
        find.byType(UnicornCounter),
        matchesGoldenFile('golden/unicorn_counter/baby.png'),
      );
    });

    testWidgets('renders child counter', (tester) async {
      await tester.pumpWidget(
        const Center(
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: UnicornCounter(
              isActive: true,
              type: UnicornType.child,
              child: SizedBox(),
            ),
          ),
        ),
      );

      await expectLater(
        find.byType(UnicornCounter),
        matchesGoldenFile('golden/unicorn_counter/child.png'),
      );
    });

    testWidgets('renders teen counter', (tester) async {
      await tester.pumpWidget(
        const Center(
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: UnicornCounter(
              isActive: true,
              type: UnicornType.teen,
              child: SizedBox(),
            ),
          ),
        ),
      );

      await expectLater(
        find.byType(UnicornCounter),
        matchesGoldenFile('golden/unicorn_counter/teen.png'),
      );
    });

    testWidgets('renders adult counter', (tester) async {
      await tester.pumpWidget(
        const Center(
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: UnicornCounter(
              isActive: true,
              type: UnicornType.adult,
              child: SizedBox(),
            ),
          ),
        ),
      );

      await expectLater(
        find.byType(UnicornCounter),
        matchesGoldenFile('golden/unicorn_counter/adult.png'),
      );
    });

    testWidgets('renders inactive counter', (tester) async {
      await tester.pumpWidget(
        const Center(
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: UnicornCounter(
              isActive: false,
              type: UnicornType.adult,
              child: SizedBox(),
            ),
          ),
        ),
      );

      await expectLater(
        find.byType(UnicornCounter),
        matchesGoldenFile('golden/unicorn_counter/inactive.png'),
      );
    });

    testWidgets('custom theme', (tester) async {
      await tester.pumpWidget(
        const UnicornCounterTheme(
          data: UnicornCounterThemeData(
            activeColor: Color(0xFF2A020B),
            inactiveColor: Color(0xFF99ADFF),
            textStyle: TextStyle(),
            size: 20,
          ),
          child: Center(
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: UnicornCounter(
                isActive: true,
                type: UnicornType.baby,
                child: SizedBox(),
              ),
            ),
          ),
        ),
      );

      await expectLater(
        find.byType(UnicornCounter),
        matchesGoldenFile('golden/unicorn_counter/theme.png'),
      );

      await tester.pumpWidget(
        const UnicornCounterTheme(
          data: UnicornCounterThemeData(
            activeColor: Color(0xFF2A020B),
            inactiveColor: Color(0xFF99ADFF),
            textStyle: TextStyle(),
            size: 20,
          ),
          child: Center(
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: UnicornCounter(
                isActive: true,
                type: UnicornType.baby,
                child: SizedBox(),
              ),
            ),
          ),
        ),
      );

      await expectLater(
        find.byType(UnicornCounter),
        matchesGoldenFile('golden/unicorn_counter/theme-2.png'),
      );
    });
  });

  test('themes are equal', () {
    final theme = UnicornCounterThemeData(
      activeColor: Color(0xFF2A020B),
      inactiveColor: Color(0xFF99ADFF),
      textStyle: TextStyle(),
      size: 20,
    );

    expect(
      theme,
      equals(
        UnicornCounterThemeData(
          activeColor: Color(0xFF2A020B),
          inactiveColor: Color(0xFF99ADFF),
          textStyle: TextStyle(),
          size: 20,
        ),
      ),
    );
  });
}
