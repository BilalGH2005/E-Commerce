import 'package:e_commerce/core/utils/asset_images_paths.dart';
import 'package:flutter/material.dart';

import '../widgets/sign_up_form.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) => constraints.maxWidth >= 768
            ? Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(AssetImagesPaths.kGettingStarted),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  ConstrainedBox(
                      constraints: BoxConstraints(
                          maxWidth: constraints.maxWidth >= 1024 ? 600 : 420,
                          minHeight: double.infinity),
                      child: signUpForm(context, formKey))
                ],
              )
            : signUpForm(context, formKey),
      ),
    );
  }
}
