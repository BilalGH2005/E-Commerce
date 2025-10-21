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
  Widget build(BuildContext context) => Center(
    child: ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: AppBreakpoints.kTabletWidth,
        minHeight: double.infinity,
      ),
      child: Padding(
        padding: const EdgeInsets.all(50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(error, style: textTheme(context).displayMedium),
            const SizedBox(height: 14),
            AppButton(onPressed: onPressed, labelWidget: labelWidget),
          ],
        ),
      ),
    ),
  );
}
