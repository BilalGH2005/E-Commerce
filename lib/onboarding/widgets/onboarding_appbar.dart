import 'package:e_commerce/core/utils/localization.dart';
import 'package:e_commerce/onboarding/cubit/onboarding_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnBoardingAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;
  const OnBoardingAppBar({super.key})
      : preferredSize = const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16),
        child: BlocBuilder<OnBoardingCubit, OnBoardingState>(
          builder: (context, state) {
            final OnBoardingCubit cubit = context.read<OnBoardingCubit>();
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: RichText(
                    text: TextSpan(
                      text: (cubit.currentPage + 1).toString(),
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(
                              color:
                                  Theme.of(context).colorScheme.inverseSurface),
                      children: <TextSpan>[
                        TextSpan(
                          text: '/3',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .tertiaryFixedDim),
                        ),
                      ],
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () async => await cubit.goToSignIn(context),
                  child: Text(
                    localization(context).skip,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
              ],
            );
          },
        ),
      );
}
