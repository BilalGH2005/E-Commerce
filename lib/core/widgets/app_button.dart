import 'package:flutter/material.dart';

import '../utils/shortcuts.dart';

class AppButton extends StatefulWidget {
  final void Function()? onPressed;
  final Widget labelWidget;

  const AppButton({
    super.key,
    required this.onPressed,
    required this.labelWidget,
  });

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  var _pressed = false;

  void _handleTapDown(TapDownDetails _) {
    setState(() => _pressed = true);
  }

  void _handleTapCancel() {
    setState(() => _pressed = false);
  }

  void _handleTapUp(TapUpDetails _) {
    setState(() => _pressed = false);
  }

  @override
  Widget build(BuildContext context) {
    final scheme = colorScheme(context);
    final scale = _pressed ? 0.97 : 1.0;

    return AnimatedScale(
      scale: scale,
      duration: const Duration(milliseconds: 120),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        elevation: 0,
        color: Colors.transparent,
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: scheme.primary,
            boxShadow: [
              BoxShadow(
                color: scheme.primary.withAlpha(90),
                offset: const Offset(0, 16),
                blurRadius: 32,
              ),
            ],
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            splashColor: scheme.onPrimary.withAlpha(25),
            highlightColor: scheme.onPrimary.withAlpha(20),
            onTapDown: _handleTapDown,
            onTapCancel: _handleTapCancel,
            onTapUp: (details) {
              _handleTapUp(details);
            },
            onTap: widget.onPressed,
            child: Container(
              width: double.infinity,
              height: 56,
              alignment: Alignment.center,
              child: DefaultTextStyle.merge(
                style: textTheme(context).displaySmall!.copyWith(
                  color: scheme.onPrimary,
                  fontWeight: FontWeight.w600,
                ),
                child: widget.labelWidget,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
