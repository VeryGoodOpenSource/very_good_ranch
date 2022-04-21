// ignore_for_file: cascade_invocations

import 'package:flame/components.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ranch_components/ranch_components.dart';
import 'package:very_good_ranch/game/entities/entities.dart';

import '../../../helpers/helpers.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final flameTester = FlameTester<TestGame>(TestGame.new);

  group('Unicorn', () {
    flameTester.test(
      'loads correctly',
      (game) async {
        final unicorn = Unicorn(position: Vector2.zero());
        await game.ready();
        await game.ensureAdd(unicorn);

        expect(game.contains(unicorn), isTrue);
        expect(unicorn.state, UnicornState.idle);
      },
    );

    group('unicorn state', () {
      flameTester.test(
        'is by default idle',
        (game) async {
          final unicorn = Unicorn(position: Vector2.zero());
          await game.ready();
          await game.ensureAdd(unicorn);

          expect(unicorn.state, UnicornState.idle);
        },
      );

      flameTester.test(
        'can be set',
        (game) async {
          final unicorn = Unicorn(position: Vector2.zero());
          await game.ready();
          await game.ensureAdd(unicorn);

          unicorn.state = UnicornState.roaming;

          expect(unicorn.state, UnicornState.roaming);
        },
      );
    });
  });
}