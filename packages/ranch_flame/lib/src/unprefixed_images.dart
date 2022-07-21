import 'package:flame/cache.dart';
import 'package:flutter/widgets.dart';

/// {@template unprefixed_images}
/// A variant of Flame's [Images] that is guaranteed to not have prefix. Ever.
/// {@endtemplate}
class UnprefixedImages extends Images {
  /// {@macro unprefixed_images}
  UnprefixedImages() : super();

  @override
  String get prefix => '';

  @override
  @protected
  set prefix(String value) {
    super.prefix = '';
  }
}
