import 'package:e_commerce/core/constants/assets.dart';
import 'package:e_commerce/core/utils/responsive_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ResponsiveBuilder(
          mobile: (context) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(Assets.kAppLogo),
              const SizedBox(
                height: 15,
              ),
              Text(
                'E-Commerce',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ],
          ),
          tablet: (context) => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(Assets.kAppLogo),
              const SizedBox(
                width: 10,
              ),
              Text(
                'E-Commerce',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
