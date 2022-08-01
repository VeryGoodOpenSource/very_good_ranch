import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';

/// {@template unprefixed_images}
/// A variant of [AudioCache] that is guaranteed to not have prefix. Ever.
/// {@endtemplate}
class UnprefixedAudioCache extends AudioCache {
  @override
  String get prefix => '';

  @override
  @protected
  set prefix(String value) {
    super.prefix = '';
  }
}
