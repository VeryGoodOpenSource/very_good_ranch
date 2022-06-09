import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ranch_components/src/components/background/background_elements.dart';

import '../../helpers/helpers.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final flameTester = FlameTester(TestGame.new);

  group('Background elements', () {
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

    group('TreeTrio', () {
      flameTester.testGameWidget(
        'renders a TreeTrio',
        setUp: (game, tester) async {
          final treeTrio = TreeTrio();
          await game.ensureAdd(treeTrio);
        },
        verify: (game, tester) async {
          await expectLater(
            find.byGame<TestGame>(),
            matchesGoldenFile('golden/elements/treetrio.png'),
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
