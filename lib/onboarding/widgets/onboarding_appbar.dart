import 'package:e_commerce/onboarding/cubit/onboarding_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OnBoardingAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;
  const OnBoardingAppBar({super.key})
      : preferredSize = const Size.fromHeight(22);

  @override
  Widget build(BuildContext context) => AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 17),
          child: BlocBuilder<OnBoardingCubit, OnBoardingState>(
            builder: (context, state) {
              final OnBoardingCubit cubit = context.read<OnBoardingCubit>();
              return RichText(
                text: TextSpan(
                  text: (cubit.currentPage + 1).toString(),
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: Theme.of(context).colorScheme.inverseSurface),
                  children: <TextSpan>[
                    TextSpan(
                      text: '/3',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(
                              color: Theme.of(context).colorScheme.tertiary),
                    ),
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
                minimumSize: const Size(0, 0),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              onPressed: () => context.read<OnBoardingCubit>().goToLastPage(),
              child: Text(AppLocalizations.of(context)!.skip,
                  style: Theme.of(context).textTheme.headlineMedium!),
            ),
          )
        ],
      );
}
