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
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(34.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 350,
            child: Column(
              children: [
                Spacer(),
                SvgPicture.asset(imagePath),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 24.0,
              fontFamily: 'Montserrat',
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            subTitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              fontFamily: 'Montserrat',
              color: Color(0xFFA8A8A9),
            ),
          ),
          SizedBox(
            height: 65,
          )
        ],
      ),
    );
  }
}
