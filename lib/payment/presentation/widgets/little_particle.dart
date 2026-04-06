import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/constants/assets.gen.dart';
import '../../../core/utils/shortcuts.dart';

class LittleParticle extends StatelessWidget {
  const LittleParticle({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      Assets.icons.particle,
      colorFilter: ColorFilter.mode(
        colorScheme(context).primary.withAlpha((0.4 * 255).round()),
        BlendMode.srcIn,
      ),
    );
  }
}
