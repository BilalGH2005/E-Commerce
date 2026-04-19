import 'package:e_commerce/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

import '../utils/shortcuts.dart';

class AppButton extends StatefulWidget {
  final void Function()? onPressed;
  final Widget? labelWidget;
  final String? label;
  final bool isLoading;
  final Widget? loadingWidget;
  final Color? color;

  const AppButton({
    super.key,
    required this.onPressed,
    this.labelWidget,
    this.label,
    this.isLoading = false,
    this.loadingWidget,
    this.color,
  }) : assert(
         labelWidget != null || label != null,
         'AppButton requires either labelWidget or label.',
       );

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
    final isEnabled = widget.onPressed != null && !widget.isLoading;
    final scale = _pressed ? 0.97 : 1.0;
    final labelColor = isEnabled ? scheme.onPrimary : scheme.onSurfaceVariant;
    final currentLabel = widget.isLoading
        ? (widget.loadingWidget ??
              SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(color: AppColors.white),
              ))
        : (widget.labelWidget ??
              Text(widget.label!, style: textTheme(context).bodyMedium));

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
            color: widget.color ?? scheme.primary,
            boxShadow: [
              // BoxShadow(
              //   color:
              //       widget.color?.withAlpha(90) ?? scheme.primary.withAlpha(90),
              //   offset: const Offset(0, 16),
              //   blurRadius: 32,
              // ),
            ],
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            splashColor: scheme.onPrimary.withAlpha(25),
            highlightColor: scheme.onPrimary.withAlpha(20),
            onTapDown: isEnabled ? _handleTapDown : null,
            onTapCancel: isEnabled ? _handleTapCancel : null,
            onTapUp: isEnabled
                ? (details) {
                    _handleTapUp(details);
                  }
                : null,
            onTap: isEnabled ? widget.onPressed : null,
            child: Container(
              width: double.infinity,
              height: 56,
              alignment: Alignment.center,
              child: DefaultTextStyle.merge(
                style: textTheme(context).displaySmall!.copyWith(
                  color: labelColor,
                  fontWeight: FontWeight.w600,
                ),
                child: currentLabel,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
