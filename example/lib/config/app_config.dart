import 'package:pay_with_paymob_flutter/models/payment_method_config.dart';
import 'package:pay_with_paymob_flutter/models/paymob_iframe_config.dart';

/// Application configuration class for Paymob Unified Checkout
class AppConfig {
  final String apiKey;
  final String publicKey;
  final String secretKey;
  final List<PaymentMethodConfig> paymentMethods;
  final List<PaymobIframe> iframes;
  final int defaultIntegrationId;

  const AppConfig({
    required this.apiKey,
    required this.publicKey,
    required this.secretKey,
    required this.paymentMethods,
    required this.iframes,
    required this.defaultIntegrationId,
  });
}
