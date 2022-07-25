import 'dart:typed_data';

import 'package:flame/flame.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ranch_flame/ranch_flame.dart';

class MockAssetBundle extends Mock implements AssetBundle {}

void main() {
  group('UnprefixedImages', () {
    test('should be there no prefix', () {
      final images = UnprefixedImages();
      expect(images.prefix, '');
    });

    test('should load with no prefix', () async {
      // Valid 10x10 empty bitmap
      const contentSize = 400; // width * height * color channels (4);
      const headerSize = 122;
      const fileLength = headerSize + contentSize;
      final bd = Uint8List(fileLength).buffer.asByteData()
        ..setUint8(0x0, 0x42)
        ..setUint8(0x1, 0x4d)
        ..setInt32(0x2, fileLength, Endian.little)
        ..setInt32(0xa, headerSize, Endian.little)
        ..setUint32(0xe, 108, Endian.little)
        ..setUint32(0x12, 10, Endian.little) // width
        ..setUint32(0x16, -10, Endian.little) // height
        ..setUint16(0x1a, 1, Endian.little)
        ..setUint32(0x1c, 32, Endian.little) // pixel size
        ..setUint32(0x1e, 3, Endian.little) //BI_BITFIELDS
        ..setUint32(0x22, contentSize, Endian.little)
        ..setUint32(0x36, 0x000000ff, Endian.little)
        ..setUint32(0x3a, 0x0000ff00, Endian.little)
        ..setUint32(0x3e, 0x00ff0000, Endian.little)
        ..setUint32(0x42, 0xff000000, Endian.little);

      Flame.bundle = MockAssetBundle();
      when(() => Flame.bundle.load(any())).thenAnswer(
        (_) => Future.value(bd),
      );

      final images = UnprefixedImages();
      await images.load('something.png');
      verify(() => Flame.bundle.load('something.png')).called(1);
    });
  });
}
