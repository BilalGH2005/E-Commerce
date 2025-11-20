import 'package:e_commerce/core/utils/shortcuts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:go_router/go_router.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: colorScheme(context).surface,
        backgroundColor: colorScheme(context).surface,
        leading: InkWell(
          onTap: () => context.pop(),
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Icon(
              Icons.arrow_back_ios,
              color: colorScheme(context).onSurface,
            ),
          ),
        ),
        centerTitle: true,
        title: Text(
          localization(context).termsAndConditions,
          style: textTheme(context).headlineMedium,
        ),
      ),
      body: SafeArea(
        child: Column(
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
}
