import 'package:bloc/bloc.dart';
import 'package:e_commerce/core/utils/svg_util.dart';
import 'package:flutter/material.dart';

part 'onboarding_state.dart';

//TODO: imp(3) - show onboarding screen for one time (Kinan)

class OnBoardingCubit extends Cubit<OnBoardingState> {
  OnBoardingCubit() : super(OnBoardingInitial()) {
    print('OnBoardingCubit instantiated');
    SvgUtil.preLoadSvgImages([
      'assets/images/onboard_screen1_image.svg',
      'assets/images/onboard_screen2_image.svg',
      'assets/images/onboard_screen3_image.svg',
    ]);
    _addListener();
  }
  final PageController pageController = PageController();
  int currentPage = 0;

  void _addListener() => pageController.addListener(() {
        currentPage = pageController.page?.round() ?? 0;
        emit(OnBoardingPageChanged());
      });

  // Future<void> setFirstTime(bool value) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setBool('firstTime', value);
  // }
  //
  // Future<bool?> getFirstTime() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getBool('firstTime');
  // }
  //
  // Future<void> initialize() async {
  //   final initialCounter = await getFirstTime();
  //   emit(OnBoardingPageChanged());
  // }

  void goToLastPage() => pageController.jumpToPage(2);

  void goToPreviousPage() => pageController.previousPage(
        duration: const Duration(milliseconds: 1500),
        curve: Curves.decelerate,
      );

  void goToNextPage() => pageController.nextPage(
        duration: const Duration(milliseconds: 1500),
        curve: Curves.decelerate,
      );

  @override
  Future<void> close() {
    pageController.dispose();
    return super.close();
  }
}
