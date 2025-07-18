import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'temp_state.dart';

class TempCubit extends Cubit<TempState> {
  TempCubit() : super(TempInitial());
  bool selected = true;
  bool selected2 = false;

  void toggleSelected(bool newValue) {
    selected = newValue;

    emit(TempChanged());
  }
}
