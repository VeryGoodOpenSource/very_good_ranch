import 'package:flame/components.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ranch_components/src/components/background/background_elements.dart';

import '../../helpers/helpers.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final flameTester = FlameTester(
    () => TestGame(center: true),
  );

  group('Background elements', () {
    flameTester.testGameWidget(
      'sets the priority to the bottom center of the element',
      setUp: (game, tester) async {
        final barn = Barn();
        await game.ensureAdd(barn);
      },
      verify: (game, tester) async {
        final barn = game.firstChild<Barn>()!;

        expect(
          barn.priority,
          equals(barn.positionOfAnchor(Anchor.bottomCenter).y),
        );
      },
    );

    group('BackgroundTreeType', () {
      test('getBackgroundElement', () {
        expect(
          BackgroundTreeType.tall.getBackgroundElement(Vector2.zero()),
          isA<TallTree>(),
        );
        expect(
          BackgroundTreeType.short.getBackgroundElement(Vector2.zero()),
          isA<ShortTree>(),
        );
        expect(
          BackgroundTreeType.lined.getBackgroundElement(Vector2.zero()),
          isA<LinedTree>(),
        );
        expect(
          BackgroundTreeType.linedShort.getBackgroundElement(Vector2.zero()),
          isA<LinedTreeShort>(),
        );
      });
    });

    group('Barn', () {
      flameTester.testGameWidget(
        'renders a Barn',
        setUp: (game, tester) async {
          final barn = Barn();
          await game.ensureAdd(barn);
        },
        verify: (game, tester) async {
          await expectLater(
            find.byGame<TestGame>(),
            matchesGoldenFile('golden/elements/barn.png'),
          );
        },
      );
    });

    group('Sheep', () {
      flameTester.testGameWidget(
        'renders a Sheep',
        setUp: (game, tester) async {
          await game.ensureAdd(Sheep());
        },
        verify: (game, tester) async {
          await expectLater(
            find.byGame<TestGame>(),
            matchesGoldenFile('golden/elements/sheep.png'),
          );
        },
      );
    });

    group('SheepSmall', () {
      flameTester.testGameWidget(
        'renders a SheepSmall',
        setUp: (game, tester) async {
          await game.ensureAdd(SheepSmall());
        },
        verify: (game, tester) async {
          await expectLater(
            find.byGame<TestGame>(),
            matchesGoldenFile('golden/elements/sheep_small.png'),
          );
        },
      );
    });

    group('Cow', () {
      flameTester.testGameWidget(
        'renders a Cow',
        setUp: (game, tester) async {
          await game.ensureAdd(Cow());
        },
        verify: (game, tester) async {
          await expectLater(
            find.byGame<TestGame>(),
            matchesGoldenFile('golden/elements/cow.png'),
          );
        },
      );
    });

    group('LinedTree', () {
      flameTester.testGameWidget(
        'renders a LinedTree',
        setUp: (game, tester) async {
          final linedTree = LinedTree();
          await game.ensureAdd(linedTree);
        },
        verify: (game, tester) async {
          await expectLater(
            find.byGame<TestGame>(),
            matchesGoldenFile('golden/elements/lined_tree.png'),
          );
        },
      );
    });

    group('LinedTreeShort', () {
      flameTester.testGameWidget(
        'renders a LinedTreeShort',
        setUp: (game, tester) async {
          final linedTree = LinedTreeShort();
          await game.ensureAdd(linedTree);
        },
        verify: (game, tester) async {
          await expectLater(
            find.byGame<TestGame>(),
            matchesGoldenFile('golden/elements/lined_tree_short.png'),
          );
        },
      );
    });

    group('TallTree', () {
      flameTester.testGameWidget(
        'renders a TallTree',
        setUp: (game, tester) async {
          final tallTree = TallTree();
          await game.ensureAdd(tallTree);
        },
        verify: (game, tester) async {
          await expectLater(
            find.byGame<TestGame>(),
            matchesGoldenFile('golden/elements/tall_tree.png'),
          );
        },
      );
    });

    group('ShortTree', () {
      flameTester.testGameWidget(
        'renders a ShortTree',
        setUp: (game, tester) async {
          final shortTree = ShortTree();
          await game.ensureAdd(shortTree);
        },
        verify: (game, tester) async {
          await expectLater(
            find.byGame<TestGame>(),
            matchesGoldenFile('golden/elements/short_tree.png'),
          );
        },
      );
    });

    group('Grass', () {
      flameTester.testGameWidget(
        'renders a Grass',
        setUp: (game, tester) async {
          final grass = Grass();
          await game.ensureAdd(grass);
        },
        verify: (game, tester) async {
          await expectLater(
            find.byGame<TestGame>(),
            matchesGoldenFile('golden/elements/grass.png'),
          );
        },
      );
    });
    group('FlowerSolo', () {
      flameTester.testGameWidget(
        'renders a FlowerSolo',
        setUp: (game, tester) async {
          final flowerSolo = FlowerSolo();
          await game.ensureAdd(flowerSolo);
        },
        verify: (game, tester) async {
          await expectLater(
            find.byGame<TestGame>(),
            matchesGoldenFile('golden/elements/flowersolo.png'),
          );
        },
      );
    });

    group('FlowerDuo', () {
      flameTester.testGameWidget(
        'renders a FlowerDuo',
        setUp: (game, tester) async {
          final flowerDuo = FlowerDuo();
          await game.ensureAdd(flowerDuo);
        },
        verify: (game, tester) async {
          await expectLater(
            find.byGame<TestGame>(),
            matchesGoldenFile('golden/elements/flowerduo.png'),
          );
        },
      );
    });

    group('FlowerGroup', () {
      flameTester.testGameWidget(
        'renders a FlowerGroup',
        setUp: (game, tester) async {
          final flowerGroup = FlowerGroup();
          await game.ensureAdd(flowerGroup);
        },
        verify: (game, tester) async {
          await expectLater(
            find.byGame<TestGame>(),
            matchesGoldenFile('golden/elements/flowergroup.png'),
          );
        },
      );
    });
  });
}
