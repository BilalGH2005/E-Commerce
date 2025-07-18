import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;

class PlatformUtil {
  static bool get isMobile {
    if (kIsWeb) {
      return false;
    } else {
      return Platform.isAndroid || Platform.isIOS;
    }
  }

  static bool get isDesktop {
    if (kIsWeb) {
      return false;
    } else {
      return Platform.isWindows ||
          Platform.isMacOS ||
          Platform.isLinux ||
          Platform.isFuchsia;
    }
  }
}
