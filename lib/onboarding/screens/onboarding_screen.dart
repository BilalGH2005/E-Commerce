import 'package:e_commerce/core/utils/asset_images_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../cubit/onboarding_cubit.dart';
import '../widgets/onboarding_appbar.dart';
import '../widgets/onboarding_bottombar.dart';
import '../widgets/onboarding_page.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (BuildContext context) => OnBoardingCubit(),
        child: Builder(
          builder: (context) => Padding(
            padding: const EdgeInsets.all(12.0),
            child: Scaffold(
              appBar: const OnBoardingAppBar(),
              bottomNavigationBar: const OnBoardingBottomBar(),
              body: PageView(
                controller: context.watch<OnBoardingCubit>().pageController,
                children: [
                  OnBoardingPage(
                    imagePath: AssetImagesPaths.kOnBoardingScreen1,
                    title: AppLocalizations.of(context)!.chooseProducts,
                    subTitle:
                        AppLocalizations.of(context)!.chooseProductsSubtitle,
                  ),
                  OnBoardingPage(
                    imagePath: AssetImagesPaths.kOnBoardingScreen2,
                    title: AppLocalizations.of(context)!.makePayments,
                    subTitle:
                        AppLocalizations.of(context)!.makePaymentsSubtitle,
                  ),
                  OnBoardingPage(
                    imagePath: AssetImagesPaths.kOnBoardingScreen3,
                    title: AppLocalizations.of(context)!.getYourOrder,
                    subTitle:
                        AppLocalizations.of(context)!.getYourOrderSubtitle,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
