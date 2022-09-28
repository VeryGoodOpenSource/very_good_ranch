import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ranch_ui/ranch_ui.dart';

void main() {
  group('HoverMaterialStateColor', () {
    test('resolve to default', () {
      const materialProperty = HoverMaterialStateColor(
        0xFF00FF00,
        hover: Color(0xFFFF00FF),
      );

      expect(const Color(0xFF00FF00), materialProperty.resolve({}));
    });
    test('resolve to hover when hover', () {
      const materialProperty = HoverMaterialStateColor(
        0xFF00FF00,
        hover: Color(0xFFFF00FF),
      );

      expect(
        const Color(0xFFFF00FF),
        materialProperty.resolve({MaterialState.hovered}),
      );
    });
  });
}
