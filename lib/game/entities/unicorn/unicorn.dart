import 'package:flame/components.dart';
import 'package:ranch_components/ranch_components.dart';
import 'package:very_good_ranch/game/entities/unicorn/behaviors/behaviors.dart';

class Unicorn extends PositionComponent {
  Unicorn({
    required Vector2 position,
  }) : super(
          position: position,
          size: Vector2.all(32),
          children: [
            UnicornComponent(
              size: Vector2.all(32),
            ),
            CollisionBehavior(),
            MovementBehavior(),
          ],
        ) {
    // Register a query cache for the unicorn component.
    children.register<UnicornComponent>();
    // Query for all unicorn components.
    _unicorns = children.query<UnicornComponent>();
  }

  late final List<UnicornComponent> _unicorns;

  UnicornState? get state => _unicorns.first.current;
  set state(UnicornState? state) => _unicorns.first.current = state;
}
