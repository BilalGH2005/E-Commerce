import 'package:e_commerce/core/utils/auth_failure_mapper.dart';
import 'package:e_commerce/home/data/models/home_metadata_model.dart';
import 'package:flutter_async_value/flutter_async_value.dart';

abstract class HomeRepo {
  Future<AsyncResult<HomeMetadataModel, String>> getHomeMetadata();
}

class SupabaseHomeRepo implements HomeRepo {
  @override
  Future<AsyncResult<HomeMetadataModel, String>> getHomeMetadata() async {
    return await supabaseRpc(
      'get_home_metadata',
      fromJson: (json) => HomeMetadataModel.fromJson(json),
      get: true,
    );
  }
}
