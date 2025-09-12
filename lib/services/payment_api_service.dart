import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';

import '../core/constants/api_constants.dart';
import '../core/exceptions/paymob_exceptions.dart';
import '../core/interfaces/http_service_interface.dart';
import '../models/billing_data.dart';

/// Service for handling payment API operations
class PaymentApiService {
  final HttpServiceInterface _httpService;
  String? _authToken;
  int? _orderId;

  PaymentApiService(this._httpService);

  /// Get API authentication token
  Future<String> getApiKey(String apiKey) async {
    try {
      final response = await _httpService.post(
        ApiConstants.authorization,
        data: {"api_key": apiKey},
      );

      if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
        _authToken = response.data["token"];
        _httpService.setAuthToken(_authToken!);
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
      final response = await _httpService.post(
        ApiConstants.order,
        data: {
          "auth_token": _authToken,
          "delivery_needed": false,
          "amount_cents": ((amount * 100).round()).toString(),
          "currency": currency,
          "items": []
        },
      );

      if (response.statusCode != null && response.statusCode! >= 200) {
        _orderId = response.data["id"];
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
      final response = await _httpService.post(
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
        return response.data["token"];
      } else {
        throw const PaymentTokenException();
      }
    } catch (e) {
      if (e is PaymobException) rethrow;
      throw const PaymentTokenException('Failed to get payment token');
    }
  }

  /// Request wallet URL
  Future<String> requestWalletUrl({
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
      final response = await _httpService.post(
        ApiConstants.wallet,
        data: requestData,
      );
log('response: $response');
      if (response.statusCode != null && response.statusCode! >= 200) {
        final body = response.data;
        log('redirect_url: ${body["redirect_url"]}');
        log('iframe_redirection_url: ${body["iframe_redirection_url"]}');
        final walletUrl = ((body["redirect_url"] == null || body["redirect_url"].isEmpty)
      
            ? body["iframe_redirection_url"]
            : body["redirect_url"]) ?? body["redirection_url"];
        return walletUrl;
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

  /// Clear authentication data
  void clearAuth() {
    _authToken = null;
    _orderId = null;
    _httpService.clearAuthToken();
  }
}
