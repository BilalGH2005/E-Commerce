import 'package:e_commerce/core/utils/shortcuts.dart';
import 'package:e_commerce/onboarding/cubit/onboarding_cubit.dart';
import 'package:e_commerce/onboarding/presentation/widgets/onboarding_appbar.dart';
import 'package:e_commerce/onboarding/presentation/widgets/onboarding_bottombar.dart';
import 'package:e_commerce/onboarding/presentation/widgets/onboarding_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/assets.gen.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnBoardingCubit, OnBoardingState>(
      builder: (context, state) {
        final cubit = context.read<OnBoardingCubit>();
        return Scaffold(
          appBar: OnBoardingAppBar(),
          bottomNavigationBar: OnBoardingBottomBar(),
          body: PageView(
            controller: cubit.pageController,
            onPageChanged: cubit.onPageChanged,
            children: [
              OnBoardingPage(
                imagePath: Assets.images.onboarding1,
                title: localization(context).chooseProducts,
                subTitle: localization(context).chooseProductsSubtitle,
              ),
              OnBoardingPage(
                imagePath: Assets.images.onboarding2,
                title: localization(context).makePayments,
                subTitle: localization(context).makePaymentsSubtitle,
              ),
              OnBoardingPage(
                imagePath: Assets.images.onboarding3,
                title: localization(context).getYourOrder,
                subTitle: localization(context).getYourOrderSubtitle,
              ),
            ],
          ),
        );
      },
    );
  }
}
