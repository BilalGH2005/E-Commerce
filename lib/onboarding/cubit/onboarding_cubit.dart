import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/routes/app_router.dart';
import '../../core/utils/screens_names.dart';

part 'onboarding_state.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {
  OnBoardingCubit() : super(OnBoardingInitial()) {
    _addPageViewListener();
  }

  final PageController pageController = PageController();
  int currentPage = 0;

  void _addPageViewListener() => pageController.addListener(() {
        currentPage = pageController.page?.round() ?? 0;
        emit(OnBoardingPageChanged());
      });

  Future<void> goToPreviousPage() async => await pageController.previousPage(
        duration: const Duration(milliseconds: 1000),
        curve: Curves.decelerate,
      );

  Future<void> goToNextPage() async => await pageController.nextPage(
        duration: const Duration(milliseconds: 1000),
        curve: Curves.decelerate,
      );

  Future<void> goToSignIn() async {
    final BuildContext? context = AppRouter.navigatorKey.currentContext;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('seenOnBoarding', true);
    context!.goNamed(ScreensNames.signIn);
  }

  @override
  Future<void> close() {
    pageController.dispose();
    return super.close();
  }
}
