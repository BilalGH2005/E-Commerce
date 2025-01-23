import 'package:flutter_svg/flutter_svg.dart';

class SvgUtil {
  static void preLoadSvgImages(List<String> images) async {
    for (final asset in images) {
      await svg.cache.putIfAbsent(SvgAssetLoader(asset).cacheKey(null),
          () => SvgAssetLoader(asset).loadBytes(null));
    }
  }
}
