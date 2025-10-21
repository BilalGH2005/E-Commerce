import 'package:e_commerce/collection/data/repos/collection_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_async_value/flutter_async_value.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/models/product_preview.dart';

part 'collection_state.dart';

class CollectionCubit extends Cubit<CollectionState> {
  final String collectionId;
  final CollectionRepo collectionRepo;

  CollectionCubit({required this.collectionRepo, required this.collectionId})
    : super(CollectionInitial()) {
    getCollectionProducts(collectionId: collectionId);
  }

  AsyncValue<List<ProductPreview>, String> collectionProducts =
      AsyncValue.initial();

  Future<void> getCollectionProducts({required String collectionId}) async {
    collectionProducts = AsyncValue.loading();
    emit(CollectionStateChanged());

    final result = await collectionRepo.getCollectionProducts(collectionId);

    if (result.isData) {
      collectionProducts = AsyncValue.data(data: result.data!);
    } else {
      collectionProducts = AsyncValue.error(error: result.error!);
    }
    emit(CollectionStateChanged());
  }
}
