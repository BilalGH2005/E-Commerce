import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

CustomTransitionPage<T> slideFadePage<T>({
  required Widget child,
  required String key,
  Duration duration = const Duration(milliseconds: 250),
}) {
  return CustomTransitionPage<T>(
    transitionDuration: duration,
    key: ValueKey(key),
    child: child,
    transitionsBuilder: (context, animation, _, child) {
      final offsetAnimation = Tween<Offset>(
        begin: const Offset(1, 0),
        end: Offset.zero,
      ).animate(animation);
      return SlideTransition(
        position: offsetAnimation,
        child: FadeTransition(opacity: animation, child: child),
      );
    },
  );
}

CustomTransitionPage<T> scaleFadePage<T>({
  required Widget child,
  required String key,
  Duration duration = const Duration(milliseconds: 250),
}) {
  return CustomTransitionPage<T>(
    transitionDuration: duration,
    key: ValueKey(key),
    child: child,
    transitionsBuilder: (context, animation, _, child) {
      final scaleAnimation = Tween<double>(begin: 0, end: 1).animate(animation);
      return ScaleTransition(
        scale: scaleAnimation,
        child: FadeTransition(opacity: animation, child: child),
      );
    },
  );
}
