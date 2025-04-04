import 'package:e_commerce/core/utils/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  final SupabaseClient _supabase = Supabase.instance.client;
  AsyncValue<List<Map<String, dynamic>>>? products;

  Future<void> fetchProducts() async {
    products = AsyncValue.loading();
    emit(HomeStateChanged());

    try {
      final response = await _supabase
          .from('products')
          .select('*')
          .order('id', ascending: true);
      products = AsyncValue.data(data: response);
    } catch (exception) {
      products = AsyncValue.error(error: exception.toString());
    } finally {
      emit(HomeStateChanged());
    }
  }
}
