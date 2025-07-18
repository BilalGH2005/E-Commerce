import 'package:flutter_async_value/flutter_async_value.dart';

import '../../../core/utils/auth_failure_mapper.dart';
import '../../../shop/data/models/filtered_products_model.dart';

abstract class ProfileRepo {
  Future<AsyncResult<Product, String>> getProfileData(String productId);
}

class SupabaseProfileRepo implements ProfileRepo {
  @override
  Future<AsyncResult<Product, String>> getProfileData(String userID) async {
    return supabaseRpc('get_profile_data', params: {'user_id': userID});
  }
}
