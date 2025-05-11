import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnBoardingPage extends StatelessWidget {
  final String imagePath, title, subTitle;
  const OnBoardingPage(
      {super.key,
      required this.imagePath,
      required this.subTitle,
      required this.title});

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 350,
                child: Column(
                  children: [
                    const Spacer(),
                    SvgPicture.asset(imagePath),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                title,
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.inverseSurface),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                subTitle,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.tertiaryFixedDim,
                    ),
              ),
              const SizedBox(
                height: 65,
              )
            ],
          ),
        ),
      );
}
