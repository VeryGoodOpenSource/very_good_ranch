/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetsFontsGen {
  const $AssetsFontsGen();

  $AssetsFontsAnybodyGen get anybody => const $AssetsFontsAnybodyGen();
  $AssetsFontsMouseMemoirsGen get mouseMemoirs =>
      const $AssetsFontsMouseMemoirsGen();
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/board.png
  AssetGenImage get board => const AssetGenImage('assets/images/board.png');
}

class $AssetsFontsAnybodyGen {
  const $AssetsFontsAnybodyGen();

  /// File path: assets/fonts/anybody/Anybody-Black.ttf
  String get anybodyBlack => 'assets/fonts/anybody/Anybody-Black.ttf';

  /// File path: assets/fonts/anybody/Anybody-Bold.ttf
  String get anybodyBold => 'assets/fonts/anybody/Anybody-Bold.ttf';

  /// File path: assets/fonts/anybody/Anybody-Medium.ttf
  String get anybodyMedium => 'assets/fonts/anybody/Anybody-Medium.ttf';

  /// File path: assets/fonts/anybody/Anybody-Regular.ttf
  String get anybodyRegular => 'assets/fonts/anybody/Anybody-Regular.ttf';

  /// File path: assets/fonts/anybody/Anybody-SemiBold.ttf
  String get anybodySemiBold => 'assets/fonts/anybody/Anybody-SemiBold.ttf';

  /// File path: assets/fonts/anybody/OFL.txt
  String get ofl => 'assets/fonts/anybody/OFL.txt';
}

class $AssetsFontsMouseMemoirsGen {
  const $AssetsFontsMouseMemoirsGen();

  /// File path: assets/fonts/mouse_memoirs/MouseMemoirs-Regular.ttf
  String get mouseMemoirsRegular =>
      'assets/fonts/mouse_memoirs/MouseMemoirs-Regular.ttf';

  /// File path: assets/fonts/mouse_memoirs/OFL.txt
  String get ofl => 'assets/fonts/mouse_memoirs/OFL.txt';
}

class Assets {
  Assets._();

  static const $AssetsFontsGen fonts = $AssetsFontsGen();
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
    String? package = 'ranch_ui',
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

  String get keyName => 'packages/ranch_ui/$_assetName';
}
