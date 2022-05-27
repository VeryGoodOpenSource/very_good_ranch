import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_ranch/app/view/game_viewport.dart';

void main() {
  group('GameViewport', () {
    testWidgets('viewport too wide', (tester) async {
      tester.binding.window.physicalSizeTestValue = const Size(1000, 500);

      // resets the screen to its original size after the test end
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);

      await tester.pumpWidget(
        const MaterialApp(
          home: GameViewport(
            child: ColoredBox(
              color: Color(0xFFFFFFFF),
              child: SizedBox.expand(),
            ),
          ),
        ),
      );

      await expectLater(
        find.byType(GameViewport),
        matchesGoldenFile('golden/viewport/too_wide.png'),
      );
    });

    testWidgets('viewport too narrow', (tester) async {
      tester.binding.window.physicalSizeTestValue = const Size(200, 1000);

      // resets the screen to its original size after the test end
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);

      await tester.pumpWidget(
        const MaterialApp(
          home: GameViewport(
            child: ColoredBox(
              color: Color(0xFFFFFFFF),
              child: SizedBox.expand(),
            ),
          ),
        ),
      );

      await expectLater(
        find.byType(GameViewport),
        matchesGoldenFile('golden/viewport/too_narrow.png'),
      );
    });

    testWidgets('viewport in between', (tester) async {
      tester.binding.window.physicalSizeTestValue = const Size(700, 1000);

      // resets the screen to its original size after the test end
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);

      await tester.pumpWidget(
        const MaterialApp(
          home: GameViewport(
            child: ColoredBox(
              color: Color(0xFFFFFFFF),
              child: SizedBox.expand(),
            ),
          ),
        ),
      );

      await expectLater(
        find.byType(GameViewport),
        matchesGoldenFile('golden/viewport/in_between.png'),
      );
    });
  });
}
