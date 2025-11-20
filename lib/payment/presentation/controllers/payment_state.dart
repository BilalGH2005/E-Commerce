part of 'payment_cubit.dart';

@immutable
sealed class PaymentState {}

final class PaymentInitial extends PaymentState {}

final class PaymentStateChanged extends PaymentState {}

final class PaymentFailedState extends PaymentState {}
