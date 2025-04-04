import 'package:flutter/material.dart';

class SnackBarUtil {
  static void showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).colorScheme.inverseSurface,
        behavior: SnackBarBehavior.floating,
        content: Row(
          children: [
            Icon(
              Icons.error,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                message,
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(color: Theme.of(context).colorScheme.surface),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static void showNotificationSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).colorScheme.inverseSurface,
        behavior: SnackBarBehavior.floating,
        content: Row(
          children: [
            Icon(
              Icons.error,
              color: Theme.of(context).colorScheme.tertiaryFixed,
            ),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                message,
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(color: Theme.of(context).colorScheme.surface),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static void showSuccessfulSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).colorScheme.inverseSurface,
        behavior: SnackBarBehavior.floating,
        content: Row(
          children: [
            const Icon(
              Icons.check_circle,
              color: Colors.green,
            ),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                message,
                maxLines: 2,
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(color: Theme.of(context).colorScheme.surface),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
