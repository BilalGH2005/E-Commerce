import 'package:flutter/material.dart';

import '../localization/app_localizations.dart';

AppLocalizations localization(BuildContext context) {
  return AppLocalizations.of(context)!;
}

TextTheme textTheme(BuildContext context) {
  return Theme.of(context).textTheme;
}

ColorScheme colorScheme(BuildContext context) {
  return Theme.of(context).colorScheme;
}

class SliverSizedBox extends StatelessWidget {
  final double? height;
  final double? width;

  const SliverSizedBox({super.key, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(height: height, width: width),
    );
  }
}
