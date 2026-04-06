import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/constants/assets.gen.dart';
import '../../../core/utils/shortcuts.dart';

class EmptyCartWidget extends StatelessWidget {
  const EmptyCartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(Assets.icons.emptyCart, width: 180, height: 180),
          SizedBox(height: 24),
          Text(
            localization(context).cartIsEmpty,
            style: textTheme(context).displaySmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
