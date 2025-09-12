import 'package:flutter/material.dart';
import '../../models/billing_data.dart';
import '../../models/paymob_iframe_config.dart';
import '../../models/paymob_payment_method.dart';
import '../../models/paymob_response.dart';

/// Interface for payment service operations
abstract class PaymentServiceInterface {
  /// Initialize the payment service
  Future<bool> initialize({
    required String apiKey,
    required List<PaymobPaymentMethod> paymentMethods,
    required List<PaymobIframe> iframes,
    int? defaultIntegrationId,
    int userTokenExpiration,
  });

  /// Pay using a custom payment method
  Future<void> payWithCustomMethod({
    required BuildContext context,
    required PaymobPaymentMethod paymentMethod,
    required String currency,
    required double amount,
    String? identifier,
    String? customSubtype,
    Widget? title,
    Color? appBarColor,
    void Function(PaymentPaymobResponse response)? onPayment,
    BillingData? billingData,
  });

  /// Pay using an iframe
  Future<void> payWithIframe({
    required BuildContext context,
    required PaymobIframe iframe,
    required String currency,
    required double amount,
    Widget? title,
    Color? appBarColor,
    void Function(PaymentPaymobResponse response)? onPayment,
    BillingData? billingData,
  });

  /// Get available payment methods
  List<PaymobPaymentMethod> get availablePaymentMethods;

  /// Get available iframes
  List<PaymobIframe> get availableIframes;
}
