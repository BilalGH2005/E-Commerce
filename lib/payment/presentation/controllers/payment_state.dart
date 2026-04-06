part of 'payment_cubit.dart';

@immutable
sealed class PaymentState {}

final class PaymentInitial extends PaymentState {}

final class PaymentStateChanged extends PaymentState {}

final class PaymentSuccessful extends PaymentState {}

final class PaymentFailed extends PaymentState {}
