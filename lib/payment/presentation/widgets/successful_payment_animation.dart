import 'package:e_commerce/core/utils/duration_extension.dart';
import 'package:e_commerce/payment/presentation/widgets/main_particle.dart';
import 'package:e_commerce/payment/presentation/widgets/little_particle.dart';
import 'package:flutter/material.dart';

import 'dart:math';

import '../../../core/utils/shortcuts.dart';

class Particle {
  final Offset direction;
  final double speed;

  Particle(this.direction, this.speed);

  factory Particle.random() {
    final angle = Random().nextDouble() * 2 * pi;
    return Particle(
      Offset(cos(angle), sin(angle)),
      50 + Random().nextDouble() * 80,
    );
  }
}

class ParticleWidget extends StatelessWidget {
  final Particle particle;
  final Animation<double> animation;

  const ParticleWidget({
    super.key,
    required this.particle,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (_, _) {
        final t = animation.value;

        return Opacity(
          opacity: 1 - t,
          child: Transform.translate(
            offset: particle.direction * particle.speed * t,
            child: const LittleParticle(),
          ),
        );
      },
    );
  }
}

class SuccessfulPaymentAnimation extends StatefulWidget {
  const SuccessfulPaymentAnimation({super.key});

  @override
  State<SuccessfulPaymentAnimation> createState() =>
      _SuccessfulPaymentAnimationState();
}

class _SuccessfulPaymentAnimationState extends State<SuccessfulPaymentAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;
  late final Animation<double> _particleAnim;
  late final Animation<Offset> _textSlide;
  late final Animation<double> _textFade;
  final List<Particle> _particles = [];
  bool _spawned = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: 1600.ms)
      ..forward();

    _scale = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.4, curve: Curves.easeOutBack),
    );

    _particleAnim = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.35, 1.0, curve: Curves.easeOut),
    );

    _textSlide = Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.6, 1.0, curve: Curves.easeOut),
          ),
        );

    _textFade = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.6, 1.0, curve: Curves.easeIn),
    );

    _controller.addListener(_spawnParticles);
  }

  void _spawnParticles() {
    if (_controller.value > 0.35 && !_spawned) {
      _spawned = true;
      _particles.addAll(List.generate(30, (_) => Particle.random()));
      setState(() {});
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        ..._particles.map(
          (p) => ParticleWidget(particle: p, animation: _particleAnim),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ScaleTransition(scale: _scale, child: const MainParticle()),
            const SizedBox(height: 12),
            SlideTransition(
              position: _textSlide,
              child: FadeTransition(
                opacity: _textFade,
                child: Text(
                  localization(context).paymentDoneSuccessfully,
                  style: textTheme(
                    context,
                  ).displaySmall!.copyWith(fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
