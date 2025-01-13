import 'package:e_commerce/onboarding/cubit/onboarding_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnBoardingAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;
  OnBoardingAppBar({super.key}) : preferredSize = Size.fromHeight(22);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0.0,
      leading: Padding(
        padding: const EdgeInsets.only(left: 17),
        child: BlocBuilder<OnBoardingCubit, OnBoardingState>(
          builder: (context, state) {
            final cubit = context.read<OnBoardingCubit>();
            return RichText(
              text: TextSpan(
                text: (cubit.currentPage + 1).toString(),
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Theme.of(context).textTheme.bodyLarge!.color),
                children: const <TextSpan>[
                  TextSpan(
                    text: '/3',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Montserrat',
                      fontSize: 18,
                      color: Color(0xFFA0A0A1),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 17.0),
          child: TextButton(
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size(0, 0),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            onPressed: () {
              context.read<OnBoardingCubit>().goToLastPage();
            },
            child: Text(
              'Skip',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: Theme.of(context).textTheme.bodyLarge!.color,
              ),
            ),
          ),
        )
      ],
    );
  }
}
