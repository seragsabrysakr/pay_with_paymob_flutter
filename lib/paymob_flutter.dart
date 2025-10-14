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
///     paymentMethods: [PaymentMethodConfig(...)],
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
///   paymentMethod: PaymentMethodConfig(...),
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
import 'package:pay_with_paymob_flutter/core/interfaces/api_service_interface.dart';

import 'core/exceptions/paymob_exceptions.dart';
import 'core/interfaces/payment_service_interface.dart';
import 'core/services/api_service.dart';
import 'models/billing_data.dart';
import 'models/payment_intention_request.dart';
import 'models/payment_link_request.dart';
import 'models/payment_method_config.dart';
import 'models/paymob_iframe_config.dart';
import 'models/paymob_response.dart';
import 'models/unified_checkout_config.dart';
import 'services/payment_api_service.dart';
import 'ui/widgets/paymob_inapp_webview.dart';

// Export all public classes
export 'models/billing_data.dart';
export 'models/payment_intention_request.dart';
export 'models/payment_intention_response.dart';
export 'models/payment_link_request.dart';
export 'models/payment_link_response.dart';
export 'models/payment_method_config.dart';
export 'models/paymob_iframe_config.dart';
export 'models/paymob_payment_method.dart';
export 'models/paymob_response.dart';
export 'models/unified_checkout_config.dart';

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
  String? _publicKey;
  String? _secretKey;
  List<PaymentMethodConfig> _availablePaymentMethods = [];
  List<PaymobIframe> _availableIframes = [];
  int _userTokenExpiration = 3600;
  bool _isInitialized = false;

  /// Initialize with PaymentMethodConfig list (recommended)
  Future<bool> initializeWithConfig({
    required String apiKey,
    required String publicKey,
    required String secretKey,
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
    if (publicKey.isEmpty) {
      throw const InvalidApiKeyException('Public key cannot be empty');
    }
    if (secretKey.isEmpty) {
      throw const InvalidApiKeyException('Secret key cannot be empty');
    }
    if (paymentMethods.isEmpty) {
      throw const PaymentInitializationException(
          'At least one payment method must be provided');
    }
    if (iframes.isEmpty) {
      throw const PaymentInitializationException(
          'At least one iframe must be provided');
    }

    // Initialize dependencies
    _httpService = ApiService();
    _paymentApiService = PaymentApiService(_httpService);

    // Store configuration
    _apiKey = apiKey;
    _publicKey = publicKey;
    _secretKey = secretKey;
    _availablePaymentMethods = List.from(paymentMethods);
    _availableIframes = List.from(iframes);
    _userTokenExpiration = userTokenExpiration;

    _isInitialized = true;
    return true;
  }

  @override
  Future<bool> initialize({
    required String apiKey,
    required List<PaymentMethodConfig> paymentMethods,
    required List<PaymobIframe> iframes,
    int? defaultIntegrationId,
    int userTokenExpiration = 3600,
  }) async {
    // This method is deprecated - use initializeWithConfig() instead
    throw const PaymentInitializationException(
        'Please use initializeWithConfig() method with publicKey and secretKey for Unified Checkout');
  }

  @override
  List<PaymentMethodConfig> get availablePaymentMethods =>
      _availablePaymentMethods;

  /// Get available payment method configurations with their identifiers
  List<PaymentMethodConfig> get availablePaymentMethodConfigs =>
      List.from(_availablePaymentMethods);

  @override
  List<PaymobIframe> get availableIframes => List.from(_availableIframes);

  @override
  @Deprecated('Use payWithUnifiedCheckout instead')
  Future<void> payWithCustomMethod({
    required BuildContext context,
    required PaymentMethodConfig paymentMethod,
    required String currency,
    required double amount,
    Widget? title,
    Color? appBarColor,
    void Function(PaymentPaymobResponse response)? onPayment,
    BillingData? billingData,
  }) async {
    throw const PaymentInitializationException(
        'payWithCustomMethod is deprecated. Use payWithUnifiedCheckout instead.');
  }

  /// Pay with Unified Checkout (replaces payWithCustomMethod)
  Future<void> payWithUnifiedCheckout({
    required BuildContext context,
    required String currency,
    required double amount,
    int? expiration,
    required List<int> paymentMethodIntegrationIds,
    Widget? title,
    Color? appBarColor,
    void Function(PaymentPaymobResponse response)? onPayment,
    BillingData? billingData,
    String? specialReference,
    List<Map<String, dynamic>>? items,
    Map<String, dynamic>? extras,
  }) async {
    _validateInitialization();

    try {
      // Create Payment Intention Request
      final paymentIntentionRequest = PaymentIntentionRequest.create(
        amount: amount,
        currency: currency,
        expiration: expiration,
        paymentMethodIntegrationIds: paymentMethodIntegrationIds,
        billingData: billingData ?? BillingData(),
        customer: CustomerData.fromBillingData(billingData ?? BillingData()),
        specialReference: specialReference,
        items: items,
        extras: extras,
      );

      // Create Payment Intention
      final paymentIntentionResponse =
          await _paymentApiService.createPaymentIntention(
        request: paymentIntentionRequest,
        secretKey: _secretKey!,
      );

      // Create Unified Checkout Config
      final unifiedCheckoutConfig = UnifiedCheckoutConfig.fromPaymentIntention(
        publicKey: _publicKey!,
        response: paymentIntentionResponse,
        title: title?.toString(),
      );

      debugPrint('Unified Checkout URL: ${unifiedCheckoutConfig.checkoutUrl}');

      // Show payment interface
      // if (context.mounted) {
        await PaymobInAppWebView.show(
          title: title ?? const Text('Paymob Payment'),
          appBarColor: appBarColor,
          context: context,
          redirectURL: unifiedCheckoutConfig.checkoutUrl,
          onPayment: (response) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              onPayment?.call(response);
            });
          },
        );
      // }
    } catch (e) {
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
      await _paymentApiService.getAuthenticationToken(_apiKey!);

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
      final iframeUrl =
          'https://accept.paymob.com/api/acceptance/iframes/${iframe.iframeId}?payment_token=$paymentToken';

      // Show payment interface
      if (context.mounted) {
        await PaymobInAppWebView.show(
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
      throw const PaymentInitializationException(
          'PaymobFlutter must be initialized before use');
    }
    _validateUnifiedCheckoutKeys();
  }

  /// Validate that the service has required keys for Unified Checkout
  void _validateUnifiedCheckoutKeys() {
    if (_publicKey == null || _publicKey!.isEmpty) {
      throw const InvalidApiKeyException(
          'Public key is required for Unified Checkout');
    }
    if (_secretKey == null || _secretKey!.isEmpty) {
      throw const InvalidApiKeyException(
          'Secret key is required for Unified Checkout');
    }
  }

  /// Validate that the iframe is available
  void _validateIframe(PaymobIframe iframe) {
    if (!_availableIframes.contains(iframe)) {
      final availableNames = _availableIframes
          .map((i) => i.name ?? i.iframeId.toString())
          .toList();
      throw IframeNotAvailableException(
          iframe.name ?? iframe.iframeId.toString(), availableNames);
    }
  }

  /// Create and open payment link (same pattern as other payment methods)
  @override
  Future<void> createPayLink({
    required BuildContext context,
    required String apiKey,
    required PaymentLinkRequest request,
    String? imagePath,
    Widget? title,
    Color? appBarColor,
    void Function(PaymentPaymobResponse response)? onPayment,
  }) async {
    _validateInitialization();

    try {
      // Step 1: Get token (same as other payment methods)
      await _paymentApiService.getAuthenticationToken(apiKey);

      // Step 2: Create payment link
      final paymentLinkResponse = await _paymentApiService.createPaymentLink(
        request: request,
        imagePath: imagePath,
      );

      // Step 3: Open as web view (same way as other payment methods)
      // if (context.mounted) {
      await PaymobInAppWebView.show(
        context: context,
        redirectURL: paymentLinkResponse.clientUrl,
        title: title ?? const Text('Payment Link'),
        appBarColor: appBarColor,
        onPayment: onPayment,
      );
      // }
    } catch (e) {
      _paymentApiService.clearAuth();
      rethrow;
    }
  }

  /// Clear payment link authentication
  void clearPaymentLinkAuth() {
    _paymentApiService.clearAuth();
  }
}
