import 'package:e_commerce/core/utils/shortcuts.dart';
import 'package:e_commerce/core/widgets/app_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) => SafeArea(
    child: Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 100),
        child: Container(
          color: colorScheme(context).surface,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const AppBackButton(),
                Text(
                  localization(context).termsAndConditions,
                  style: textTheme(context).headlineMedium,
                ),
                const SizedBox(width: 24),
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
              data: localization(context).termsText,
              styleSheet: MarkdownStyleSheet(
                p: textTheme(context).displayMedium!.copyWith(height: 1.5),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
