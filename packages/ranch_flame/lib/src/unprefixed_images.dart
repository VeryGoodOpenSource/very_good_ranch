import 'package:flame/cache.dart';
import 'package:flutter/widgets.dart';

/// {@template unprefixed_images}
/// A variant of flame's [Images] that is guaranteed to not have prefix. Ever.
/// {@endtemplate}
class UnprefixedImages extends Images {
  // Because the superclass uses a private field to load the assets,
  // we have to pass a super. Overriding only is not future proof.
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
