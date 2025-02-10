import 'package:flutter/material.dart';

class GettingStartedScreen extends StatelessWidget {
  const GettingStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: screenSize.width,
        height: screenSize.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0xFF000000), Color(0xFF000000).withAlpha(23)]),
          image: DecorationImage(
            image: AssetImage('assets/images/getting_started.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              width: 390,
              height: 362,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 315,
                    child: Text(
                      'You want Authentic, here you go!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: 'montserrat',
                          fontSize: 34,
                          color: Theme.of(context).scaffoldBackgroundColor),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
