// ignore_for_file: prefer_const_constructors

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ranch_ui/ranch_ui.dart';

void main() {
  group('UnicornCounter', () {
    testWidgets('renders baby counter', (tester) async {
      await tester.pumpUnicornCounter(
        UnicornCounter(
          isActive: true,
          type: UnicornType.baby,
          child: SizedBox(),
        ),
      );

      await expectLater(
        find.byType(UnicornCounter),
        matchesGoldenFile('golden/unicorn_counter/baby.png'),
      );
    });

    testWidgets('renders child counter', (tester) async {
      await tester.pumpUnicornCounter(
        UnicornCounter(
          isActive: true,
          type: UnicornType.child,
          child: SizedBox(),
        ),
      );

      await expectLater(
        find.byType(UnicornCounter),
        matchesGoldenFile('golden/unicorn_counter/child.png'),
      );
    });

    testWidgets('renders teen counter', (tester) async {
      await tester.pumpUnicornCounter(
        UnicornCounter(
          isActive: true,
          type: UnicornType.teen,
          child: SizedBox(),
        ),
      );

      await expectLater(
        find.byType(UnicornCounter),
        matchesGoldenFile('golden/unicorn_counter/teen.png'),
      );
    });

    testWidgets('renders adult counter', (tester) async {
      await tester.pumpUnicornCounter(
        UnicornCounter(
          isActive: true,
          type: UnicornType.adult,
          child: SizedBox(),
        ),
      );

      await expectLater(
        find.byType(UnicornCounter),
        matchesGoldenFile('golden/unicorn_counter/adult.png'),
      );
    });

    testWidgets('renders inactive counter', (tester) async {
      await tester.pumpUnicornCounter(
        UnicornCounter(
          isActive: false,
          type: UnicornType.adult,
          child: SizedBox(),
        ),
      );

      await expectLater(
        find.byType(UnicornCounter),
        matchesGoldenFile('golden/unicorn_counter/inactive.png'),
      );
    });

    testWidgets('custom theme', (tester) async {
      await tester.pumpUnicornCounter(
        const UnicornCounterTheme(
          data: UnicornCounterThemeData(
            activeColor: Color(0xFF2A020B),
            inactiveColor: Color(0xFF99ADFF),
            textStyle: TextStyle(),
            size: 20,
          ),
          child: UnicornCounter(
            isActive: true,
            type: UnicornType.baby,
            child: SizedBox(),
          ),
        ),
      );

      await expectLater(
        find.byType(UnicornCounter),
        matchesGoldenFile('golden/unicorn_counter/theme.png'),
      );

      await tester.pumpUnicornCounter(
        const UnicornCounterTheme(
          data: UnicornCounterThemeData(
            activeColor: Color(0xFF2A020B),
            inactiveColor: Color(0xFF99ADFF),
            textStyle: TextStyle(),
            size: 20,
          ),
          child: UnicornCounter(
            isActive: true,
            type: UnicornType.baby,
            child: SizedBox(),
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

extension on WidgetTester {
  Future<void> pumpUnicornCounter(Widget widget) async {
    await runAsync(() async {
      await pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Center(
            child: widget,
          ),
        ),
      );
      for (final element in find.byType(Image).evaluate()) {
        final widget = element.widget as Image;
        final image = widget.image;
        await precacheImage(image, element);
        await pumpAndSettle();
      }
    });
  }
}
