/// API constants for Paymob integration
class ApiConstants {
  static const String acceptBaseUrl = "https://accept.paymob.com/api";
  
  // API Endpoints
  static const String authorization = "$acceptBaseUrl/auth/tokens";
  static const String order = "$acceptBaseUrl/ecommerce/orders";
  static const String keys = "$acceptBaseUrl/acceptance/payment_keys";
  static const String wallet = "$acceptBaseUrl/acceptance/payments/pay";
  
  // Payment Link API Endpoints
  static const String paymentLinks = "$acceptBaseUrl/ecommerce/payment-links";
  
  // Default values
  static const int defaultUserTokenExpiration = 3600;
  static const String defaultCurrency = "EGP";
  
  // Headers
  static const Map<String, String> defaultHeaders = {
    'Content-Type': 'application/json',
  };
}
