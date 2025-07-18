import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class SnackBarUtil {
  static void showError(String message) {
    _showSnackBar(message, ToastificationType.error);
  }

  static void showInfo(String message) {
    _showSnackBar(message, ToastificationType.info);
  }

  static void showSuccess(String message) {
    _showSnackBar(message, ToastificationType.success);
  }

  static void _showSnackBar(
      String message, ToastificationType toastificationType) {
    toastification.dismissAll();
    toastification.show(
      alignment: Alignment.topRight,
      description: Text(
        message, /*
            style: TextStyle()
                .copyWith(color: Theme.of(context!).colorScheme.tertiaryFixed)*/
      ),
      type: toastificationType,
      style: ToastificationStyle.fillColored,
      autoCloseDuration: Duration(seconds: 3),
      showProgressBar: true,
    );
    // borderSide: BorderSide(
    //   color: Theme.of(context).colorScheme.tertiary,
    // ),
    // backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
  }
}
