import 'package:flame/components.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ranch_components/ranch_components.dart';

class _MockChildUnicorn extends PositionComponent with HasPaint {}

class _MockTeenUnicorn extends PositionComponent with HasPaint {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Evolution', () {
    test('can be instantiated', () {
      expect(
        Evolution(
          from: ChildUnicornComponent(),
          to: TeenUnicornComponent(),
        ),
        isNotNull,
      );
    });

    test("cannot be applied to components that aren't HasPaint", () {
      expect(
        () => Evolution(
          from: ChildUnicornComponent(),
          to: PositionComponent(),
        ),
        throwsAssertionError,
      );
    });

    testWithFlameGame('from must have a valid parent', (game) async {
      expect(
        () => game.ensureAdd(
          Evolution(
            from: ChildUnicornComponent(),
            to: TeenUnicornComponent(),
          ),
        ),
        throwsAssertionError,
      );
    });

    testWithFlameGame(
      'removes the "from" and add the "to" the parent',
      (game) async {
        final parent = PositionComponent(
          children: [
            _MockChildUnicorn(),
          ],
        );

        await game.ensureAdd(parent);

        await parent.ensureAdd(
          Evolution(
            from: parent.firstChild()!,
            to: _MockTeenUnicorn(),
          ),
        );

        game.updateTree(5);
        await game.ready();

        expect(
          game.descendants().whereType<_MockChildUnicorn>(),
          isEmpty,
        );
        expect(
          game.descendants().whereType<_MockTeenUnicorn>(),
          isNotEmpty,
        );
      },
    );

    testWithFlameGame(
      'adds a confetti upon completion',
      (game) async {
        final parent = PositionComponent(
          children: [
            _MockChildUnicorn(),
          ],
        );

        await game.ensureAdd(parent);

        await parent.ensureAdd(
          Evolution(
            from: parent.firstChild()!,
            to: _MockTeenUnicorn(),
          ),
        );

        game.updateTree(5);
        await game.ready();

        expect(
          game.descendants().whereType<ConfettiComponent>(),
          isNotEmpty,
        );
      },
    );

    testWithFlameGame(
      'is removed upon completion',
      (game) async {
        final parent = PositionComponent(
          children: [
            _MockChildUnicorn(),
          ],
        );

        await game.ensureAdd(parent);

        await parent.ensureAdd(
          Evolution(
            from: parent.firstChild()!,
            to: _MockTeenUnicorn(),
          ),
        );

        game.updateTree(5);
        await game.ready();

        expect(
          game.descendants().whereType<Evolution>(),
          isEmpty,
        );
      },
    );
  });
}
