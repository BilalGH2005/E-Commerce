import 'package:e_commerce/core/utils/localization.dart';
import 'package:e_commerce/onboarding/cubit/onboarding_cubit.dart';
import 'package:e_commerce/onboarding/widgets/onboarding_appbar.dart';
import 'package:e_commerce/onboarding/widgets/onboarding_bottombar.dart';
import 'package:e_commerce/onboarding/widgets/onboarding_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/constants/assets.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (BuildContext context) => OnBoardingCubit(),
        child: Builder(
          builder: (context) => Scaffold(
            appBar: OnBoardingAppBar(),
            bottomNavigationBar: const OnBoardingBottomBar(),
            body: PageView(
              controller: context.watch<OnBoardingCubit>().pageController,
              children: [
                OnBoardingPage(
                  imagePath: Assets.kOnBoardingScreen1,
                  title: localization(context).chooseProducts,
                  subTitle: localization(context).chooseProductsSubtitle,
                ),
                OnBoardingPage(
                  imagePath: Assets.kOnBoardingScreen2,
                  title: localization(context).makePayments,
                  subTitle: localization(context).makePaymentsSubtitle,
                ),
                OnBoardingPage(
                  imagePath: Assets.kOnBoardingScreen3,
                  title: localization(context).getYourOrder,
                  subTitle: localization(context).getYourOrderSubtitle,
                ),
              ],
            ),
          ),
        ),
      );
}
