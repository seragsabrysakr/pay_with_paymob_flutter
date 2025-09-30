import 'payment_intention_response.dart';

/// Unified Checkout Configuration model
class UnifiedCheckoutConfig {
  final String publicKey;
  final String clientSecret;
  final String? title;
  final String? description;

  const UnifiedCheckoutConfig({
    required this.publicKey,
    required this.clientSecret,
    this.title,
    this.description,
  });

  /// Generate Unified Checkout URL
  String get checkoutUrl {
    final uri = Uri.parse('https://accept.paymob.com/unifiedcheckout/');
    return uri.replace(queryParameters: {
      'publicKey': publicKey,
      'clientSecret': clientSecret,
    }).toString();
  }

  /// Create from Payment Intention Response
  factory UnifiedCheckoutConfig.fromPaymentIntention({
    required String publicKey,
    required PaymentIntentionResponse response,
    String? title,
    String? description,
  }) {
    return UnifiedCheckoutConfig(
      publicKey: publicKey,
      clientSecret: response.clientSecret,
      title: title,
      description: description,
    );
  }

  /// Validate configuration
  bool get isValid {
    return publicKey.isNotEmpty && clientSecret.isNotEmpty;
  }

  @override
  String toString() {
    return 'UnifiedCheckoutConfig(publicKey: $publicKey, clientSecret: $clientSecret, title: $title, description: $description)';
  }
}
