import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import '../../../../core/core.dart';
import '../../../../core/shared/shared.dart';

class StripeServiceNotifier extends StateNotifier<String?> {
  final KeyValueStorageService keyValueStorageService;
  StripeServiceNotifier({
    required this.keyValueStorageService,
  }) : super(null);

  Future<void> makePayment(int amount, String currency) async {
    try {
      final userId = await keyValueStorageService.getValue<String>('id');
      final paymentIntentClientSecret =
          await _createPaymentIntent(amount, currency);

      if (paymentIntentClientSecret == null) {
        _showError("Error al crear el pago. Inténtalo nuevamente.");
        return;
      }
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentClientSecret,
          merchantDisplayName: userId,
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
      if (response.statusCode == 200 && response.data != null) {
        return response.data['client_secret'];
      } else {
        print('Error en la respuesta de Stripe: ${response.data}');
        _showError("Error de comunicación con Stripe.");
        return null;
      }
    } catch (e) {
      print('Error => $e');
      _showError("Hubo un problema al contactar con Stripe.");
      return null;
    }
  }

  Future<void> _processPayment() async {
    try {
      await Stripe.instance.presentPaymentSheet();
    } catch (e) {
      print(e);
      _showError("Error al procesar el pago. Inténtalo nuevamente.");
    }
  }

  String _calculateAmount(int amount) {
    final calculateAmount = amount * 100;
    return calculateAmount.toString();
  } // Función para mostrar un error al usuario

  void _showError(String message) {
    // Aquí podrías implementar un `SnackBar` o un `AlertDialog` para mostrar el error.
    print(message); // Solo para fines de depuración
  }
}

final stripeServiceProvider =
    StateNotifierProvider<StripeServiceNotifier, String?>((ref) {
  final keyValueStorageService = KeyValueStorageImpl();
  return StripeServiceNotifier(
    keyValueStorageService: keyValueStorageService,
  );
});
