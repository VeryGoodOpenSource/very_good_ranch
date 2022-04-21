import 'package:flame/components.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ranch_flame/ranch_flame.dart';

class ParentComponent extends Component {}

class DifferentComponent extends Component {}

class TestComponent extends Component with HasParent<ParentComponent> {}

void main() {
  group('HasParent', () {
    test('successfully sets the parent link', () {
      final parent = ParentComponent();
      final component = TestComponent();

      parent.add(component);

      expect(component.onMount, returnsNormally);
    });

    test('throws assertion error when the wrong parent is used', () {
      final parent = DifferentComponent();
      final component = TestComponent();

      parent.add(component);

      expect(component.onMount, throwsAssertionError);
    });
  });
}
