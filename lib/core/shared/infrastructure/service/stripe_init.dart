import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:ecofriendly_flutter_app/core/core.dart';

class StripeInit {
  static Future<void> init() async {
    Stripe.publishableKey = Environment.stripePublishableKey;
  }
}
