import 'package:flutter_test/flutter_test.dart';
import 'package:ranch_sounds/ranch_sounds.dart';

void main() {
  group('UnprefixedAudioCache', () {
    test('has no prefix', () {
      final audiocache = UnprefixedAudioCache();
      expect(audiocache.prefix, '');

      // ignore: invalid_use_of_protected_member
      audiocache.prefix = 'haha';
      expect(audiocache.prefix, '');
    });
  });
}
