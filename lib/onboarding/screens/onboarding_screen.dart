import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/onboarding_cubit.dart';
import '../widgets/onboarding_appbar.dart';
import '../widgets/onboarding_bottombar.dart';
import '../widgets/onboarding_page.dart';

class OnBoardingScreen extends StatelessWidget {
  static const String id = 'onboarding_screen';

  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnBoardingCubit(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: OnBoardingAppBar(),
            bottomNavigationBar: OnBoardingBottomBar(),
            body: PageView(
              controller: context.watch<OnBoardingCubit>().pageController,
              children: const [
                OnBoardingPage(
                  imagePath: 'assets/images/onboard_screen1_image.svg',
                  title: 'Choose Products',
                  subTitle:
                      "Browse a wide range of products and find exactly what you need. From essentials to exclusive items, we've got it all at your fingertips.",
                ),
                OnBoardingPage(
                  imagePath: 'assets/images/onboard_screen2_image.svg',
                  title: 'Make Payments',
                  subTitle:
                      "Experience hassle-free payments with our secure and fast checkout process. Choose your preferred payment method and complete your purchase with confidence.",
                ),
                OnBoardingPage(
                  imagePath: 'assets/images/onboard_screen3_image.svg',
                  title: 'Get Your Order',
                  subTitle:
                      "Sit back and relax while we bring your order to your doorstep. Track your package in real-time and enjoy quick, reliable delivery.",
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
