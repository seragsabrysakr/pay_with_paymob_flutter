/// Represents a Paymob iframe configuration
class PaymobIframe {
  /// The iframe ID from Paymob dashboard
  final int iframeId;
  
  /// The integration ID for this iframe
  final int integrationId;
  
  /// Optional name for the iframe (for reference)
  final String? name;
  
  /// Optional description for the iframe
  final String? description;

  /// Constructs a [PaymobIframe] object with the provided data.
  PaymobIframe({
    required this.iframeId,
    required this.integrationId,
    this.name,
    this.description,
  });

  /// Converts the [PaymobIframe] object into a [Map<String, dynamic>] for JSON serialization.
  Map<String, dynamic> toJson() {
    return {
      "iframe_id": iframeId,
      "integration_id": integrationId,
      "name": name,
      "description": description,
    };
  }

  /// Creates a [PaymobIframe] from a JSON map.
  factory PaymobIframe.fromJson(Map<String, dynamic> json) {
    return PaymobIframe(
      iframeId: json["iframe_id"],
      integrationId: json["integration_id"],
      name: json["name"],
      description: json["description"],
    );
  }

  @override
  String toString() {
    return 'PaymobIframe(iframeId: $iframeId, integrationId: $integrationId, name: $name, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PaymobIframe &&
        other.iframeId == iframeId &&
        other.integrationId == integrationId;
  }

  @override
  int get hashCode => iframeId.hashCode ^ integrationId.hashCode;
}
