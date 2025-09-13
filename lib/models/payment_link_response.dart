/// Model for payment link creation response
class PaymentLinkResponse {
  /// Payment link ID
  final int id;
  
  /// Currency code
  final String? currency;
  
  /// Client information
  final ClientInfo clientInfo;
  
  /// Reference ID
  final String? referenceId;
  
  /// Amount in cents
  final int amountCents;
  
  /// Payment state
  final String state;
  
  /// Payment description
  final String? description;
  
  /// Creation timestamp
  final DateTime createdAt;
  
  /// Expiration timestamp
  final DateTime? expiresAt;
  
  /// Payment completion timestamp (null if not paid)
  final DateTime? paidAt;
  
  /// Client URL for payment
  final String clientUrl;
  
  /// Origin identifier
  final int origin;
  
  /// Merchant staff tag
  final String? merchantStaffTag;
  
  /// Payment link image URL
  final String? paymentLinkImage;
  
  /// Order ID
  final int order;

  const PaymentLinkResponse({
    required this.id,
    this.currency,
    required this.clientInfo,
    this.referenceId,
    required this.amountCents,
    required this.state,
    this.description,
    required this.createdAt,
    this.expiresAt,
    this.paidAt,
    required this.clientUrl,
    required this.origin,
    this.merchantStaffTag,
    this.paymentLinkImage,
    required this.order,
  });

  /// Create PaymentLinkResponse from JSON
  factory PaymentLinkResponse.fromJson(Map<String, dynamic> json) {
    return PaymentLinkResponse(
      id: json['id'] as int,
      currency: json['currency'] as String?,
      clientInfo: ClientInfo.fromJson(json['client_info'] as Map<String, dynamic>),
      referenceId: json['reference_id'] as String?,
      amountCents: json['amount_cents'] as int,
      state: json['state'] as String,
      description: json['description'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      expiresAt: json['expires_at'] != null ? DateTime.parse(json['expires_at'] as String) : null,
      paidAt: json['paid_at'] != null ? DateTime.parse(json['paid_at'] as String) : null,
      clientUrl: json['client_url'] as String,
      origin: json['origin'] as int,
      merchantStaffTag: json['merchant_staff_tag'] as String?,
      paymentLinkImage: json['payment_link_image'] as String?,
      order: json['order'] as int,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'currency': currency,
      'client_info': clientInfo.toJson(),
      'reference_id': referenceId,
      'amount_cents': amountCents,
      'state': state,
      'description': description,
      'created_at': createdAt.toIso8601String(),
      'expires_at': expiresAt?.toIso8601String(),
      'paid_at': paidAt?.toIso8601String(),
      'client_url': clientUrl,
      'origin': origin,
      'merchant_staff_tag': merchantStaffTag,
      'payment_link_image': paymentLinkImage,
      'order': order,
    };
  }

  /// Check if payment is completed
  bool get isPaid => paidAt != null;

  /// Check if payment link is expired
  bool get isExpired => expiresAt != null && DateTime.now().isAfter(expiresAt!);

  /// Get amount in currency units
  double get amount => amountCents / 100.0;

  @override
  String toString() {
    return 'PaymentLinkResponse(id: $id, referenceId: $referenceId, amountCents: $amountCents, state: $state, clientUrl: $clientUrl, isPaid: $isPaid, isExpired: $isExpired)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PaymentLinkResponse &&
        other.id == id &&
        other.currency == currency &&
        other.clientInfo == clientInfo &&
        other.referenceId == referenceId &&
        other.amountCents == amountCents &&
        other.state == state &&
        other.description == description &&
        other.createdAt == createdAt &&
        other.expiresAt == expiresAt &&
        other.paidAt == paidAt &&
        other.clientUrl == clientUrl &&
        other.origin == origin &&
        other.merchantStaffTag == merchantStaffTag &&
        other.paymentLinkImage == paymentLinkImage &&
        other.order == order;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      currency,
      clientInfo,
      referenceId,
      amountCents,
      state,
      description,
      createdAt,
      expiresAt,
      paidAt,
      clientUrl,
      origin,
      merchantStaffTag,
      paymentLinkImage,
      order,
    );
  }
}

/// Client information model
class ClientInfo {
  /// Full name
  final String fullName;
  
  /// Email address
  final String email;
  
  /// Phone number
  final String phoneNumber;

  const ClientInfo({
    required this.fullName,
    required this.email,
    required this.phoneNumber,
  });

  /// Create ClientInfo from JSON
  factory ClientInfo.fromJson(Map<String, dynamic> json) {
    return ClientInfo(
      fullName: json['full_name'] as String,
      email: json['email'] as String,
      phoneNumber: json['phone_number'] as String,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'full_name': fullName,
      'email': email,
      'phone_number': phoneNumber,
    };
  }

  @override
  String toString() {
    return 'ClientInfo(fullName: $fullName, email: $email, phoneNumber: $phoneNumber)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ClientInfo &&
        other.fullName == fullName &&
        other.email == email &&
        other.phoneNumber == phoneNumber;
  }

  @override
  int get hashCode {
    return Object.hash(fullName, email, phoneNumber);
  }
}
