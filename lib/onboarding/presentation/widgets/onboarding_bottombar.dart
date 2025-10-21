import 'package:e_commerce/core/utils/shortcuts.dart';
import 'package:e_commerce/onboarding/cubit/onboarding_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingBottomBar extends StatelessWidget {
  // Not const: depends on Bloc state
  // ignore: prefer_const_constructors_in_immutables
  OnBoardingBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    final OnBoardingCubit cubit = context.read<OnBoardingCubit>();
    final int currentPage = cubit.currentPage;
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          currentPage > 0.5 && currentPage <= 2.0
              ? TextButton(
                  onPressed: () async => await cubit.goToPreviousPage(),
                  child: Text(
                    localization(context).prev,
                    style: textTheme(context).headlineMedium!.copyWith(
                      color: colorScheme(context).tertiary,
                    ),
                  ),
                )
              : const SizedBox(width: 64),
          SmoothPageIndicator(
            controller: cubit.pageController,
            count: 3,
            effect: ExpandingDotsEffect(
              radius: 40,
              dotWidth: 10,
              expansionFactor: 4,
              activeDotColor: colorScheme(context).onInverseSurface,
              dotColor: colorScheme(context).tertiary,
              dotHeight: 10,
            ),
          ),
          currentPage <= 1.5
              ? TextButton(
                  onPressed: () async => await cubit.goToNextPage(),
                  child: Text(
                    localization(context).next,
                    style: textTheme(context).headlineMedium!.copyWith(
                      color: colorScheme(context).primary,
                    ),
                  ),
                )
              : TextButton(
                  onPressed: () async => await cubit.goToSignIn(context),
                  child: Text(
                    localization(context).getStarted,
                    style: textTheme(context).headlineMedium!.copyWith(
                      color: colorScheme(context).primary,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
