import 'package:e_commerce/core/utils/constants/screens_names.dart';
import 'package:e_commerce/onboarding/cubit/onboarding_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
              if (currentPage > 0.5 && currentPage <= 2.0)
                TextButton(
                  onPressed: () {
                    cubit.goToPreviousPage();
                  },
                  child: const Text(
                    'Prev',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Color(0xFFC4C4C4),
                    ),
                  ),
                )
              else
                const SizedBox(
                  width: 64,
                ),
              SmoothPageIndicator(
                controller: cubit.pageController,
                count: 3,
                effect: const ExpandingDotsEffect(
                    radius: 40,
                    dotWidth: 10,
                    expansionFactor: 4,
                    activeDotColor: Color(0xFF17223B),
                    dotColor: Color(0xFFC4C4C4),
                    dotHeight: 10),
              ),
              currentPage <= 1.5
                  ? TextButton(
                      onPressed: () => cubit.goToNextPage(),
                      child: Text(
                        'Next',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    )
                  : TextButton(
                      onPressed: () async {
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setBool('hasSeenOnBoarding', true);
                        context.goNamed(ScreensNames.signIn);
                      },
                      child: Text(
                        'Get Started',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Theme.of(context).primaryColor,
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
