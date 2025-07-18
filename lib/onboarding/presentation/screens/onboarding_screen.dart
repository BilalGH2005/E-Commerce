import 'package:e_commerce/core/constants/app_images.dart';
import 'package:e_commerce/core/utils/localization.dart';
import 'package:e_commerce/onboarding/cubit/onboarding_cubit.dart';
import 'package:e_commerce/onboarding/presentation/widgets/onboarding_appbar.dart';
import 'package:e_commerce/onboarding/presentation/widgets/onboarding_bottombar.dart';
import 'package:e_commerce/onboarding/presentation/widgets/onboarding_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: OnBoardingAppBar(),
        bottomNavigationBar: const OnBoardingBottomBar(),
        body: PageView(
          controller: context.read<OnBoardingCubit>().pageController,
          children: [
            OnBoardingPage(
              imagePath: AppImages.kOnBoardingScreen1,
              title: localization(context).chooseProducts,
              subTitle: localization(context).chooseProductsSubtitle,
            ),
            OnBoardingPage(
              imagePath: AppImages.kOnBoardingScreen2,
              title: localization(context).makePayments,
              subTitle: localization(context).makePaymentsSubtitle,
            ),
            OnBoardingPage(
              imagePath: AppImages.kOnBoardingScreen3,
              title: localization(context).getYourOrder,
              subTitle: localization(context).getYourOrderSubtitle,
            ),
          ],
        ),
      );
}
