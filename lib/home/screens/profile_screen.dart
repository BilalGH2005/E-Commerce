import 'package:e_commerce/core/constants/assets.dart';
import 'package:e_commerce/core/widgets/app_field.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameTextController = TextEditingController(),
      emailTextController = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                child: Column(
                  children: [
                    SizedBox(
                      width: 120,
                      child: Stack(
                        children: [
                          CircleAvatar(
                            minRadius: 60,
                            backgroundColor:
                                Theme.of(context).colorScheme.tertiaryFixed,
                            child: Image.asset(
                              Assets.kGettingStarted,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Positioned(
                            bottom: -10,
                            right: -10,
                            child: IconButton(
                              icon: Container(
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                child: Icon(
                                  Icons.edit_outlined,
                                  size: 24,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .surfaceContainer,
                                ),
                              ),
                              onPressed: () {},
                            ),
                          )
                        ],
                      ),
                    ),
                    AppField(controller: nameTextController, label: 'name'),
                    AppField(controller: emailTextController, label: 'email')
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
