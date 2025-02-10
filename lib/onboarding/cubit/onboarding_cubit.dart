import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  void goToLastPage() => pageController.jumpToPage(2);

  void goToPreviousPage() => pageController.previousPage(
        duration: const Duration(milliseconds: 1000),
        curve: Curves.decelerate,
      );

  void goToNextPage() => pageController.nextPage(
        duration: const Duration(milliseconds: 1000),
        curve: Curves.decelerate,
      );

  @override
  Future<void> close() {
    pageController.dispose();
    return super.close();
  }
}
