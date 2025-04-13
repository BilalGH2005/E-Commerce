import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class ReusableBackButton extends StatelessWidget {
  const ReusableBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: AppLocalizations.of(context)!.back,
      onPressed: () => context.pop(),
      icon: Icon(
        Icons.arrow_back_ios,
        color: Theme.of(context).colorScheme.inverseSurface,
      ),
    );
  }
}
