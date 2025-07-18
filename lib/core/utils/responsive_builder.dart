import 'package:e_commerce/core/constants/app_breakpoints.dart';
import 'package:flutter/material.dart';

enum DeviceType { mobile, tablet, desktop }

DeviceType getDeviceType(double width) {
  if (width >= AppBreakpoints.kDesktopWidth) return DeviceType.desktop;
  if (width >= AppBreakpoints.kTabletWidth) return DeviceType.tablet;
  return DeviceType.mobile;
}

class ResponsiveBuilder extends StatelessWidget {
  final WidgetBuilder mobile;
  final WidgetBuilder? tablet;
  final WidgetBuilder? desktop;
  final WidgetBuilder? ultraWide;

  const ResponsiveBuilder({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
    this.ultraWide,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final deviceType = getDeviceType(width);

    switch (deviceType) {
      case DeviceType.desktop:
        if (desktop != null) return desktop!(context);
        continue tablet;
      tablet:
      case DeviceType.tablet:
        if (tablet != null) return tablet!(context);
        continue mobile;
      mobile:
      case DeviceType.mobile:
        return mobile(context);
    }
  }
}
