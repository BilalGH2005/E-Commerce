import 'package:e_commerce/core/utils/localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({super.key});

  @override
  Widget build(BuildContext context) => IconButton(
        tooltip: localization(context).back,
        onPressed: () => context.pop(),
        icon: Icon(Icons.arrow_back_ios_new_outlined),
      );
}
