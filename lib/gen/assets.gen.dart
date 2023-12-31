/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/alert_image.png
  AssetGenImage get alertImage =>
      const AssetGenImage('assets/images/alert_image.png');

  /// File path: assets/images/app_logo.png
  AssetGenImage get appLogo =>
      const AssetGenImage('assets/images/app_logo.png');

  /// File path: assets/images/apple_logo.png
  AssetGenImage get appleLogo =>
      const AssetGenImage('assets/images/apple_logo.png');

  /// File path: assets/images/back_button.svg
  String get backButton => 'assets/images/back_button.svg';

  /// File path: assets/images/calendar_icon.png
  AssetGenImage get calendarIcon =>
      const AssetGenImage('assets/images/calendar_icon.png');

  /// File path: assets/images/close_icon.svg
  String get closeIcon => 'assets/images/close_icon.svg';

  /// File path: assets/images/google_logo.png
  AssetGenImage get googleLogo =>
      const AssetGenImage('assets/images/google_logo.png');

  /// File path: assets/images/grade_level_1.png
  AssetGenImage get gradeLevel1 =>
      const AssetGenImage('assets/images/grade_level_1.png');

  /// File path: assets/images/grade_level_2.png
  AssetGenImage get gradeLevel2 =>
      const AssetGenImage('assets/images/grade_level_2.png');

  /// File path: assets/images/grade_level_3.png
  AssetGenImage get gradeLevel3 =>
      const AssetGenImage('assets/images/grade_level_3.png');

  /// File path: assets/images/grade_level_4.png
  AssetGenImage get gradeLevel4 =>
      const AssetGenImage('assets/images/grade_level_4.png');

  /// File path: assets/images/grade_level_5.png
  AssetGenImage get gradeLevel5 =>
      const AssetGenImage('assets/images/grade_level_5.png');

  /// File path: assets/images/home_default_image.png
  AssetGenImage get homeDefaultImage =>
      const AssetGenImage('assets/images/home_default_image.png');

  /// File path: assets/images/home_text_logo.png
  AssetGenImage get homeTextLogo =>
      const AssetGenImage('assets/images/home_text_logo.png');

  /// File path: assets/images/kakao_logo.png
  AssetGenImage get kakaoLogo =>
      const AssetGenImage('assets/images/kakao_logo.png');

  /// File path: assets/images/login_image.png
  AssetGenImage get loginImage =>
      const AssetGenImage('assets/images/login_image.png');

  /// File path: assets/images/login_logo.png
  AssetGenImage get loginLogo =>
      const AssetGenImage('assets/images/login_logo.png');

  /// File path: assets/images/mypage_icon.svg
  String get mypageIcon => 'assets/images/mypage_icon.svg';

  /// File path: assets/images/naver_logo.png
  AssetGenImage get naverLogo =>
      const AssetGenImage('assets/images/naver_logo.png');

  /// File path: assets/images/right_arrow.svg
  String get rightArrow => 'assets/images/right_arrow.svg';

  /// File path: assets/images/splash_logo.png
  AssetGenImage get splashLogo =>
      const AssetGenImage('assets/images/splash_logo.png');

  /// File path: assets/images/sweat_emoji.png
  AssetGenImage get sweatEmoji =>
      const AssetGenImage('assets/images/sweat_emoji.png');

  /// List of all assets
  List<dynamic> get values => [
        alertImage,
        appLogo,
        appleLogo,
        backButton,
        calendarIcon,
        closeIcon,
        googleLogo,
        gradeLevel1,
        gradeLevel2,
        gradeLevel3,
        gradeLevel4,
        gradeLevel5,
        homeDefaultImage,
        homeTextLogo,
        kakaoLogo,
        loginImage,
        loginLogo,
        mypageIcon,
        naverLogo,
        rightArrow,
        splashLogo,
        sweatEmoji
      ];
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
    String? package,
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

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
