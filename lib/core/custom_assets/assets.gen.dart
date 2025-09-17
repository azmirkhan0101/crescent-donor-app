// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart' as _svg;
import 'package:vector_graphics/vector_graphics.dart' as _vg;

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/Eye.svg
  SvgGenImage get eye => const SvgGenImage('assets/icons/Eye.svg');

  /// File path: assets/icons/Lock.svg
  SvgGenImage get lock => const SvgGenImage('assets/icons/Lock.svg');

  /// File path: assets/icons/arrow-left-circle-button.svg
  SvgGenImage get arrowLeftCircleButton =>
      const SvgGenImage('assets/icons/arrow-left-circle-button.svg');

  /// File path: assets/icons/arrow-right-circle-button.svg
  SvgGenImage get arrowRightCircleButton =>
      const SvgGenImage('assets/icons/arrow-right-circle-button.svg');

  /// File path: assets/icons/circle-i-button.svg
  SvgGenImage get circleIButton =>
      const SvgGenImage('assets/icons/circle-i-button.svg');

  /// File path: assets/icons/dot-grey.svg
  SvgGenImage get dotGrey => const SvgGenImage('assets/icons/dot-grey.svg');

  /// File path: assets/icons/mail.svg
  SvgGenImage get mail => const SvgGenImage('assets/icons/mail.svg');

  /// File path: assets/icons/moon-star.svg
  SvgGenImage get moonStar => const SvgGenImage('assets/icons/moon-star.svg');

  /// File path: assets/icons/small-star.svg
  SvgGenImage get smallStar => const SvgGenImage('assets/icons/small-star.svg');

  /// List of all assets
  List<SvgGenImage> get values => [
    eye,
    lock,
    arrowLeftCircleButton,
    arrowRightCircleButton,
    circleIButton,
    dotGrey,
    mail,
    moonStar,
    smallStar,
  ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/app-logo-name.svg
  SvgGenImage get appLogoName =>
      const SvgGenImage('assets/images/app-logo-name.svg');

  /// File path: assets/images/card-info.svg
  SvgGenImage get cardInfo => const SvgGenImage('assets/images/card-info.svg');

  /// File path: assets/images/how-to-work.png
  AssetGenImage get howToWork =>
      const AssetGenImage('assets/images/how-to-work.png');

  /// File path: assets/images/onboarding-saving-coins.svg
  SvgGenImage get onboardingSavingCoins =>
      const SvgGenImage('assets/images/onboarding-saving-coins.svg');

  /// File path: assets/images/upload-profile-picture.svg
  SvgGenImage get uploadProfilePicture =>
      const SvgGenImage('assets/images/upload-profile-picture.svg');

  /// List of all assets
  List<dynamic> get values => [
    appLogoName,
    cardInfo,
    howToWork,
    onboardingSavingCoins,
    uploadProfilePicture,
  ];
}

class Assets {
  const Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
    this.animation,
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;
  final AssetGenImageAnimation? animation;

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
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
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

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class AssetGenImageAnimation {
  const AssetGenImageAnimation({
    required this.isAnimation,
    required this.duration,
    required this.frames,
  });

  final bool isAnimation;
  final Duration duration;
  final int frames;
}

class SvgGenImage {
  const SvgGenImage(this._assetName, {this.size, this.flavors = const {}})
    : _isVecFormat = false;

  const SvgGenImage.vec(this._assetName, {this.size, this.flavors = const {}})
    : _isVecFormat = true;

  final String _assetName;
  final Size? size;
  final Set<String> flavors;
  final bool _isVecFormat;

  _svg.SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    _svg.SvgTheme? theme,
    _svg.ColorMapper? colorMapper,
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    final _svg.BytesLoader loader;
    if (_isVecFormat) {
      loader = _vg.AssetBytesLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
      );
    } else {
      loader = _svg.SvgAssetLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
        theme: theme,
        colorMapper: colorMapper,
      );
    }
    return _svg.SvgPicture(
      loader,
      key: key,
      matchTextDirection: matchTextDirection,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      colorFilter:
          colorFilter ??
          (color == null ? null : ColorFilter.mode(color, colorBlendMode)),
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
