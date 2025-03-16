import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //TODO: solve appbar color to be const
      appBar: AppBar(
        foregroundColor: Theme.of(context).colorScheme.inverseSurface,
        title: Text(
          AppLocalizations.of(context)!.termsAndConditions,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Markdown(
              data: AppLocalizations.of(context)!.termsText,
              styleSheet: MarkdownStyleSheet(
                p: Theme.of(context).textTheme.displayMedium!.copyWith(
                    color: Theme.of(context).colorScheme.inverseSurface),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
