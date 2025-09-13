class PaymentPaymobResponse {
  bool success;
  String? transactionID;
  String? responseCode;
  String? message;
  int? amountCents;
  String? dataMessage;

  PaymentPaymobResponse(
      {required this.success,
      this.transactionID,
      this.responseCode,
      this.amountCents,
      this.message,
      this.dataMessage});

  factory PaymentPaymobResponse.fromJson(Map<String, dynamic> json) {
    return PaymentPaymobResponse(
      success: json['success']?.toString() == "true",
      transactionID: json['id']?.toString(),
      message: json['message']?.toString() ?? 
          (json['data.message'] != null
              ? Uri.decodeComponent(json['data.message'].toString())
              : ''),
      responseCode: json['txn_response_code']?.toString(),
      amountCents: int.tryParse(json['amount_cents']?.toString() ?? '0') ?? 0,
      dataMessage: json['data.message'] != null
          ? Uri.decodeComponent(json['data.message'].toString())
          : '',
    );
  }

  @override
  String toString() {
    return 'PaymentPaymobResponse(success: $success, transactionID: $transactionID, responseCode: $responseCode, amountCents: $amountCents, message: $message, dataMessage: $dataMessage)';
  }
}
