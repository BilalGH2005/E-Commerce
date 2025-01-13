import 'package:flutter/material.dart';

class SnackBarUtil {
  static void showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
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
                maxLines: 2,
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
        behavior: SnackBarBehavior.floating,
        content: Row(
          children: [
            Icon(
              Icons.check_circle,
              color: Colors.green,
            ),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                message,
                maxLines: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
