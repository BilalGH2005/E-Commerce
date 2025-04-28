import 'package:e_commerce/onboarding/cubit/onboarding_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingBottomBar extends StatelessWidget {
  const OnBoardingBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnBoardingCubit, OnBoardingState>(
      builder: (context, state) {
        final OnBoardingCubit cubit = context.read<OnBoardingCubit>();
        final int currentPage = cubit.currentPage;
        return SizedBox(
          height: 35,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              currentPage > 0.5 && currentPage <= 2.0
                  ? TextButton(
                      onPressed: () async => await cubit.goToPreviousPage(),
                      child: Text(
                        AppLocalizations.of(context)!.prev,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                                color: Theme.of(context).colorScheme.tertiary),
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
                        AppLocalizations.of(context)!.next,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                                color: Theme.of(context).colorScheme.primary),
                      ),
                    )
                  : TextButton(
                      onPressed: () async => await cubit.goToSignIn(),
                      child: Text(
                        AppLocalizations.of(context)!.getStarted,
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
}
