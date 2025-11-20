part of 'collection_cubit.dart';

@immutable
sealed class CollectionState {}

final class CollectionInitial extends CollectionState {}

final class CollectionStateChanged extends CollectionState {}
