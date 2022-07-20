/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetsAnimationsGen {
  const $AssetsAnimationsGen();

  /// File path: assets/animations/adult_eat.png
  AssetGenImage get adultEat =>
      const AssetGenImage('assets/animations/adult_eat.png');

  /// File path: assets/animations/adult_idle.png
  AssetGenImage get adultIdle =>
      const AssetGenImage('assets/animations/adult_idle.png');

  /// File path: assets/animations/adult_petted.png
  AssetGenImage get adultPetted =>
      const AssetGenImage('assets/animations/adult_petted.png');

  /// File path: assets/animations/adult_walk_cycle.png
  AssetGenImage get adultWalkCycle =>
      const AssetGenImage('assets/animations/adult_walk_cycle.png');

  /// File path: assets/animations/baby_eat.png
  AssetGenImage get babyEat =>
      const AssetGenImage('assets/animations/baby_eat.png');

  /// File path: assets/animations/baby_idle.png
  AssetGenImage get babyIdle =>
      const AssetGenImage('assets/animations/baby_idle.png');

  /// File path: assets/animations/baby_petted.png
  AssetGenImage get babyPetted =>
      const AssetGenImage('assets/animations/baby_petted.png');

  /// File path: assets/animations/baby_walk_cycle.png
  AssetGenImage get babyWalkCycle =>
      const AssetGenImage('assets/animations/baby_walk_cycle.png');

  /// File path: assets/animations/child_eat.png
  AssetGenImage get childEat =>
      const AssetGenImage('assets/animations/child_eat.png');

  /// File path: assets/animations/child_idle.png
  AssetGenImage get childIdle =>
      const AssetGenImage('assets/animations/child_idle.png');

  /// File path: assets/animations/child_petted.png
  AssetGenImage get childPetted =>
      const AssetGenImage('assets/animations/child_petted.png');

  /// File path: assets/animations/child_walk_cycle.png
  AssetGenImage get childWalkCycle =>
      const AssetGenImage('assets/animations/child_walk_cycle.png');

  /// File path: assets/animations/teen_eat.png
  AssetGenImage get teenEat =>
      const AssetGenImage('assets/animations/teen_eat.png');

  /// File path: assets/animations/teen_idle.png
  AssetGenImage get teenIdle =>
      const AssetGenImage('assets/animations/teen_idle.png');

  /// File path: assets/animations/teen_petted.png
  AssetGenImage get teenPetted =>
      const AssetGenImage('assets/animations/teen_petted.png');

  /// File path: assets/animations/teen_walk_cycle.png
  AssetGenImage get teenWalkCycle =>
      const AssetGenImage('assets/animations/teen_walk_cycle.png');
}

class $AssetsBackgroundGen {
  const $AssetsBackgroundGen();

  /// File path: assets/background/barn.png
  AssetGenImage get barn => const AssetGenImage('assets/background/barn.png');

  /// File path: assets/background/flower_duo.png
  AssetGenImage get flowerDuo =>
      const AssetGenImage('assets/background/flower_duo.png');

  /// File path: assets/background/flower_group.png
  AssetGenImage get flowerGroup =>
      const AssetGenImage('assets/background/flower_group.png');

  /// File path: assets/background/flower_solo.png
  AssetGenImage get flowerSolo =>
      const AssetGenImage('assets/background/flower_solo.png');

  /// File path: assets/background/grass.png
  AssetGenImage get grass => const AssetGenImage('assets/background/grass.png');

  /// File path: assets/background/short_tree.png
  AssetGenImage get shortTree =>
      const AssetGenImage('assets/background/short_tree.png');

  /// File path: assets/background/tall_tree.png
  AssetGenImage get tallTree =>
      const AssetGenImage('assets/background/tall_tree.png');

  /// File path: assets/background/tree_trio.png
  AssetGenImage get treeTrio =>
      const AssetGenImage('assets/background/tree_trio.png');
}

class $AssetsFoodGen {
  const $AssetsFoodGen();

  /// File path: assets/food/cake.png
  AssetGenImage get cake => const AssetGenImage('assets/food/cake.png');

  /// File path: assets/food/donut.png
  AssetGenImage get donut => const AssetGenImage('assets/food/donut.png');

  /// File path: assets/food/icecream.png
  AssetGenImage get icecream => const AssetGenImage('assets/food/icecream.png');

  /// File path: assets/food/lollipop.png
  AssetGenImage get lollipop => const AssetGenImage('assets/food/lollipop.png');

  /// File path: assets/food/pancakes.png
  AssetGenImage get pancakes => const AssetGenImage('assets/food/pancakes.png');
}

class Assets {
  Assets._();

  static const $AssetsAnimationsGen animations = $AssetsAnimationsGen();
  static const $AssetsBackgroundGen background = $AssetsBackgroundGen();
  static const $AssetsFoodGen food = $AssetsFoodGen();
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
    double? scale,
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

  String get keyName => 'packages/ranch_components/$_assetName';
}
