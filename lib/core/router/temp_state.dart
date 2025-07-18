part of 'temp_cubit.dart';

@immutable
sealed class TempState {}

final class TempInitial extends TempState {}

final class TempChanged extends TempState {}
