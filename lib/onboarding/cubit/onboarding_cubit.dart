import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// import 'package:shared_preferences/shared_preferences.dart';

part 'onboarding_state.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {
  final PageController pageController = PageController();
  int currentPage = 0;
  //TODO: imp(3) - show onboarding screen for one time (Kinan)
  // bool? firstTime;
  OnBoardingCubit() : super(OnBoardingInitial()) {
    _preLoadSvgImages();
    _addListener();
  }

  void _addListener() {
    pageController.addListener(() {
      currentPage = pageController.page?.round() ?? 0;
      emit(OnBoardingPageChanged());
    });
  }
  //
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

  void _preLoadSvgImages() async {
    const svgAssets = [
      'assets/images/onboard_screen1_image.svg',
      'assets/images/onboard_screen2_image.svg',
      'assets/images/onboard_screen3_image.svg',
    ];
    for (final asset in svgAssets) {
      await svg.cache.putIfAbsent(SvgAssetLoader(asset).cacheKey(null),
          () => SvgAssetLoader(asset).loadBytes(null));
    }
  }

  void goToLastPage() {
    pageController.jumpToPage(2);
  }

  void goToPreviousPage() {
    pageController.previousPage(
      duration: Duration(milliseconds: 1500),
      curve: Curves.decelerate,
    );
  }

  void goToNextPage() {
    pageController.nextPage(
      duration: Duration(milliseconds: 1500),
      curve: Curves.decelerate,
    );
  }

  @override
  Future<void> close() {
    pageController.dispose();
    return super.close();
  }
}
