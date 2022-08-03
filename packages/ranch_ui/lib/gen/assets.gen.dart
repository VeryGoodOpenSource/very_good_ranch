/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

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

  $AssetsImagesHeadsGen get heads => const $AssetsImagesHeadsGen();
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

class $AssetsImagesHeadsGen {
  const $AssetsImagesHeadsGen();

  /// File path: assets/images/heads/adult_head.png
  AssetGenImage get adultHead =>
      const AssetGenImage('assets/images/heads/adult_head.png');

  /// File path: assets/images/heads/baby_head.png
  AssetGenImage get babyHead =>
      const AssetGenImage('assets/images/heads/baby_head.png');

  /// File path: assets/images/heads/child_head.png
  AssetGenImage get childHead =>
      const AssetGenImage('assets/images/heads/child_head.png');

  /// File path: assets/images/heads/teen_head.png
  AssetGenImage get teenHead =>
      const AssetGenImage('assets/images/heads/teen_head.png');
}

class Assets {
  Assets._();

  static const $AssetsFontsGen fonts = $AssetsFontsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage extends AssetImage {
  const AssetGenImage(String assetName) : super(assetName, package: 'ranch_ui');

  Image image({
    Key? key,
    ImageFrameBuilder? frameBuilder,
    ImageLoadingBuilder? loadingBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? width,
    double? height,
    Color? color,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    FilterQuality filterQuality = FilterQuality.low,
  }) {
    return Image(
      key: key,
      image: this,
      frameBuilder: frameBuilder,
      loadingBuilder: loadingBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      width: width,
      height: height,
      color: color,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      filterQuality: filterQuality,
    );
  }

  String get path => assetName;
}
