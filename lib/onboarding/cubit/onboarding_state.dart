part of 'onboarding_cubit.dart';

@immutable
sealed class OnBoardingState {}

final class OnBoardingInitial extends OnBoardingState {}

final class OnBoardingPageChanged extends OnBoardingState {}
