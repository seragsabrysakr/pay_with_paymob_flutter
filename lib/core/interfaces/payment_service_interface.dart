import 'package:flutter/material.dart';
import '../../models/billing_data.dart';
import '../../models/paymob_iframe_config.dart';
import '../../models/payment_method_config.dart';
import '../../models/paymob_response.dart';
import '../../models/payment_link_request.dart';

/// Interface for payment service operations
abstract class PaymentServiceInterface {
  /// Initialize the payment service
  Future<bool> initialize({
    required String apiKey,
    required List<PaymentMethodConfig> paymentMethods,
    required List<PaymobIframe> iframes,
    int? defaultIntegrationId,
    int userTokenExpiration,
  });

  /// Pay using a custom payment method
  Future<void> payWithCustomMethod({
    required BuildContext context,
    required PaymentMethodConfig paymentMethod,
    required String currency,
    required double amount,
  
 
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
    /// Create and open payment link (same pattern as other payment methods)
  Future<void> createPayLink({
    required BuildContext context,
    required String apiKey,
    required PaymentLinkRequest request,
    String? imagePath,
    Widget? title,
    Color? appBarColor,
    void Function(PaymentPaymobResponse response)? onPayment,
  });

  /// Get available payment methods
  List<PaymentMethodConfig> get availablePaymentMethods;

  /// Get available iframes
  List<PaymobIframe> get availableIframes;


}
