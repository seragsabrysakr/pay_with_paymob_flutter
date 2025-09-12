/// 🚀 Paymob Flutter SDK
/// 
/// The most comprehensive and developer-friendly Paymob payment integration 
/// for Flutter applications. Supports all Paymob payment methods, iframes, 
/// multi-environment configurations, and clean architecture.
/// 
/// ## Features
/// 
/// - **🔧 Easy Integration** - Simple setup with comprehensive configuration management
/// - **🌍 Multi-Environment Support** - Separate configurations for test and live environments
/// - **💳 Multiple Payment Methods** - Support for all Paymob payment methods
/// - **🖼️ Iframe Integration** - Built-in iframe support for web-based payments
/// - **🔒 Secure** - Follows security best practices and Paymob guidelines
/// - **📱 Cross-Platform** - Works on iOS, Android, Web, and Desktop
/// 
/// ## Quick Start
/// 
/// ```dart
/// import 'package:pay_with_paymob_flutter/paymob_flutter.dart';
/// 
/// void main() {
///   WidgetsFlutterBinding.ensureInitialized();
///   
///   PaymobFlutter.instance.initialize(
///     apiKey: "your_api_key",
///     paymentMethods: [PaymobPaymentMethod.valu],
///     iframes: [PaymobIframe(iframeId: 123, integrationId: 456)],
///   );
///   
///   runApp(MyApp());
/// }
/// ```
/// 
/// ## Payment Processing
/// 
/// ```dart
/// PaymobFlutter.instance.payWithCustomMethod(
///   context: context,
///   paymentMethod: PaymobPaymentMethod.valu,
///   currency: "EGP",
///   amount: 100.0,
///   onPayment: (response) {
///     if (response.success) {
///       print("Payment successful!");
///     }
///   },
/// );
/// ```
/// 
/// ## Environment Configuration
/// 
/// ```dart
/// // Set environment
/// ConfigManager.setEnvironment(Environment.live);
/// 
/// // Get configuration
/// final config = ConfigManager.currentConfig;
/// 
/// // Initialize with configuration
/// PaymobFlutter.instance.initializeWithConfig(
///   apiKey: config.apiKey,
///   paymentMethods: config.paymentMethods,
///   iframes: config.iframes,
///   defaultIntegrationId: config.defaultIntegrationId,
/// );
/// ```
/// 
/// For more information, see the [README](https://github.com/seragsabrysakr/pay_with_paymob_flutter).
library pay_with_paymob_flutter;

import 'package:flutter/material.dart';
import 'package:pay_with_paymob_flutter/core/interfaces/http_service_interface.dart';
import 'core/exceptions/paymob_exceptions.dart';
import 'core/interfaces/payment_service_interface.dart';
import 'core/services/http_service.dart';
import 'models/billing_data.dart';
import 'models/paymob_iframe_config.dart';
import 'models/paymob_payment_method.dart';
import 'models/paymob_response.dart';
import 'models/payment_method_config.dart';
import 'services/payment_api_service.dart';
import 'ui/widgets/paymob_iframe.dart';

// Export all public classes
export 'models/billing_data.dart';
export 'models/paymob_iframe_config.dart';
export 'models/paymob_payment_method.dart';
export 'models/paymob_response.dart';
export 'models/payment_method_config.dart';

/// Main Paymob Flutter payment service
/// 
/// This class follows SOLID principles:
/// - Single Responsibility: Handles payment operations only
/// - Open/Closed: Extensible through interfaces
/// - Liskov Substitution: Implements PaymentServiceInterface
/// - Interface Segregation: Uses focused interfaces
/// - Dependency Inversion: Depends on abstractions, not concretions
class PaymobFlutter implements PaymentServiceInterface {
  static PaymobFlutter? _instance;
  static PaymobFlutter get instance => _instance ??= PaymobFlutter._internal();
  
  PaymobFlutter._internal();

  // Dependencies (Dependency Inversion Principle)
  late final ApiServiceInterface _httpService;
  late final PaymentApiService _paymentApiService;
  
  // Configuration
  String? _apiKey;
  List<PaymentMethodConfig> _availablePaymentMethods = [];
  List<PaymobIframe> _availableIframes = [];
  int? _defaultIntegrationId;
  int _userTokenExpiration = 3600;
  bool _isInitialized = false;

  /// Initialize with PaymentMethodConfig list (recommended)
  Future<bool> initializeWithConfig({
    required String apiKey,
    required List<PaymentMethodConfig> paymentMethods,
    required List<PaymobIframe> iframes,
    int? defaultIntegrationId,
    int userTokenExpiration = 3600,
  }) async {
    if (_isInitialized) return true;

    // Validate inputs
    if (apiKey.isEmpty) {
      throw const InvalidApiKeyException('API key cannot be empty');
    }
    if (paymentMethods.isEmpty) {
      throw const PaymentInitializationException('At least one payment method must be provided');
    }
    if (iframes.isEmpty) {
      throw const PaymentInitializationException('At least one iframe must be provided');
    }

    // Initialize dependencies
    _httpService = HttpService();
    _paymentApiService = PaymentApiService(_httpService);

    // Store configuration
    _apiKey = apiKey;
    _availablePaymentMethods = List.from(paymentMethods);
    _availableIframes = List.from(iframes);
    _defaultIntegrationId = defaultIntegrationId ?? iframes.first.integrationId;
    _userTokenExpiration = userTokenExpiration;

    _isInitialized = true;
    return true;
  }

  @override
  Future<bool> initialize({
    required String apiKey,
    required List<PaymobPaymentMethod> paymentMethods,
    required List<PaymobIframe> iframes,
    int? defaultIntegrationId,
    int userTokenExpiration = 3600,
  }) async {
    // Convert PaymobPaymentMethod list to PaymentMethodConfig list with default identifiers
    final paymentMethodConfigs = paymentMethods
        .map((method) => PaymentMethodConfig.withDefault(
          paymentMethod: method, 
          integrationId: defaultIntegrationId ?? iframes.first.integrationId,
        ))
        .toList();
    
    return initializeWithConfig(
      apiKey: apiKey,
      paymentMethods: paymentMethodConfigs,
      iframes: iframes,
      defaultIntegrationId: defaultIntegrationId,
      userTokenExpiration: userTokenExpiration,
    );
  }

  @override
  List<PaymobPaymentMethod> get availablePaymentMethods => 
      _availablePaymentMethods.map((config) => config.paymentMethod).toList();
  
  /// Get available payment method configurations with their identifiers
  List<PaymentMethodConfig> get availablePaymentMethodConfigs => 
      List.from(_availablePaymentMethods);

  @override
  List<PaymobIframe> get availableIframes => List.from(_availableIframes);

  @override
  Future<void> payWithCustomMethod({
    required BuildContext context,
    required PaymobPaymentMethod paymentMethod,
    required String currency,
    required double amount,
    String? identifier,
    String? customSubtype,
    Widget? title,
    Color? appBarColor,
    void Function(PaymentPaymobResponse response)? onPayment,
    BillingData? billingData,
  }) async {
    _validateInitialization();
    _validatePaymentMethod(paymentMethod);

    try {
      // Get API key
      await _paymentApiService.getApiKey(_apiKey!);
      
      // Create order
      await _paymentApiService.createOrder(amount, currency);
      
      // Request payment token
      final config = _getPaymentMethodConfig(paymentMethod);
      final integrationId = config?.integrationId ?? _defaultIntegrationId!;
      final paymentToken = await _paymentApiService.requestPaymentToken(
        amount: amount,
        currency: currency,
        integrationId: integrationId.toString(),
        billingData: billingData ?? BillingData(),
        userTokenExpiration: _userTokenExpiration,
      );
      
      // Request wallet URL
      final subtype = customSubtype ?? config?.customSubtype ?? paymentMethod.subtype;
      final finalIdentifier = integrationId.toString();
      final payUrl = await _paymentApiService.requestPayUrl(
        paymentToken: paymentToken,
        identifier: finalIdentifier,
        subtype: subtype,
      );
      debugPrint('walletUrl: $payUrl');
      // Show payment interface
      if (context.mounted) {
        await PaymobIFrameInApp.show(
          title: title ?? Text(paymentMethod.displayName),
          appBarColor: appBarColor,
          context: context,
          redirectURL: payUrl,
          onPayment: (response) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              onPayment?.call(response);
            });
          },
        );
      }
    } catch (e) {
      _paymentApiService.clearAuth();
      rethrow;
    }
  }

  @override
  Future<void> payWithIframe({
    required BuildContext context,
    required PaymobIframe iframe,
    required String currency,
    required double amount,
    Widget? title,
    Color? appBarColor,
    void Function(PaymentPaymobResponse response)? onPayment,
    BillingData? billingData,
  }) async {
    _validateInitialization();
    _validateIframe(iframe);

    try {
      // Get API key
      await _paymentApiService.getApiKey(_apiKey!);
      
      // Create order
      await _paymentApiService.createOrder(amount, currency);
      
      // Request payment token
      final paymentToken = await _paymentApiService.requestPaymentToken(
        amount: amount,
        currency: currency,
        integrationId: iframe.integrationId.toString(),
        billingData: billingData ?? BillingData(),
        userTokenExpiration: _userTokenExpiration,
      );
      
      // Build iframe URL
      final iframeUrl = 'https://accept.paymob.com/api/acceptance/iframes/${iframe.iframeId}?payment_token=$paymentToken';
      
      // Show payment interface
      if (context.mounted) {
        await PaymobIFrameInApp.show(
          title: title ?? Text(iframe.name ?? 'Paymob Payment'),
          appBarColor: appBarColor,
          context: context,
          redirectURL: iframeUrl,
          onPayment: (response) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              onPayment?.call(response);
            });
          },
        );
      }
    } catch (e) {
      _paymentApiService.clearAuth();
      rethrow;
    }
  }

  /// Validate that the service is initialized
  void _validateInitialization() {
    if (!_isInitialized) {
      throw const PaymentInitializationException('PaymobFlutter must be initialized before use');
    }
  }

  /// Validate that the payment method is available
  void _validatePaymentMethod(PaymobPaymentMethod paymentMethod) {
    if (!_availablePaymentMethods.any((config) => config.paymentMethod == paymentMethod)) {
      final availableNames = _availablePaymentMethods.map((config) => config.paymentMethod.displayName).toList();
      throw PaymentMethodNotAvailableException(paymentMethod.displayName, availableNames);
    }
  }
  
  /// Get the payment method configuration for a given payment method
  PaymentMethodConfig? _getPaymentMethodConfig(PaymobPaymentMethod paymentMethod) {
    try {
      return _availablePaymentMethods.firstWhere((config) => config.paymentMethod == paymentMethod);
    } catch (e) {
      return null;
    }
  }

  /// Validate that the iframe is available
  void _validateIframe(PaymobIframe iframe) {
    if (!_availableIframes.contains(iframe)) {
      final availableNames = _availableIframes.map((i) => i.name ?? i.iframeId.toString()).toList();
      throw IframeNotAvailableException(iframe.name ?? iframe.iframeId.toString(), availableNames);
    }
  }
}