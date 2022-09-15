// ignore_for_file: cascade_invocations

import 'package:flame/extensions.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ranch_components/ranch_components.dart';
import 'package:very_good_ranch/game/behaviors/positional_priority_behavior.dart';
import 'package:very_good_ranch/game/entities/entities.dart';
import 'package:very_good_ranch/game/entities/unicorn/behaviors/behaviors.dart';
import 'package:very_good_ranch/game/game.dart';

import '../../../helpers/helpers.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late BlessingBloc blessingBloc;

  setUp(() {
    blessingBloc = MockBlessingBloc();
    when(() => blessingBloc.state).thenReturn(BlessingState.initial());
  });

  final flameTester = FlameTester<VeryGoodRanchGame>(
    () => VeryGoodRanchGame(blessingBloc: blessingBloc),
  );

  group('Unicorn', () {
    flameTester.test('has all behaviors', (game) async {
      final unicorn = Unicorn(
        position: Vector2.all(1),
        onMountGauge: (gauge) {},
        onUnmountGauge: (gauge) {},
      );
      await game.background.ensureAdd(unicorn);

      expect(unicorn.findBehavior<EvolvingBehavior>(), isNotNull);
      expect(unicorn.findBehavior<PropagatingCollisionBehavior>(), isNotNull);
      expect(unicorn.findBehavior<MovingBehavior>(), isNotNull);
      expect(unicorn.findBehavior<FoodCollidingBehavior>(), isNotNull);
      expect(unicorn.findBehavior<FullnessDecreasingBehavior>(), isNotNull);
      expect(unicorn.findBehavior<EnjoymentDecreasingBehavior>(), isNotNull);
      expect(unicorn.findBehavior<LeavingBehavior>(), isNotNull);
      expect(unicorn.findBehavior<PettingBehavior>(), isNotNull);
      expect(unicorn.findBehavior<PositionalPriorityBehavior>(), isNotNull);
    });

    flameTester.test(
      'loads correctly',
      (game) async {
        final unicorn = Unicorn(
          position: Vector2.all(1),
          onMountGauge: (gauge) {},
          onUnmountGauge: (gauge) {},
        );
        await game.ready();
        await game.background.ensureAdd(unicorn);

        expect(unicorn.state, UnicornState.idle);
      },
    );

    group('unicorn state', () {
      flameTester.test(
        'is by default idle',
        (game) async {
          final unicorn = Unicorn(
            position: Vector2.all(1),
            onMountGauge: (gauge) {},
            onUnmountGauge: (gauge) {},
          );
          await game.ready();
          await game.background.ensureAdd(unicorn);

          expect(unicorn.state, UnicornState.idle);
        },
      );
    });

    group('setUnicornState', () {
      flameTester.test(
        'When setting loop animation, sticks to it',
        (game) async {
          final unicorn = Unicorn(
            position: game.background.pastureField.topLeft.toVector2() +
                Vector2.all(1),
            onMountGauge: (gauge) {},
            onUnmountGauge: (gauge) {},
          );
          await game.ready();
          await game.background.ensureAdd(unicorn);

          unicorn.setUnicornState(UnicornState.walking);

          expect(unicorn.state, UnicornState.walking);

          game.update(UnicornSpriteComponent.walkAnimationDuration);

          expect(unicorn.state, UnicornState.walking);
        },
      );

      flameTester.test(
        'When setting finite animation, goes back to idle',
        (game) async {
          final unicorn = Unicorn(
            position: game.background.pastureField.topLeft.toVector2() +
                Vector2.all(1),
            onMountGauge: (gauge) {},
            onUnmountGauge: (gauge) {},
          );
          await game.ready();
          await game.background.ensureAdd(unicorn);

          unicorn.setUnicornState(UnicornState.eating);

          expect(unicorn.state, UnicornState.eating);

          game.update(UnicornSpriteComponent.eatAnimationDuration);

          expect(unicorn.state, UnicornState.idle);
        },
      );
    });

    group('unicorn evolution stage', () {
      flameTester.test(
        'evolves to next stage',
        (game) async {
          final unicorn = Unicorn(
            position: Vector2.all(1),
            onMountGauge: (gauge) {},
            onUnmountGauge: (gauge) {},
          );

          await game.background.ensureAdd(unicorn);

          expect(unicorn.evolutionStage, UnicornEvolutionStage.baby);
          unicorn.timesFed = EvolvingBehavior.timesThatMustBeFed;

          game.update(0);

          expect(unicorn.evolutionStage, UnicornEvolutionStage.child);
          expect(unicorn.size, ChildUnicornComponent().size);
        },
      );

      flameTester.test(
        'waits for finite animation to evolve',
        (game) async {
          final unicorn = Unicorn(
            position: Vector2.all(1),
            onMountGauge: (gauge) {},
            onUnmountGauge: (gauge) {},
          );

          await game.background.ensureAdd(unicorn);

          // start finite animation
          unicorn.setUnicornState(UnicornState.petted);

          expect(unicorn.evolutionStage, UnicornEvolutionStage.baby);
          unicorn.timesFed = EvolvingBehavior.timesThatMustBeFed;

          game.update(0);

          // still a baby
          expect(unicorn.evolutionStage, UnicornEvolutionStage.baby);

          game.update(UnicornSpriteComponent.pettedAnimationDuration);

          expect(unicorn.evolutionStage, UnicornEvolutionStage.child);
          expect(unicorn.size, ChildUnicornComponent().size);
        },
      );
    });

    test('reset', () {
      final unicorn = Unicorn(
        position: Vector2.all(1),
        onMountGauge: (gauge) {},
        onUnmountGauge: (gauge) {},
      );

      expect(unicorn.timesFed, 0);
      expect(unicorn.fullness.value, 1);
      expect(unicorn.enjoyment.value, 1);

      unicorn.timesFed = 2;
      unicorn.fullness.value = 0.5;
      unicorn.enjoyment.value = 0.5;

      unicorn.reset();

      expect(unicorn.timesFed, 0);
      expect(unicorn.fullness.value, 1);
      expect(unicorn.enjoyment.value, 1);
    });

    group('gauge ', () {
      group('add gauge', () {
        flameTester.test('add gauge on mount', (game) async {
          var hasAddedGauge = false;
          final unicorn = Unicorn(
            position: Vector2.all(1),
            onMountGauge: (gauge) {
              hasAddedGauge = true;
            },
            onUnmountGauge: (gauge) {},
          );

          await game.background.ensureAdd(unicorn);
          expect(hasAddedGauge, isTrue);
        });
      });

      flameTester.test('remove gauge on remove', (game) async {
        var hasRemovedGauge = false;
        final unicorn = Unicorn(
          position: Vector2.all(1),
          onMountGauge: (gauge) {},
          onUnmountGauge: (gauge) {
            hasRemovedGauge = true;
          },
        );

        await game.background.ensureAdd(unicorn);

        game.background.remove(unicorn);
        await game.ready();

        expect(hasRemovedGauge, isTrue);
      });
    });
  });

  group('UnicornPercentage', () {
    group('initial percentage', () {
      test('is set on creation', () {
        final percentage = UnicornPercentage(0.5);
        expect(percentage.value, 0.5);
      });

      test('should be between 0 and 1', () {
        expect(() => UnicornPercentage(1.1), throwsAssertionError);
        expect(() => UnicornPercentage(-0.1), throwsAssertionError);
      });
    });

    test('clamps percentage', () {
      final percentage = UnicornPercentage(0.5);
      expect(percentage.value, 0.5);
      percentage.value = -1;
      expect(percentage.value, 0.0);
      percentage.value = 2;
      expect(percentage.value, 1.0);
    });

    group('increase by', () {
      test('increases percentage', () {
        final percentage = UnicornPercentage(0.5);
        expect(percentage.value, 0.5);
        percentage.increaseBy(0.1);
        expect(percentage.value, 0.6);
      });
      test('clamps percentage', () {
        final percentage = UnicornPercentage(0.5);
        expect(percentage.value, 0.5);
        percentage.increaseBy(0.8);
        expect(percentage.value, 1.0);
      });
    });

    group('decrease by', () {
      test('decreases percentage', () {
        final percentage = UnicornPercentage(0.5);
        expect(percentage.value, 0.5);
        percentage.decreaseBy(0.1);
        expect(percentage.value, 0.4);
      });
      test('clamps percentage', () {
        final percentage = UnicornPercentage(0.5);
        expect(percentage.value, 0.5);
        percentage.decreaseBy(0.8);
        expect(percentage.value, 0.0);
      });
    });

    group('reset', () {
      test('resets percentage to initial', () {
        final percentage = UnicornPercentage(0.5);
        percentage.value = 1;
        percentage.reset();
        expect(percentage.value, 0.5);
      });
    });
  });

  group('componentForEvolutionStage', () {
    test('returns right component for each stage', () {
      final babyComponent = UnicornEvolutionStage.baby
          .componentForEvolutionStage(UnicornState.walking);
      expect(babyComponent, isA<BabyUnicornComponent>());
      expect(babyComponent.state, UnicornState.walking);

      final childComponent = UnicornEvolutionStage.child
          .componentForEvolutionStage(UnicornState.walking);
      expect(childComponent, isA<ChildUnicornComponent>());
      expect(childComponent.state, UnicornState.walking);

      final teenComponent = UnicornEvolutionStage.teen
          .componentForEvolutionStage(UnicornState.walking);
      expect(teenComponent, isA<TeenUnicornComponent>());
      expect(teenComponent.state, UnicornState.walking);

      final adultComponent = UnicornEvolutionStage.adult
          .componentForEvolutionStage(UnicornState.walking);
      expect(adultComponent, isA<AdultUnicornComponent>());
      expect(adultComponent.state, UnicornState.walking);
    });
  });
}
