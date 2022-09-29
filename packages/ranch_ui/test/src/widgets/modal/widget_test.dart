import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:ranch_ui/ranch_ui.dart';

void main() {
  group('Modal', () {
    group('showCloseButton', () {
      testWidgets('should be true by default', (tester) async {
        await tester.pumpModal(
          Modal(
            content: ModalScaffold(
              title: const Text('Title'),
              body: Container(
                padding: const EdgeInsets.all(12),
                child: const Text('Content'),
              ),
              footer: const Text('Footer'),
            ),
          ),
        );

        expect(find.byType(ModalCloseButton), findsOneWidget);
      });

      testWidgets('should not have a close button when false', (tester) async {
        await tester.pumpModal(
          Modal(
            showCloseButton: false,
            content: ModalScaffold(
              title: const Text('Title'),
              body: Container(
                padding: const EdgeInsets.all(12),
                child: const Text('Content'),
              ),
              footer: const Text('Footer'),
            ),
          ),
        );

        expect(find.byType(ModalCloseButton), findsNothing);
      });
    });

    group('close button', () {
      testWidgets('should pop route', (tester) async {
        final navigator = MockNavigator();

        await tester.pumpModal(
          navigator: navigator,
          Modal(
            content: ModalScaffold(
              title: const Text('Title'),
              body: Container(
                padding: const EdgeInsets.all(12),
                child: const Text('Content'),
              ),
              footer: const Text('Footer'),
            ),
          ),
        );

        await tester.tap(find.byType(ModalCloseButton));

        verify(navigator.pop).called(1);
      });
    });

    group('content', () {
      testWidgets(
        'should scroll when there is a huge content',
        (tester) async {
          late double maxScrollExtent;

          await tester.pumpModal(
            NotificationListener<ScrollMetricsNotification>(
              onNotification: (notification) {
                maxScrollExtent = notification.metrics.maxScrollExtent;
                return true;
              },
              child: Modal(
                content: ModalScaffold(
                  title: const Text('Title'),
                  body: Container(
                    height: 1000,
                    padding: const EdgeInsets.all(12),
                    child: const Text('Content'),
                  ),
                  footer: const Text('Footer'),
                ),
              ),
            ),
          );

          expect(
            maxScrollExtent,
            moreOrLessEquals(566), //  the size of the content - viewport
          );
          expect(maxScrollExtent, greaterThan(0.0));
        },
      );

      testWidgets(
        'should not scroll when there is a tiny content',
        (tester) async {
          late double maxScrollExtent;

          await tester.pumpModal(
            NotificationListener<ScrollMetricsNotification>(
              onNotification: (notification) {
                maxScrollExtent = notification.metrics.maxScrollExtent;
                return true;
              },
              child: const Modal(
                content: ModalScaffold(
                  title: Text('Title'),
                  body: SizedBox(
                    height: 10,
                    child: Text('Content'),
                  ),
                  footer: Text('Footer'),
                ),
              ),
            ),
          );

          expect(maxScrollExtent, 0.0);
        },
      );
    });

    group('internal themes', () {
      testWidgets(
        'should have an internal divider theme',
        (tester) async {
          late DividerThemeData dividerThemeData;
          await tester.pumpModal(
            Modal(
              content: ModalScaffold(
                title: const Text('Title'),
                body: Builder(
                  builder: (context) {
                    dividerThemeData = DividerTheme.of(context);
                    return Container(
                      padding: const EdgeInsets.all(12),
                      child: const Text('Content'),
                    );
                  },
                ),
                footer: const Text('Footer'),
              ),
            ),
          );

          expect(dividerThemeData, ModalTheme.defaultTheme.dividerThemeData);
        },
      );

      testWidgets(
        'should have an elevated button theme',
        (tester) async {
          late ElevatedButtonThemeData elevatedButtonThemeData;
          await tester.pumpModal(
            Modal(
              content: ModalScaffold(
                title: const Text('Title'),
                body: Builder(
                  builder: (context) {
                    elevatedButtonThemeData = ElevatedButtonTheme.of(context);
                    return Container(
                      padding: const EdgeInsets.all(12),
                      child: const Text('Content'),
                    );
                  },
                ),
                footer: const Text('Footer'),
              ),
            ),
          );

          expect(
            elevatedButtonThemeData,
            ModalTheme.defaultTheme.elevatedButtonThemeData,
          );
        },
      );

      testWidgets(
        'should have an slider theme',
        (tester) async {
          late SliderThemeData sliderThemeData;
          await tester.pumpModal(
            Modal(
              content: ModalScaffold(
                title: const Text('Title'),
                body: Builder(
                  builder: (context) {
                    sliderThemeData = SliderTheme.of(context);
                    return Container(
                      padding: const EdgeInsets.all(12),
                      child: const Text('Content'),
                    );
                  },
                ),
                footer: const Text('Footer'),
              ),
            ),
          );

          expect(
            sliderThemeData,
            ModalTheme.defaultTheme.sliderThemeData,
          );
        },
      );
    });
  });

  testWidgets(
    'custom theme',
    (tester) async {
      ModalThemeData themeDataProvided;
      late ModalThemeData themeDataFound;

      await tester.pumpModal(
        ModalTheme(
          data: themeDataProvided = ModalThemeData(
            outerPadding: const EdgeInsets.all(400),
            innerPadding: ModalTheme.defaultTheme.innerPadding,
            sliderThemeData: ModalTheme.defaultTheme.sliderThemeData,
            dividerThemeData: ModalTheme.defaultTheme.dividerThemeData,
            elevatedButtonThemeData:
                ModalTheme.defaultTheme.elevatedButtonThemeData,
            contentResizeDuration:
                ModalTheme.defaultTheme.contentResizeDuration,
            sizeConstraints: ModalTheme.defaultTheme.sizeConstraints,
            cardDecoration: ModalTheme.defaultTheme.cardDecoration,
            cardBorderRadius: ModalTheme.defaultTheme.cardBorderRadius,
            cardColor: ModalTheme.defaultTheme.cardColor,
            closeButtonDecoration:
                ModalTheme.defaultTheme.closeButtonDecoration,
            closeButtonIconColor: ModalTheme.defaultTheme.closeButtonIconColor,
            titleTextStyle: ModalTheme.defaultTheme.titleTextStyle,
            titleTextAlign: ModalTheme.defaultTheme.titleTextAlign,
          ),
          child: Modal(
            content: Builder(
              builder: (context) {
                themeDataFound = ModalTheme.of(context);
                return ModalScaffold(
                  title: const Text('Title'),
                  body: Container(
                    padding: const EdgeInsets.all(12),
                    child: const Text('Content'),
                  ),
                  footer: const Text('Footer'),
                );
              },
            ),
          ),
        ),
      );

      expect(
        themeDataFound,
        themeDataProvided,
      );

      // now change theme
      await tester.pumpModal(
        ModalTheme(
          data: themeDataProvided = ModalThemeData(
            outerPadding: const EdgeInsets.all(400),
            innerPadding: const EdgeInsets.all(100),
            sliderThemeData: ModalTheme.defaultTheme.sliderThemeData,
            dividerThemeData: ModalTheme.defaultTheme.dividerThemeData,
            elevatedButtonThemeData:
                ModalTheme.defaultTheme.elevatedButtonThemeData,
            contentResizeDuration:
                ModalTheme.defaultTheme.contentResizeDuration,
            sizeConstraints: ModalTheme.defaultTheme.sizeConstraints,
            cardDecoration: ModalTheme.defaultTheme.cardDecoration,
            cardBorderRadius: ModalTheme.defaultTheme.cardBorderRadius,
            cardColor: ModalTheme.defaultTheme.cardColor,
            closeButtonDecoration:
                ModalTheme.defaultTheme.closeButtonDecoration,
            closeButtonIconColor: ModalTheme.defaultTheme.closeButtonIconColor,
            titleTextStyle: ModalTheme.defaultTheme.titleTextStyle,
            titleTextAlign: ModalTheme.defaultTheme.titleTextAlign,
          ),
          child: Modal(
            content: Builder(
              builder: (context) {
                themeDataFound = ModalTheme.of(context);
                return ModalScaffold(
                  title: const Text('Title'),
                  body: Container(
                    padding: const EdgeInsets.all(12),
                    child: const Text('Content'),
                  ),
                  footer: const Text('Footer'),
                );
              },
            ),
          ),
        ),
      );

      expect(
        themeDataFound,
        themeDataProvided,
      );
    },
  );
}

extension on WidgetTester {
  Future<void> pumpModal(
    Widget widget, {
    MockNavigator? navigator,
  }) async {
    await runAsync(() async {
      final content = Directionality(
        textDirection: TextDirection.ltr,
        child: Center(
          child: widget,
        ),
      );

      await pumpWidget(
        navigator != null
            ? MockNavigatorProvider(navigator: navigator, child: content)
            : content,
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
