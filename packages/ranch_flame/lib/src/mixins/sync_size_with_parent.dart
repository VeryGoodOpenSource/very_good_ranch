import 'package:flame/components.dart';
import 'package:ranch_flame/src/mixins/has_parent.dart';

/// Mixin that syncs the size of the component with the size of the parent.
mixin SyncSizeWithParent on PositionComponent, HasParent<PositionComponent> {
  @override
  void onMount() {
    super.onMount();
    parent.size.addListener(_onParentResize);
  }

  @override
  void onRemove() {
    parent.size.removeListener(_onParentResize);
    super.onRemove();
  }

  void _onParentResize() {
    size = parent.size;
  }
}
