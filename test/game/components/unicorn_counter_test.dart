// ignore_for_file: cascade_invocations

import 'package:flame/extensions.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:ranch_flame/ranch_flame.dart';
import 'package:very_good_ranch/game/bloc/game/game_bloc.dart';
import 'package:very_good_ranch/game/components/unicorn_counter.dart';
import 'package:very_good_ranch/game/entities/entities.dart';
import 'package:very_good_ranch/game/entities/unicorn/behaviors/behaviors.dart';
import 'package:very_good_ranch/game/very_good_ranch_game.dart';
import 'package:very_good_ranch/gen/assets.gen.dart';
import 'package:very_good_ranch/l10n/l10n.dart';

import '../../helpers/helpers.dart';

class MockUnprefixedImages extends Mock implements UnprefixedImages {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late GameBloc gameBloc;
  late AppLocalizations l10n;

  setUp(() {
    gameBloc = MockGameBloc();
    when(() => gameBloc.state).thenReturn(const GameState());

    l10n = MockAppLocalizations();
    when(() => l10n.score).thenReturn('score');
  });

  final flameTester = FlameTester<VeryGoodRanchGame>(
    () => VeryGoodRanchGame(
      gameBloc: gameBloc,
      inventoryBloc: MockInventoryBloc(),
      l10n: l10n,
    ),
  );

  group('UnicornCounter', () {
    group('preloadAssets', () {
      testWidgets('preloads assets', (tester) async {
        final images = MockUnprefixedImages();

        when(
          () => images.loadAll(any()),
        ).thenAnswer((Invocation invocation) => Future.value(<Image>[]));

        await UnicornCounter.preloadAssets(images);

        verify(
          () => images.loadAll([
            Assets.images.babyHead.path,
            Assets.images.childHead.path,
            Assets.images.teenHead.path,
            Assets.images.adultHead.path,
          ]),
        ).called(1);
      });
    });

    flameTester.testGameWidget(
      'counts each evolution stage of a unicorn',
      setUp: (game, tester) async {
        await game.add(UnicornCounter(position: Vector2(game.size.x, 0)));
        await game.background.addAll(
          UnicornEvolutionStage.values.map(
            (e) => Unicorn.test(
              unicornComponent: e.componentForEvolutionStage,
              position: Vector2.zero(),
              behaviors: [EvolutionBehavior()],
            ),
          ),
        );

        await game.ready();
      },
      verify: (game, tester) async {
        final counter = game.firstChild<UnicornCounter>()!;

        expect(counter.unicorns.length, equals(4));
        expect(
          counter.children.length,
          equals(UnicornEvolutionStage.values.length),
        );
      },
    );
  });
}
