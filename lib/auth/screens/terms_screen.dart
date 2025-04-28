import 'package:e_commerce/core/reusable_widgets/reusable_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size(double.infinity, 100),
            child: Container(
              color: Theme.of(context).colorScheme.surface,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ReusableBackButton(),
                    Text(
                      AppLocalizations.of(context)!.termsAndConditions,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    SizedBox(width: 24)
                  ],
                ),
              ),
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Markdown(
                  data: AppLocalizations.of(context)!.termsText,
                  styleSheet: MarkdownStyleSheet(
                    p: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(height: 1.5),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
