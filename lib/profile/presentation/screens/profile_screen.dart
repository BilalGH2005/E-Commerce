import 'package:e_commerce/core/constants/app_images.dart';
import 'package:e_commerce/core/widgets/app_field.dart';
import 'package:e_commerce/profile/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          final cubit = context.read<ProfileCubit>();
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 120,
                          child: Stack(
                            children: [
                              CircleAvatar(
                                  minRadius: 60,
                                  backgroundColor: Theme
                                      .of(context)
                                      .colorScheme
                                      .tertiaryFixed,
                                  child: SvgPicture.asset(AppImages.kAppLogo)),
                              Positioned(
                                bottom: -10,
                                right: -10,
                                child: IconButton(
                                  icon: Container(
                                    padding: const EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color:
                                      Theme
                                          .of(context)
                                          .colorScheme
                                          .primary,
                                    ),
                                    child: Icon(
                                      Icons.edit_outlined,
                                      size: 24,
                                      color: Theme
                                          .of(context)
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
                        AppField(
                            controller: cubit.nameTextController,
                            label: 'name'),
                        AppField(
                            controller: cubit.emailTextController,
                            label: 'email')
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
}
