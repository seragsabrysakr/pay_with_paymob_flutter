import 'paymob_payment_method.dart';

/// Configuration class for payment methods with their identifiers
class PaymentMethodConfig {
  /// The payment method
  final PaymobPaymentMethod paymentMethod;
  
  /// The identifier for this payment method
  final String identifier;
  
  /// The integration ID for this payment method
  final int integrationId;
  
  /// Optional custom subtype for this payment method
  final String? customSubtype;
  
  /// Optional display name override
  final String? displayName;
  
  /// Optional description override
  final String? description;

  const PaymentMethodConfig({
    required this.paymentMethod,
    required this.identifier,
    required this.integrationId,
    this.customSubtype,
    this.displayName,
    this.description,
  });

  /// Create a PaymentMethodConfig with default identifier
  factory PaymentMethodConfig.withDefault({
    required PaymobPaymentMethod paymentMethod,
    required int integrationId,
    String? customSubtype,
    String? displayName,
    String? description,
  }) {
    return PaymentMethodConfig(
      paymentMethod: paymentMethod,
      identifier: paymentMethod.defaultIdentifier,
      integrationId: integrationId,
      customSubtype: customSubtype,
      displayName: displayName,
      description: description,
    );
  }

  /// Create a PaymentMethodConfig with custom identifier
  factory PaymentMethodConfig.custom({
    required PaymobPaymentMethod paymentMethod,
    required String identifier,
    required int integrationId,
    String? customSubtype,
    String? displayName,
    String? description,
  }) {
    return PaymentMethodConfig(
      paymentMethod: paymentMethod,
      identifier: identifier,
      integrationId: integrationId,
      customSubtype: customSubtype,
      displayName: displayName,
      description: description,
    );
  }

  @override
  String toString() {
    return 'PaymentMethodConfig(paymentMethod: $paymentMethod, identifier: $identifier, integrationId: $integrationId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PaymentMethodConfig &&
        other.paymentMethod == paymentMethod &&
        other.identifier == identifier &&
        other.integrationId == integrationId &&
        other.customSubtype == customSubtype;
  }

  @override
  int get hashCode {
    return paymentMethod.hashCode ^
        identifier.hashCode ^
        integrationId.hashCode ^
        customSubtype.hashCode;
  }
}
