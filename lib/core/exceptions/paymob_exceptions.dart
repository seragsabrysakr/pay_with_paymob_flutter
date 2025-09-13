/// Custom exceptions for Paymob integration
abstract class PaymobException implements Exception {
  final String message;
  final String? code;
  
  const PaymobException(this.message, [this.code]);
  
  @override
  String toString() => 'PaymobException: $message${code != null ? ' (Code: $code)' : ''}';
}

/// Exception thrown when API key is invalid or missing
class InvalidApiKeyException extends PaymobException {
  const InvalidApiKeyException([String? message]) 
      : super(message ?? 'Invalid or missing API key');
}

/// Exception thrown when payment method is not available
class PaymentMethodNotAvailableException extends PaymobException {
   PaymentMethodNotAvailableException(String methodName, List<String> availableMethods)
      : super('Payment method $methodName is not available. Available methods: ${availableMethods.join(', ')}');
}

/// Exception thrown when iframe is not available
class IframeNotAvailableException extends PaymobException {
   IframeNotAvailableException(String iframeName, List<String> availableIframes)
      : super('Iframe $iframeName is not available. Available iframes: ${availableIframes.join(', ')}');
}

/// Exception thrown when API request fails
class ApiRequestException extends PaymobException {
  const ApiRequestException(String message, [String? code]) : super(message, code);
}

/// Exception thrown when payment initialization fails
class PaymentInitializationException extends PaymobException {
  const PaymentInitializationException([String? message]) 
      : super(message ?? 'Failed to initialize payment');
}

/// Exception thrown when order creation fails
class OrderCreationException extends PaymobException {
  const OrderCreationException([String? message]) 
      : super(message ?? 'Failed to create order');
}

/// Exception thrown when payment token request fails
class PaymentTokenException extends PaymobException {
  const PaymentTokenException([String? message]) 
      : super(message ?? 'Failed to get payment token');
}

/// Exception thrown when wallet URL request fails
class WalletUrlException extends PaymobException {
  const WalletUrlException([String? message]) 
      : super(message ?? 'Failed to get wallet URL');
}

/// Exception thrown when payment link operations fail
class PaymentLinkException extends PaymobException {
  const PaymentLinkException([String? message]) 
      : super(message ?? 'Failed to process payment link');
}