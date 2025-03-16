import 'package:e_commerce/core/utils/screens_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/widgets/reusable_button.dart';

class GettingStartedScreen extends StatelessWidget {
  const GettingStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/getting_started.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding:
                  EdgeInsets.only(bottom: 30, left: 55, right: 55, top: 55),
              height: 362,
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
              child: Column(
                children: [
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    AppLocalizations.of(context)!.youWantAuthentic,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontFamily: 'montserrat',
                        fontSize: 34,
                        color: Theme.of(context).scaffoldBackgroundColor),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    AppLocalizations.of(context)!.findItHereBuyItNow,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'montserrat',
                      color: Color(0xFFF2F2F2),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  ReusableButton(
                    onPressed: () async {
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.setBool('seenGettingStarted', true);
                      context.goNamed(ScreensNames.home);
                    },
                    label: Text(AppLocalizations.of(context)!.getStarted,
                        style: Theme.of(context).textTheme.bodyMedium),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
