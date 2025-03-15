import 'package:flutter/material.dart';
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
          'Terms and Conditions',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Markdown(
              data: _termsText,
              styleSheet: MarkdownStyleSheet(
                p: Theme.of(context).textTheme.displayMedium,
              ),
            ),
          ),
        ],
      ),
    );
  }

  final String _termsText = '''
Welcome to **E-Commerce!**

By accessing or using our services, you agree to comply with and be bound by the following terms and conditions:

1. **Account Registration**:
   - You must provide accurate and complete information during registration.
   - You are responsible for maintaining the confidentiality of your account credentials.

2. **Product Listings**:
   - We strive to ensure accurate product descriptions. However, we do not guarantee that product descriptions are error-free.

3. **Orders and Payments**:
   - All orders are subject to acceptance and availability.
   - Payments must be made through authorized methods. Unauthorized payments will not be processed.

4. **Returns and Refunds**:
   - Our return and refund policy is available on the app. Please review it before making a purchase.

5. **Prohibited Activities**:
   - You may not use the app for fraudulent activities, spamming, or any unlawful purposes.

6. **Privacy Policy**:
   - Your personal data is processed according to our Privacy Policy, available on the app.

7. **Liability Limitation**:
   - **E-Commerce** is not responsible for any indirect, incidental, or consequential damages arising from your use of our services.

Thank you for using **E-Commerce!**
''';
}
