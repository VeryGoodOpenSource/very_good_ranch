import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';

/// {@template positional_priority_behavior}
/// A behavior that updates the parent's priority based on its position.
/// {@endtemplate}
class PositionalPriorityBehavior<Parent extends Entity>
    extends Behavior<Parent> {
  /// {@macro positional_priority_behavior}
  PositionalPriorityBehavior({
    this.anchor = Anchor.topLeft,
  });

  /// The anchor point used to determine the y position used for the parent's
  /// priority.
  final Anchor anchor;

  @override
  Future<void> onLoad() async {
    _onPositionUpdate();
  }

  @override
  void onMount() {
    super.onMount();
    parent.position.addListener(_onPositionUpdate);
  }

  @override
  void onRemove() {
    parent.position.removeListener(_onPositionUpdate);
    super.onRemove();
  }

  void _onPositionUpdate() {
    parent.priority = (parent.positionOfAnchor(anchor).y).toInt();
  }
}
