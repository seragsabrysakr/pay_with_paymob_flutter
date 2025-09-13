/// Model for payment link creation request
class PaymentLinkRequest {
  /// Amount in cents
  final int amountCents;
  
  /// Payment methods (integration IDs)
  final List<int> paymentMethods;
  
  /// Customer email
  final String email;
  
  /// Customer full name
  final String fullName;
  
  /// Customer phone number
  final String phoneNumber;
  
  /// Payment description
  final String? description;
  
  /// Whether this is a live payment (true) or test (false)
  final bool isLive;
  
  /// Payment link image file path (optional)
  final String? paymentLinkImage;
  
  /// Reference ID for tracking (optional)
  final String? referenceId;

  const PaymentLinkRequest({
    required this.amountCents,
    required this.paymentMethods,
    required this.email,
    required this.fullName,
    required this.phoneNumber,
    this.description,
    this.isLive = true,
    this.paymentLinkImage,
    this.referenceId,
  });

  /// Create PaymentLinkRequest from amount in currency units
  factory PaymentLinkRequest.fromAmount({
    required double amount,
    required List<int> paymentMethods,
    required String email,
    required String fullName,
    required String phoneNumber,
    String? description,
    bool isLive = true,
    String? paymentLinkImage,
    String? referenceId,
  }) {
    return PaymentLinkRequest(
      amountCents: (amount * 100).round(),
      paymentMethods: paymentMethods,
      email: email,
      fullName: fullName,
      phoneNumber: phoneNumber,
      description: description,
      isLive: isLive,
      paymentLinkImage: paymentLinkImage,
      referenceId: referenceId,
    );
  }

  /// Convert to JSON for API request
  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{
      'amount_cents': amountCents.toString(),
      'payment_methods': paymentMethods.join(','),
      'email': email,
      'is_live': isLive.toString(),
      'full_name': fullName,
      'phone_number': phoneNumber,
    };

    if (description != null) {
      json['description'] = description;
    }

    if (referenceId != null) {
      json['reference_id'] = referenceId;
    }

    return json;
  }

  /// Convert to form data for multipart request
  Map<String, String> toFormData() {
    final formData = <String, String>{
      'amount_cents': amountCents.toString(),
      'payment_methods': paymentMethods.join(','),
      'email': email,
      'is_live': isLive.toString(),
      'full_name': fullName,
      'phone_number': phoneNumber,
    };

    if (description != null) {
      formData['description'] = description!;
    }

    if (referenceId != null) {
      formData['reference_id'] = referenceId!;
    }

    return formData;
  }

  @override
  String toString() {
    return 'PaymentLinkRequest(amountCents: $amountCents, paymentMethods: $paymentMethods, email: $email, fullName: $fullName, phoneNumber: $phoneNumber, description: $description, isLive: $isLive, referenceId: $referenceId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PaymentLinkRequest &&
        other.amountCents == amountCents &&
        other.paymentMethods.toString() == paymentMethods.toString() &&
        other.email == email &&
        other.fullName == fullName &&
        other.phoneNumber == phoneNumber &&
        other.description == description &&
        other.isLive == isLive &&
        other.paymentLinkImage == paymentLinkImage &&
        other.referenceId == referenceId;
  }

  @override
  int get hashCode {
    return Object.hash(
      amountCents,
      paymentMethods,
      email,
      fullName,
      phoneNumber,
      description,
      isLive,
      paymentLinkImage,
      referenceId,
    );
  }
}
