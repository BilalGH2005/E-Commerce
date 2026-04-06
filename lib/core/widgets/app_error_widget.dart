import 'package:e_commerce/core/constants/app_breakpoints.dart';
import 'package:e_commerce/core/widgets/app_button.dart';
import 'package:flutter/material.dart';

import '../utils/shortcuts.dart';

class AppErrorWidget extends StatelessWidget {
  final String error;
  final Widget labelWidget;
  final VoidCallback onPressed;

  const AppErrorWidget({
    super.key,
    required this.error,
    required this.labelWidget,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final gradient = LinearGradient(
      colors: [
        theme.colorScheme.secondary.withAlpha(37),
        theme.colorScheme.surface,
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: AppBreakpoints.kTabletWidth,
          minHeight: double.infinity,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 40),
          child: Material(
            color: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                gradient: gradient,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: theme.colorScheme.onSurface.withAlpha(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: theme.colorScheme.shadow.withAlpha(62),
                    offset: const Offset(0, 20),
                    blurRadius: 35,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 36,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: theme.colorScheme.secondaryContainer,
                      ),
                      child: Icon(
                        Icons.error_outline,
                        size: 56,
                        color: theme.colorScheme.onSecondaryContainer,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      error,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.displaySmall?.copyWith(
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      localization(context).somethingWentWrong,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 30),
                    AppButton(onPressed: onPressed, labelWidget: labelWidget),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
