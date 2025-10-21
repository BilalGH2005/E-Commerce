import 'package:flutter/material.dart';
import 'package:flutter_async_value/flutter_async_value.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthFailureMapper {
  // Maping Supabase authentication error codes to localization keys and returns 'other' as a fallback key for unmapped errors.
  static String supabaseAuthError(String? errorCode) {
    switch (errorCode) {
      case 'user_already_exists':
        return 'userAlreadyExists';
      case 'user_not_found':
        return 'userDoesNotExist';
      case 'invalid_credentials':
        return 'invalidLoginCredentials';
      case 'over_email_send_rate_limit':
        return 'tooManyRequests';
      case 'same_password':
        return 'cantUseOldPassword';
      case 'email_not_confirmed':
        return 'emailNotConfirmed';
      default:
        return 'other';
    }
  }
}

Future<AsyncResult<T, String>> supabaseRpc<T>(
  String name, {
  T Function(dynamic json)? fromJson,
  Map<String, dynamic>? params,
  Map<String, String>? customErrors,
  dynamic get = false,
}) async {
  debugPrint('STARTED');
  try {
    final response = await Supabase.instance.client.rpc(
      name,
      params: params ?? {},
      get: get,
    );
    debugPrint("RPC RESPONSE $response");

    if (fromJson != null) {
      if (response is List && T.toString().startsWith('List<')) {
        return AsyncResult.data(data: fromJson(response));
      } else if (response is Map<String, dynamic>) {
        return AsyncResult.data(data: fromJson(response));
      } else {
        return AsyncResult.error(error: 'invalid_response_type');
      }
    }

    return AsyncResult.data(data: null);
  } on PostgrestException catch (exception) {
    if (exception.code == null ||
        customErrors == null ||
        !customErrors.containsKey(exception.code)) {
      return AsyncResult.error(error: 'other');
    }
    return AsyncResult.error(error: customErrors[exception.code!]!);
  } catch (exception) {
    debugPrint('RPC Exception: $exception');
    return AsyncResult.error(error: 'other');
  }
}
