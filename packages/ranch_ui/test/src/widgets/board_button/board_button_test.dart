import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ranch_ui/ranch_ui.dart';

void main() {
  testWidgets('mounts', (tester) async {
    await tester.pumpWidget(
      const Directionality(
        textDirection: TextDirection.ltr,
        child: BoardButton(
          child: Text(' '),
        ),
      ),
    );

    expect(find.byType(BoardButton), findsOneWidget);
  });

  testWidgets('onTap invokes callback', (tester) async {
    var tapped = false;
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: BoardButton(
          child: const Text(' '),
          onTap: () => tapped = true,
        ),
      ),
    );

    await tester.tap(find.byType(BoardButton));

    expect(tapped, true);
  });

  group('goldens', () {
    testWidgets('initial', (tester) async {
      await tester.pumpBoardButton(
        const BoardButton(
          child: Text(' '),
        ),
      );

      await expectLater(
        find.byType(BoardButton),
        matchesGoldenFile('golden/board_button/initial.png'),
      );
    });

    testWidgets('hover', (tester) async {
      await tester.pumpBoardButton(
        const BoardButton(
          child: Text(' '),
        ),
      );

      final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
      await gesture.addPointer();
      addTearDown(gesture.removePointer);
      await tester.pump();

      await gesture.moveTo(tester.getCenter(find.byType(BoardButton)));
      await tester.pumpAndSettle();

      await expectLater(
        find.byType(BoardButton),
        matchesGoldenFile('golden/board_button/hover_in.png'),
      );

      await gesture.moveTo(Offset.zero);
      await tester.pumpAndSettle();

      await expectLater(
        find.byType(BoardButton),
        matchesGoldenFile('golden/board_button/hover_out.png'),
      );
    });

    testWidgets('on tap', (tester) async {
      await tester.pumpBoardButton(
        const BoardButton(
          child: Text(' '),
        ),
      );

      final gesture = await tester.press(find.byType(BoardButton));
      await tester.pumpAndSettle();

      await expectLater(
        find.byType(BoardButton),
        matchesGoldenFile('golden/board_button/tap_down.png'),
      );

      await gesture.up();
      await tester.pumpAndSettle();

      await expectLater(
        find.byType(BoardButton),
        matchesGoldenFile('golden/board_button/tap_up.png'),
      );

      final gesture2 = await tester.press(find.byType(BoardButton));
      await tester.pumpAndSettle();
      await gesture2.cancel();
      await tester.pumpAndSettle();

      await expectLater(
        find.byType(BoardButton),
        matchesGoldenFile('golden/board_button/tap_cancel.png'),
      );
    });

    testWidgets('minor theme', (tester) async {
      await tester.pumpBoardButton(
        BoardButtonTheme(
          data: BoardButtonTheme.defaultTheme,
          child: const BoardButton(
            child: Text(' '),
          ),
        ),
      );

      await expectLater(
        find.byType(BoardButton),
        matchesGoldenFile('golden/board_button/theme_default.png'),
      );

      await tester.pumpAndSettle();

      await tester.pumpBoardButton(
        BoardButtonTheme.minor(
          child: const BoardButton(
            child: Text(' '),
          ),
        ),
      );

      await expectLater(
        find.byType(BoardButton),
        matchesGoldenFile('golden/board_button/theme_minor.png'),
      );
    });
  });
}

extension on WidgetTester {
  Future<void> pumpBoardButton(Widget widget) async {
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
