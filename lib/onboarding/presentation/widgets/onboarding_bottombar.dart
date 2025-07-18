import 'package:e_commerce/core/utils/localization.dart';
import 'package:e_commerce/onboarding/cubit/onboarding_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingBottomBar extends StatelessWidget {
  const OnBoardingBottomBar({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<OnBoardingCubit, OnBoardingState>(
        builder: (context, state) {
          final OnBoardingCubit cubit = context.read<OnBoardingCubit>();
          final int currentPage = cubit.currentPage;
          return Padding(
            padding:
                const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                currentPage > 0.5 && currentPage <= 2.0
                    ? TextButton(
                        onPressed: () async => await cubit.goToPreviousPage(),
                        child: Text(
                          localization(context).prev,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.tertiary),
                        ),
                      )
                    : const SizedBox(
                        width: 64,
                      ),
                SmoothPageIndicator(
                  controller: cubit.pageController,
                  count: 3,
                  effect: ExpandingDotsEffect(
                      radius: 40,
                      dotWidth: 10,
                      expansionFactor: 4,
                      activeDotColor:
                          Theme.of(context).colorScheme.onInverseSurface,
                      dotColor: Theme.of(context).colorScheme.tertiary,
                      dotHeight: 10),
                ),
                currentPage <= 1.5
                    ? TextButton(
                        onPressed: () async => await cubit.goToNextPage(),
                        child: Text(
                          localization(context).next,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(
                                  color: Theme.of(context).colorScheme.primary),
                        ),
                      )
                    : TextButton(
                        onPressed: () async => await cubit.goToSignIn(context),
                        child: Text(
                          localization(context).getStarted,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                      ),
              ],
            ),
          );
        },
      );
}
