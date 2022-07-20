// ignore_for_file: cascade_invocations

import 'package:flame/components.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ranch_components/ranch_components.dart';
import 'package:very_good_ranch/game/entities/entities.dart';
import 'package:very_good_ranch/game/entities/food/behaviors/behaviors.dart';

import '../../../../helpers/helpers.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final flameTester = FlameTester(TestGame.new);

  group('DraggingBehavior', () {
    flameTester.testGameWidget(
      'is draggable',
      setUp: (game, tester) async {
        final food = Food.test(behaviors: [DraggingBehavior()]);
        await game.ensureAdd(food);
        await game.ready();

        await tester.dragFrom(
          Offset.zero,
          const Offset(100, 100),
        );
        await tester.pump();
      },
      verify: (game, tester) async {
        await expectLater(
          find.byGame<TestGame>(),
          matchesGoldenFile('golden/draggable/dragged.png'),
        );
      },
    );

    group('beingDragged', () {
      flameTester.testGameWidget(
        'set it to true on drag start',
        setUp: (game, tester) async {
          final food = Food.test(behaviors: [DraggingBehavior()]);
          await game.ensureAdd(food);
          await game.ready();

          final gesture = await tester.createGesture();
          await gesture.down(Offset.zero);
          await gesture.moveTo(const Offset(100, 100));
          await tester.pump();
        },
        verify: (game, tester) async {
          final food = game.descendants().whereType<Food>().first;

          expect(food.beingDragged, isTrue);
        },
      );

      flameTester.testGameWidget(
        'set it to false on drag stop',
        setUp: (game, tester) async {
          final food = Food.test(behaviors: [DraggingBehavior()]);
          await game.ensureAdd(food);
          await game.ready();

          final gesture = await tester.createGesture();
          await gesture.down(Offset.zero);
          await gesture.moveTo(const Offset(100, 100));
          await gesture.up();
          await tester.pump();
        },
        verify: (game, tester) async {
          final food = game.descendants().whereType<Food>().first;

          expect(food.beingDragged, isFalse);
        },
      );

      flameTester.testGameWidget(
        'set it to false on drag cancel',
        setUp: (game, tester) async {
          final food = Food.test(behaviors: [DraggingBehavior()]);
          await game.ensureAdd(food);
          await game.ready();

          final gesture = await tester.createGesture();
          await gesture.down(Offset.zero);
          await gesture.moveTo(const Offset(100, 100));
          await gesture.cancel();
          await tester.pump();
          await tester.pump();
        },
        verify: (game, tester) async {
          final food = game.descendants().whereType<Food>().first;

          expect(food.beingDragged, isFalse);
        },
      );
    });

    group('wasDragged', () {
      flameTester.testGameWidget(
        'set it to true on drag stop',
        setUp: (game, tester) async {
          final food = Food.test(behaviors: [DraggingBehavior()]);
          await game.ensureAdd(food);
          await game.ready();

          final gesture = await tester.createGesture();
          await gesture.down(Offset.zero);
          await gesture.moveTo(const Offset(100, 100));
          await gesture.up();
          await tester.pump();
        },
        verify: (game, tester) async {
          final food = game.descendants().whereType<Food>().first;
          final draggable =
              game.descendants().whereType<DraggingBehavior>().first;

          expect(food.wasDragged, isTrue);
          expect(draggable.firstChild<TimerComponent>(), isNotNull);
        },
      );

      flameTester.testGameWidget(
        'set it to false after 5 seconds after the drag stop',
        setUp: (game, tester) async {
          final food = Food.test(behaviors: [DraggingBehavior()]);
          await game.ensureAdd(food);
          await game.ready();

          final gesture = await tester.createGesture();
          await gesture.down(Offset.zero);
          await gesture.moveTo(const Offset(100, 100));
          await gesture.up();
          await tester.pump();
        },
        verify: (game, tester) async {
          final food = game.descendants().whereType<Food>().first;
          final draggable =
              game.descendants().whereType<DraggingBehavior>().first;

          expect(food.wasDragged, isTrue);
          expect(draggable.firstChild<TimerComponent>(), isNotNull);

          game.update(5);
          game.update(0);

          expect(food.wasDragged, isFalse);
          expect(draggable.firstChild<TimerComponent>(), isNull);
        },
      );
    });

    flameTester.testGameWidget(
      'only drags one food item',
      setUp: (game, tester) async {
        final food1 = Food.test(behaviors: [DraggingBehavior()]);

        final food2 = Food.test(
          type: FoodType.iceCream,
          behaviors: [DraggingBehavior()],
        );

        await game.ensureAdd(food1);
        await game.ensureAdd(food2);

        await tester.dragFrom(Offset.zero, const Offset(100, 100));
        await tester.pump();
      },
      verify: (game, tester) async {
        await expectLater(
          find.byGame<TestGame>(),
          matchesGoldenFile(
            'golden/draggable/single_item_dragged.png',
          ),
        );
      },
    );

    flameTester.testGameWidget(
      'consume food on drag stop if there was a unicorn near it',
      setUp: (game, tester) async {
        final food = Food.test(behaviors: [DraggingBehavior()]);
        await game.ensureAdd(food);
        await game.ensureAdd(
          Unicorn.test(
            position: Vector2.zero(),
            unicornComponent: AdultUnicornComponent(),
            behaviors: [],
          ),
        );
        await game.ready();

        final gesture = await tester.createGesture();
        await gesture.down(Offset.zero);
        await gesture.moveTo(const Offset(100, 100));
        await gesture.up();
        await tester.pump();
      },
      verify: (game, tester) async {
        expect(game.descendants().whereType<Food>(), isEmpty);
      },
    );
  });
}
