import 'paymob_payment_method.dart';

/// Configuration class for payment methods with their identifiers
class PaymentMethodConfig {
  /// The payment method
  final PaymobPaymentMethod paymentMethod;
  
  /// The identifier for this payment method (can be int or string)
  final String identifier;
  
  /// Integration ID as string
  final String integrationId;
  
  /// Custom subtype for this payment method
  final String customSubtype;
  
  /// Display name for this payment method
  final String displayName;
  
  /// Description for this payment method
  final String description;

  const PaymentMethodConfig({
    required this.paymentMethod,
    required this.identifier,
    required this.integrationId,
    required this.customSubtype,
    required this.displayName,
    required this.description,
  });

  @override
  String toString() {
    return 'PaymentMethodConfig(paymentMethod: $paymentMethod, identifier: $identifier, customSubtype: $customSubtype)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PaymentMethodConfig &&
        other.paymentMethod == paymentMethod &&
        other.identifier == identifier &&
        other.integrationId == integrationId &&
        other.customSubtype == customSubtype &&
        other.displayName == displayName &&
        other.description == description;
  }

  @override
  int get hashCode {
    return paymentMethod.hashCode ^
        identifier.hashCode ^
        integrationId.hashCode ^
        customSubtype.hashCode ^
        displayName.hashCode ^
        description.hashCode;
  }
}
