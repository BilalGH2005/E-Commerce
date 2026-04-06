import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/constants/assets.gen.dart';
import '../../../core/utils/shortcuts.dart';

class MainParticle extends StatelessWidget {
  const MainParticle({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentGeometry.center,
      children: [
        SvgPicture.asset(
          Assets.icons.particle,
          width: 91,
          height: 91,
          colorFilter: ColorFilter.mode(
            colorScheme(context).primary,
            BlendMode.srcIn,
          ),
        ),
        SvgPicture.asset(Assets.icons.check),
      ],
    );
  }
}
