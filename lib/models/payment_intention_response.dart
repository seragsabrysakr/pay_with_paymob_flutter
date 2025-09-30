import 'billing_data.dart';

/// Payment Intention Response model for Paymob Unified Checkout
class PaymentIntentionResponse {
  final List<PaymentKey> paymentKeys;
  final int intentionOrderId;
  final String id;
  final IntentionDetail intentionDetail;
  final String clientSecret;
  final List<PaymentMethod> paymentMethods;
  final String? specialReference;
  final ExtrasData extras;
  final bool confirmed;
  final String status;
  final String created;
  final dynamic cardDetail;
  final List<dynamic> cardTokens;
  final String object;

  const PaymentIntentionResponse({
    required this.paymentKeys,
    required this.intentionOrderId,
    required this.id,
    required this.intentionDetail,
    required this.clientSecret,
    required this.paymentMethods,
    this.specialReference,
    required this.extras,
    required this.confirmed,
    required this.status,
    required this.created,
    this.cardDetail,
    required this.cardTokens,
    required this.object,
  });

  /// Create from JSON response
  factory PaymentIntentionResponse.fromJson(Map<String, dynamic> json) {
    return PaymentIntentionResponse(
      paymentKeys: (json['payment_keys'] as List<dynamic>?)
          ?.map((e) => PaymentKey.fromJson(e as Map<String, dynamic>))
          .toList() ?? [],
      intentionOrderId: json['intention_order_id'] as int? ?? 0,
      id: json['id'] as String? ?? '',
      intentionDetail: IntentionDetail.fromJson(json['intention_detail'] as Map<String, dynamic>? ?? {}),
      clientSecret: json['client_secret'] as String? ?? '',
      paymentMethods: (json['payment_methods'] as List<dynamic>?)
          ?.map((e) => PaymentMethod.fromJson(e as Map<String, dynamic>))
          .toList() ?? [],
      specialReference: json['special_reference'] as String?,
      extras: ExtrasData.fromJson(json['extras'] as Map<String, dynamic>? ?? {}),
      confirmed: json['confirmed'] as bool? ?? false,
      status: json['status'] as String? ?? '',
      created: json['created'] as String? ?? '',
      cardDetail: json['card_detail'],
      cardTokens: json['card_tokens'] as List<dynamic>? ?? [],
      object: json['object'] as String? ?? '',
    );
  }
}

/// Payment Key model
class PaymentKey {
  final int integration;
  final String key;
  final String? gatewayType;
  final int? iframeId;
  final int orderId;
  final String? redirectionUrl;
  final bool saveCard;

  const PaymentKey({
    required this.integration,
    required this.key,
    this.gatewayType,
    this.iframeId,
    required this.orderId,
    this.redirectionUrl,
    required this.saveCard,
  });

  factory PaymentKey.fromJson(Map<String, dynamic> json) {
    return PaymentKey(
      integration: json['integration'] as int? ?? 0,
      key: json['key'] as String? ?? '',
      gatewayType: json['gateway_type'] as String?,
      iframeId: json['iframe_id'] as int?,
      orderId: json['order_id'] as int? ?? 0,
      redirectionUrl: json['redirection_url'] as String?,
      saveCard: json['save_card'] as bool? ?? false,
    );
  }
}

/// Intention Detail model
class IntentionDetail {
  final int amount;
  final List<dynamic> items;
  final String currency;
  final BillingData billingData;

  const IntentionDetail({
    required this.amount,
    required this.items,
    required this.currency,
    required this.billingData,
  });

  factory IntentionDetail.fromJson(Map<String, dynamic> json) {
    final billingDataJson = json['billing_data'] as Map<String, dynamic>? ?? {};
    return IntentionDetail(
      amount: json['amount'] as int? ?? 0,
      items: json['items'] as List<dynamic>? ?? [],
      currency: json['currency'] as String? ?? '',
      billingData: BillingData(
        email: billingDataJson['email'] as String?,
        firstName: billingDataJson['first_name'] as String?,
        lastName: billingDataJson['last_name'] as String?,
        phoneNumber: billingDataJson['phone_number'] as String?,
        apartment: billingDataJson['apartment'] as String?,
        building: billingDataJson['building'] as String?,
        street: billingDataJson['street'] as String?,
        postalCode: billingDataJson['postal_code'] as String?,
        city: billingDataJson['city'] as String?,
        state: billingDataJson['state'] as String?,
        country: billingDataJson['country'] as String?,
        floor: billingDataJson['floor'] as String?,
        shippingMethod: billingDataJson['shipping_method'] as String?,
      ),
    );
  }
}

/// Payment Method model
class PaymentMethod {
  final int integrationId;
  final String? alias;
  final String name;
  final String methodType;
  final String currency;
  final bool live;
  final bool useCvcWithMoto;

  const PaymentMethod({
    required this.integrationId,
    this.alias,
    required this.name,
    required this.methodType,
    required this.currency,
    required this.live,
    required this.useCvcWithMoto,
  });

  factory PaymentMethod.fromJson(Map<String, dynamic> json) {
    return PaymentMethod(
      integrationId: json['integration_id'] as int? ?? 0,
      alias: json['alias'] as String?,
      name: json['name'] as String? ?? '',
      methodType: json['method_type'] as String? ?? '',
      currency: json['currency'] as String? ?? '',
      live: json['live'] as bool? ?? false,
      useCvcWithMoto: json['use_cvc_with_moto'] as bool? ?? false,
    );
  }
}

/// Extras Data model
class ExtrasData {
  final Map<String, dynamic>? creationExtras;
  final Map<String, dynamic>? confirmationExtras;

  const ExtrasData({
    this.creationExtras,
    this.confirmationExtras,
  });

  factory ExtrasData.fromJson(Map<String, dynamic> json) {
    return ExtrasData(
      creationExtras: json['creation_extras'] as Map<String, dynamic>?,
      confirmationExtras: json['confirmation_extras'] as Map<String, dynamic>?,
    );
  }
}
