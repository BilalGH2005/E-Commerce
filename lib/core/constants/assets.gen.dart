// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/app_logo.svg
  String get appLogo => 'assets/icons/app_logo.svg';

  /// File path: assets/icons/apple.svg
  String get apple => 'assets/icons/apple.svg';

  /// File path: assets/icons/cart.svg
  String get cart => 'assets/icons/cart.svg';

  /// File path: assets/icons/check.svg
  String get check => 'assets/icons/check.svg';

  /// File path: assets/icons/chevron-left.svg
  String get chevronLeft => 'assets/icons/chevron-left.svg';

  /// File path: assets/icons/coupon.svg
  String get coupon => 'assets/icons/coupon.svg';

  /// File path: assets/icons/email.svg
  String get email => 'assets/icons/email.svg';

  /// File path: assets/icons/empty_cart.svg
  String get emptyCart => 'assets/icons/empty_cart.svg';

  /// File path: assets/icons/eye-off.svg
  String get eyeOff => 'assets/icons/eye-off.svg';

  /// File path: assets/icons/eye.svg
  String get eye => 'assets/icons/eye.svg';

  /// File path: assets/icons/facebook.svg
  String get facebook => 'assets/icons/facebook.svg';

  /// File path: assets/icons/filters.svg
  String get filters => 'assets/icons/filters.svg';

  /// File path: assets/icons/globe.svg
  String get globe => 'assets/icons/globe.svg';

  /// File path: assets/icons/google.svg
  String get google => 'assets/icons/google.svg';

  /// File path: assets/icons/home.svg
  String get home => 'assets/icons/home.svg';

  /// File path: assets/icons/info.svg
  String get info => 'assets/icons/info.svg';

  /// File path: assets/icons/lock.svg
  String get lock => 'assets/icons/lock.svg';

  /// File path: assets/icons/particle.svg
  String get particle => 'assets/icons/particle.svg';

  /// File path: assets/icons/pencil.svg
  String get pencil => 'assets/icons/pencil.svg';

  /// File path: assets/icons/person.svg
  String get person => 'assets/icons/person.svg';

  /// File path: assets/icons/refresh.svg
  String get refresh => 'assets/icons/refresh.svg';

  /// File path: assets/icons/search.svg
  String get search => 'assets/icons/search.svg';

  /// File path: assets/icons/settings.svg
  String get settings => 'assets/icons/settings.svg';

  /// File path: assets/icons/sign_out.svg
  String get signOut => 'assets/icons/sign_out.svg';

  /// File path: assets/icons/theme.svg
  String get theme => 'assets/icons/theme.svg';

  /// File path: assets/icons/trash.svg
  String get trash => 'assets/icons/trash.svg';

  /// List of all assets
  List<String> get values => [
    appLogo,
    apple,
    cart,
    check,
    chevronLeft,
    coupon,
    email,
    emptyCart,
    eyeOff,
    eye,
    facebook,
    filters,
    globe,
    google,
    home,
    info,
    lock,
    particle,
    pencil,
    person,
    refresh,
    search,
    settings,
    signOut,
    theme,
    trash,
  ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/app_logo.png
  AssetGenImage get appLogo =>
      const AssetGenImage('assets/images/app_logo.png');

  /// File path: assets/images/app_logo_dark.png
  AssetGenImage get appLogoDark =>
      const AssetGenImage('assets/images/app_logo_dark.png');

  /// File path: assets/images/getting_started.jpg
  AssetGenImage get gettingStarted =>
      const AssetGenImage('assets/images/getting_started.jpg');

  /// File path: assets/images/onboarding1.svg
  String get onboarding1 => 'assets/images/onboarding1.svg';

  /// File path: assets/images/onboarding2.svg
  String get onboarding2 => 'assets/images/onboarding2.svg';

  /// File path: assets/images/onboarding3.svg
  String get onboarding3 => 'assets/images/onboarding3.svg';

  /// List of all assets
  List<dynamic> get values => [
    appLogo,
    appLogoDark,
    gettingStarted,
    onboarding1,
    onboarding2,
    onboarding3,
  ];
}

class Assets {
  const Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const String dotenv = 'dotenv';

  /// List of all assets
  static List<String> get values => [dotenv];
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
