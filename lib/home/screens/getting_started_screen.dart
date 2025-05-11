import 'package:e_commerce/core/constants/assets.dart';
import 'package:e_commerce/core/constants/breakpoints.dart';
import 'package:e_commerce/core/constants/screens_names.dart';
import 'package:e_commerce/core/utils/localization.dart';
import 'package:e_commerce/core/widgets/app_button.dart';
import 'package:e_commerce/main.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GettingStartedScreen extends StatelessWidget {
  const GettingStartedScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        //TODO: add single child scroll view to prevent render flex
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Assets.kGettingStarted),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.only(
                    bottom: 30, left: 55, right: 55, top: 55),
                height: 362,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withAlpha(0),
                      Colors.black.withAlpha(160),
                    ],
                    stops: [0.0, 0.24],
                  ),
                ),
                child: ConstrainedBox(
                  constraints:
                      BoxConstraints(maxWidth: Breakpoints.tabletWidth),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        localization(context).youWantAuthentic,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      Text(
                        localization(context).findItHereBuyItNow,
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(color: const Color(0xFFF2F2F2)),
                      ),
                      Center(
                        child: ConstrainedBox(
                          constraints:
                              BoxConstraints(maxWidth: Breakpoints.tabletWidth),
                          child: AppButton(
                            onPressed: () async {
                              await sharedPreferences.setBool(
                                  'seenGettingStarted', true);
                              context.goNamed(ScreensNames.home);
                            },
                            label: Text(localization(context).getStarted,
                                style: Theme.of(context).textTheme.bodyMedium),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
