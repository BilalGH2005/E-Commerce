import 'package:dio/dio.dart';
import 'package:e_commerce/core/utils/dependency_injection.dart';
import 'package:flutter_async_value/flutter_async_value.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class PaymentRepo {
  Future<AsyncResult<String, String>> createPaymentIntent({
    required double amount,
  });
}

class StripePaymentRepo implements PaymentRepo {
  @override
  Future<AsyncResult<String, String>> createPaymentIntent({
    required double amount,
  }) async {
    try {
      final response = await serviceLocator<Dio>().post(
        'https://api.stripe.com/v1/payment_intents',
        data: {'amount': (amount * 100).toInt().toString(), 'currency': 'usd'},
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {
            'Authorization': 'Bearer ${dotenv.env['STRIPE_SECRET_KEY']}',
          },
        ),
      );

      return AsyncResult.data(data: response.data['client_secret']);
    } on DioException catch (exception) {
      return AsyncResult.error(
        error: exception.response?.data['error']['message'] ?? 'other',
      );
    } catch (_) {
      return AsyncResult.error(error: 'other');
    }
  }
}
