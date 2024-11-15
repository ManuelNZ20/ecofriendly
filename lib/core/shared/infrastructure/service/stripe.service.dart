import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:dio/dio.dart';
import 'package:ecofriendly_flutter_app/core/core.dart';

class StripeService {
  StripeService._();
  static final StripeService instance = StripeService._();

  Future<void> makePayment(int amount) async {
    try {
      String? paymentIntentClientSecret = await _createPaymentIntent(
        amount,
        'usd',
      );
      if (paymentIntentClientSecret == null) return;
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentClientSecret,
          merchantDisplayName: 'Manuel Walter', /* Nombre de usuario */
        ),
      );
      await _processPayment();
    } catch (e) {
      print(e);
    }
  }

  Future<String?> _createPaymentIntent(int amount, String currency) async {
    try {
      final dio = Dio();
      Map<String, dynamic> data = {
        'amount': _calculateAmount(
          amount,
        ),
        'currency': currency,
      };
      final response = await dio.post(
        'https://api.stripe.com/v1/payment_intents',
        data: data,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {
            'Authorization': 'Bearer ${Environment.stripeSecretKey}',
            'Content-Type': 'application/x-www-form-urlencoded',
          },
        ),
      );
      if (response.data != null) {
        return response.data['client_secret'];
      }
      return null;
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<void> _processPayment() async {
    try {
      await Stripe.instance.presentPaymentSheet();
    } catch (e) {
      print(e);
    }
  }

  String _calculateAmount(int amount) {
    final calculateAmount = amount * 100;
    return calculateAmount.toString();
  }
}
