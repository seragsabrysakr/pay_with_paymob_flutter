import 'billing_data.dart';

/// Payment Intention Request model for Paymob Unified Checkout
class PaymentIntentionRequest {
  final int amount;
  final String? specialReference;
  final String currency;
  final List<int> paymentMethods;
  final List<Map<String, dynamic>> items;
  final BillingData billingData;
  final CustomerData customer;
  final Map<String, dynamic>? extras;

  const PaymentIntentionRequest({
    required this.amount,
    this.specialReference,
    required this.currency,
    required this.paymentMethods,
    this.items = const [],
    required this.billingData,
    required this.customer,
    this.extras,
  });

  /// Convert to JSON for API request
  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      if (specialReference != null) 'special_reference': specialReference,
      'currency': currency,
      'payment_methods': paymentMethods,
      'items': items,
      'billing_data': billingData.toJson(),
      'customer': customer.toJson(),
      if (extras != null) 'extras': extras,
    };
  }

  /// Create from amount and basic data
  factory PaymentIntentionRequest.create({
    required double amount,
    required String currency,
    required List<int> paymentMethodIntegrationIds,
    required BillingData billingData,
    required CustomerData customer,
    String? specialReference,
    List<Map<String, dynamic>>? items,
    Map<String, dynamic>? extras,
  }) {
    return PaymentIntentionRequest(
      amount: (amount * 100).round(), // Convert to cents
      specialReference: specialReference,
      currency: currency,
      paymentMethods: paymentMethodIntegrationIds,
      items: items ?? [],
      billingData: billingData,
      customer: customer,
      extras: extras,
    );
  }
}

/// Customer data for Payment Intention
class CustomerData {
  final String firstName;
  final String lastName;
  final String email;
  final Map<String, dynamic>? extras;

  const CustomerData({
    required this.firstName,
    required this.lastName,
    required this.email,
    this.extras,
  });

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      if (extras != null) 'extras': extras,
    };
  }

  /// Create from billing data
  factory CustomerData.fromBillingData(BillingData billingData, {Map<String, dynamic>? extras}) {
    return CustomerData(
      firstName: billingData.firstName ?? 'Unidentified',
      lastName: billingData.lastName ?? 'Unidentified',
      email: billingData.email ?? 'Unidentified',
      extras: extras,
    );
  }
}
