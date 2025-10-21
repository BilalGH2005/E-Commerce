import 'package:e_commerce/core/utils/duration_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_routes.dart';
import '../../core/cubit/app_cubit.dart';

part 'onboarding_state.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {
  OnBoardingCubit() : super(OnBoardingInitial());

  final PageController pageController = PageController();

  int currentPage = 0;

  void onPageChanged(int index) {
    currentPage = index;
    emit(OnBoardingPageChanged());
  }

  Future<void> goToPreviousPage() async => await pageController.previousPage(
        duration: 1.s,
        curve: Curves.decelerate,
      );

  Future<void> goToNextPage() async => await pageController.nextPage(
        duration: 1.s,
        curve: Curves.decelerate,
      );

  Future<void> goToSignIn(BuildContext context) async {
    await context.read<AppCubit>().hasSeenOnBoarding();
    context.goNamed(AppRoutes.auth.name);
  }

  @override
  Future<void> close() {
    pageController.dispose();
    return super.close();
  }
}
