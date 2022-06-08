/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/adult_sprite.png
  AssetGenImage get adultSprite =>
      const AssetGenImage('assets/images/adult_sprite.png');

  /// File path: assets/images/baby_sprite.png
  AssetGenImage get babySprite =>
      const AssetGenImage('assets/images/baby_sprite.png');

  /// File path: assets/images/barn.png
  AssetGenImage get barn => const AssetGenImage('assets/images/barn.png');

  /// File path: assets/images/cake.png
  AssetGenImage get cake => const AssetGenImage('assets/images/cake.png');

  /// File path: assets/images/child_sprite.png
  AssetGenImage get childSprite =>
      const AssetGenImage('assets/images/child_sprite.png');

  /// File path: assets/images/donut.png
  AssetGenImage get donut => const AssetGenImage('assets/images/donut.png');

  /// File path: assets/images/flower_duo.png
  AssetGenImage get flowerDuo =>
      const AssetGenImage('assets/images/flower_duo.png');

  /// File path: assets/images/flower_group.png
  AssetGenImage get flowerGroup =>
      const AssetGenImage('assets/images/flower_group.png');

  /// File path: assets/images/flower_solo.png
  AssetGenImage get flowerSolo =>
      const AssetGenImage('assets/images/flower_solo.png');

  /// File path: assets/images/grass.png
  AssetGenImage get grass => const AssetGenImage('assets/images/grass.png');

  /// File path: assets/images/icecream.png
  AssetGenImage get icecream =>
      const AssetGenImage('assets/images/icecream.png');

  /// File path: assets/images/lollipop.png
  AssetGenImage get lollipop =>
      const AssetGenImage('assets/images/lollipop.png');

  /// File path: assets/images/pancakes.png
  AssetGenImage get pancakes =>
      const AssetGenImage('assets/images/pancakes.png');

  /// File path: assets/images/teen_sprite.png
  AssetGenImage get teenSprite =>
      const AssetGenImage('assets/images/teen_sprite.png');

  /// File path: assets/images/tree_lined.png
  AssetGenImage get treeLined =>
      const AssetGenImage('assets/images/tree_lined.png');

  /// File path: assets/images/tree_short.png
  AssetGenImage get treeShort =>
      const AssetGenImage('assets/images/tree_short.png');

  /// File path: assets/images/tree_tall.png
  AssetGenImage get treeTall =>
      const AssetGenImage('assets/images/tree_tall.png');

  /// File path: assets/images/tree_trio.png
  AssetGenImage get treeTrio =>
      const AssetGenImage('assets/images/tree_trio.png');
}

class Assets {
  Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale = 1.0,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package = 'ranch_components',
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  String get path => _assetName;


  // Todo(renancaraujo): use generated code once this lands: https://github.com/FlutterGen/flutter_gen/pull/251
  String get packagePath => 'packages/ranch_components/$_assetName';
}
