import 'package:e_commerce/core/constants/app_breakpoints.dart';
import 'package:e_commerce/home/data/models/home_metadata_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_async_value/flutter_async_value.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/repos/home_repo.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeRepo homeRepo;

  HomeCubit(this.homeRepo) : super(HomeInitial()) {
    getHomeMetadata();
  }

  AsyncValue<HomeMetadataModel, String> homeMetadataModel =
      AsyncValue.initial();

  Future<void> getHomeMetadata() async {
    homeMetadataModel = AsyncValue.loading();
    emit(HomeStateChanged());

    final result = await homeRepo.getHomeMetadata();

    if (result.isData) {
      homeMetadataModel = AsyncValue.data(data: result.data!);
    } else {
      homeMetadataModel = AsyncValue.error(error: result.error!);
    }
    emit(HomeStateChanged());
  }

  static double carouselProductsNumber(double width) {
    if (width >= AppBreakpoints.kDesktopWidth) return 1 / 3.5;
    if (width >= AppBreakpoints.kTabletWidth) return 1 / 2.5;
    return 1 / 1.5;
  }
}
