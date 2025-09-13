import 'dart:developer';
import 'dart:io';

import '../core/constants/api_constants.dart';
import '../core/exceptions/paymob_exceptions.dart';
import '../core/interfaces/api_service_interface.dart';
import '../models/billing_data.dart';
import '../models/payment_link_request.dart';
import '../models/payment_link_response.dart';

/// Service for handling payment API operations
class PaymentApiService {
  final ApiServiceInterface _apiService;
  String? _authToken;
  int? _orderId;

  PaymentApiService(this._apiService);

  /// Get API authentication token
  Future<String> getAuthenticationToken(String apiKey) async {
    try {
      final response = await _apiService.post<Map<String, dynamic>>(
        ApiConstants.authorization,
        data: {"api_key": apiKey},
      );

      if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
        _authToken = response.data?["token"]?.toString();
        _apiService.setAuthToken(_authToken!);
        return _authToken!;
      } else {
        throw const InvalidApiKeyException();
      }
    } catch (e) {
      if (e is PaymobException) rethrow;
      throw const InvalidApiKeyException('Failed to authenticate with Paymob API');
    }
  }

  /// Create a new order
  Future<int> createOrder(double amount, String currency) async {
    if (_authToken == null) {
      throw const PaymentInitializationException('Authentication token not available');
    }

    try {
      final response = await _apiService.post<Map<String, dynamic>>(
        ApiConstants.order,
        data: {
          "auth_token": _authToken,
          "delivery_needed": false,
          "amount_cents": ((amount * 100).round()).toString(),
          "currency": currency,
          "items": <Map<String, dynamic>>[]
        },
      );

      if (response.statusCode != null && response.statusCode! >= 200) {
        _orderId = int.tryParse(response.data?["id"]?.toString() ?? '0');
        return _orderId!;
      } else {
        throw const OrderCreationException();
      }
    } catch (e) {
      if (e is PaymobException) rethrow;
      throw const OrderCreationException('Failed to create order');
    }
  }

  /// Request payment token
  Future<String> requestPaymentToken({
    required double amount,
    required String currency,
    required String integrationId,
    required BillingData billingData,
    int userTokenExpiration = ApiConstants.defaultUserTokenExpiration,
  }) async {
    if (_authToken == null || _orderId == null) {
      throw const PaymentInitializationException('Order not created or token not available');
    }

    try {
      final response = await _apiService.post<Map<String, dynamic>>(
        ApiConstants.keys,
        data: {
          "auth_token": _authToken,
          "expiration": userTokenExpiration,
          "amount_cents": ((amount * 100).round()).toString(),
          "order_id": _orderId,
          "billing_data": billingData.toJson(),
          "currency": currency,
          "integration_id": integrationId,
          "lock_order_when_paid": false
        },
      );

      if (response.statusCode != null && response.statusCode! >= 200) {
        return response.data?["token"]?.toString() ?? '';
      } else {
        throw const PaymentTokenException();
      }
    } catch (e) {
      if (e is PaymobException) rethrow;
      throw const PaymentTokenException('Failed to get payment token');
    }
  }

  /// Request wallet URL
  Future<String> requestPayUrl({
    required String paymentToken,
    String? identifier,
    String? subtype,
  }) async {
    try {
      final requestData = <String, dynamic>{
        "payment_token": paymentToken,
      };

      if (identifier != null || subtype != null) {
        requestData["source"] = <String, dynamic>{};
        if (identifier != null) {
          requestData["source"]["identifier"] = identifier;
        }
        if (subtype != null) {
          requestData["source"]["subtype"] = subtype;
        }
      }
log('requestData: $requestData');
      final response = await _apiService.post<Map<String, dynamic>>(
        ApiConstants.wallet,
        data: requestData,
      );
log('response: $response');
      if (response.statusCode != null && response.statusCode! >= 200) {
        final body = response.data;
        log('redirect_url: ${body?["redirect_url"]}');
        log('iframe_redirection_url: ${body?["iframe_redirection_url"]}');
        final redirectUrl = body?["redirect_url"]?.toString();
        final iframeUrl = body?["iframe_redirection_url"]?.toString();
        final redirectionUrl = body?["redirection_url"]?.toString();
        
        final walletUrl = (redirectUrl == null || redirectUrl.isEmpty)
            ? iframeUrl
            : redirectUrl;
        
        return walletUrl ?? redirectionUrl ?? '';
      } else {
        throw const WalletUrlException();
      }
    } catch (e, stackTrace) {
      if (e is PaymobException) rethrow;
      log('error: $e');
      log('stackTrace: $stackTrace');
      throw   WalletUrlException('Failed to get wallet URL $e $stackTrace');
    }
  }

  

  /// Create a payment link
  Future<PaymentLinkResponse> createPaymentLink({
    required PaymentLinkRequest request,
    String? imagePath,
  }) async {
    if (_authToken == null) {
      throw const PaymentInitializationException('Authentication token not available. Please authenticate first.');
    }

    try {
      // Prepare form data
      final formData = request.toFormData();

      // Add image file if provided
      Map<String, dynamic>? files;
      if (imagePath != null && imagePath.isNotEmpty) {
        final file = File(imagePath);
        if (await file.exists()) {
          files = {
            'payment_link_image': file,
          };
        }
      }

      log('Creating payment link with data: $formData');
      
      final response = await _apiService.postMultipart<Map<String, dynamic>>(
        ApiConstants.paymentLinks,
        fields: formData,
        files: files,
      );

      log('Payment link response: $response');

      if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
        return PaymentLinkResponse.fromJson(response.data!);
      } else {
        throw const PaymentLinkException('Failed to create payment link');
      }
    } catch (e) {
      if (e is PaymobException) rethrow;
      log('Error creating payment link: $e');
      throw const PaymentLinkException('Failed to create payment link');
    }
  }

 

  
  /// Clear authentication data
  void clearAuth() {
    _authToken = null;
    _orderId = null;
    _apiService.clearAuthToken();
  }
}
