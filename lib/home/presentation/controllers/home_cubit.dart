import 'package:e_commerce/core/constants/app_breakpoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_async_value/flutter_async_value.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repos/home_repo.dart';
import '../../models/home_metadata_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepo _homeRepo;

  HomeCubit(HomeRepo homeRepo) : _homeRepo = homeRepo, super(HomeInitial()) {
    getHomeMetadata();
  }

  AsyncValue<HomeMetadataModel, String> homeMetadataModel =
      AsyncValue.initial();

  Future<void> getHomeMetadata() async {
    homeMetadataModel = AsyncValue.loading();
    emit(HomeStateChanged());

    final result = await _homeRepo.getHomeMetadata();

    if (result.isData) {
      homeMetadataModel = AsyncValue.data(data: result.data!);
    } else {
      homeMetadataModel = AsyncValue.error(error: result.error!);
    }
    emit(HomeStateChanged());
  }

  static double carouselProductsNumber(double width) {
    if (width >= AppBreakpoints.kDesktopWidth) return 1 / 4.5;
    if (width >= AppBreakpoints.kTabletWidth) return 1 / 2.5;
    return 1 / 1.5;
  }
}
