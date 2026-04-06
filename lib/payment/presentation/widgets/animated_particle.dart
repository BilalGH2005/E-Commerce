import 'package:e_commerce/core/utils/duration_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/constants/assets.gen.dart';
import '../../../core/utils/shortcuts.dart';

class AnimatedParticle extends StatefulWidget {
  const AnimatedParticle({super.key});

  @override
  State<AnimatedParticle> createState() => _AnimatedParticleState();
}

class _AnimatedParticleState extends State<AnimatedParticle>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: 15.s)
      ..repeat(reverse: true);

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(0, -2),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: SvgPicture.asset(
        Assets.icons.particle,
        colorFilter: ColorFilter.mode(
          colorScheme(context).primary.withAlpha((0.4 * 255).round()),
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
