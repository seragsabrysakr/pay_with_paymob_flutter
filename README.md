# 🚀 Paymob Flutter SDK

[![pub package](https://img.shields.io/pub/v/pay_with_paymob_flutter.svg)](https://pub.dev/packages/pay_with_paymob_flutter)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Flutter](https://img.shields.io/badge/Flutter-02569B?logo=flutter&logoColor=white)](https://flutter.dev)

> **The most comprehensive and developer-friendly Paymob payment integration for Flutter applications**

A powerful, feature-rich Flutter package that provides seamless integration with Paymob's payment gateway. Built with clean architecture principles and designed for both development and production environments.

## ✨ Features

### 🎯 **Core Features**
- **🔧 Easy Integration** - Simple setup with comprehensive configuration management
- **🌍 Multi-Environment Support** - Separate configurations for test and live environments
- **💳 Multiple Payment Methods** - Support for all Paymob payment methods
- **🖼️ Iframe Integration** - Built-in iframe support for web-based payments
- **🔗 Payment Links** - Create shareable payment links for seamless customer experience
- **🔒 Secure** - Follows security best practices and Paymob guidelines
- **📱 Cross-Platform** - Works on iOS, Android, Web, and Desktop

### 💰 **Supported Payment Methods**
- **Apple Pay** - Secure payments with Apple Pay
- **ValU** - Buy now, pay later with ValU
- **Bank Installments** - Flexible bank installment options
- **Souhoola V3** - Advanced installment services
- **Aman V3** - Comprehensive payment solutions
- **Forsa** - Modern payment processing
- **Premium** - Premium payment services
- **Contact** - Contact-based payments
- **HALAN** - Digital wallet integration
- **SYMPL** - Simplified payment processing
- **Kiosk** - Kiosk-based payments
- **Wallet** - Digital wallet payments
- **Custom** - Custom payment method support

### 🏗️ **Architecture & Design**
- **SOLID Principles** - Clean, maintainable code architecture
- **Dependency Injection** - Flexible and testable design
- **Interface Segregation** - Focused, single-responsibility interfaces
- **Error Handling** - Comprehensive exception handling
- **Type Safety** - Full TypeScript-like type safety with Dart

### 🆕 **Latest Features**
- **🔗 Payment Links** - Create shareable payment links with unified API
- **📱 Tabbed Example App** - Comprehensive demo with three organized tabs
- **🔧 Flexible Identifiers** - Support for both numeric and text identifiers
- **🌍 Environment Management** - Easy switching between test and live environments
- **📊 Real-time Feedback** - Immediate success/error feedback for all operations
- **🎨 Modern UI Components** - Clean, organized interface components

## 📦 Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  pay_with_paymob_flutter: ^1.0.0
```

Then run:

```bash
flutter pub get
```

## 🚀 Quick Start

### 1. **Basic Setup**

```dart
import 'package:pay_with_paymob_flutter/paymob_flutter.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Paymob with configuration
  PaymobFlutter.instance.initializeWithConfig(
    apiKey: "your_api_key",
    paymentMethods: [
      PaymentMethodConfig(
        paymentMethod: PaymobPaymentMethod.applePay,
        identifier: '123456',
        integrationId: '123456',
        customSubtype: 'APPLE_PAY',
        displayName: 'Apple Pay',
        description: 'Pay securely with Apple Pay',
      ),
      PaymentMethodConfig(
        paymentMethod: PaymobPaymentMethod.valu,
        identifier: '789012',
        integrationId: '789012',
        customSubtype: 'VALU',
        displayName: 'ValU',
        description: 'Buy now, pay later with ValU',
      ),
    ],
    iframes: [
      PaymobIframe(
        iframeId: 769581,
        integrationId: 123456,
        name: "Payment Iframe",
        description: "Main payment iframe",
      ),
    ],
    defaultIntegrationId: 123456,
  );
  
  runApp(MyApp());
}
```

### 2. **Process a Payment**

```dart
// Get a configured payment method
final paymentMethod = PaymobFlutter.instance.availablePaymentMethods.first;

// Process payment
PaymobFlutter.instance.payWithCustomMethod(
  context: context,
  paymentMethod: paymentMethod,
  currency: "EGP",
  amount: 100.0,
  billingData: BillingData(
    firstName: "John",
    lastName: "Doe",
    email: "john@example.com",
    phoneNumber: "01012345678",
    city: "Cairo",
    country: "Egypt",
  ),
  onPayment: (response) {
    if (response.success) {
      print("Payment successful: ${response.message}");
    } else {
      print("Payment failed: ${response.message}");
    }
  },
);
```

## 🎛️ Advanced Configuration

### **Environment-Based Configuration**

Create separate configurations for different environments:

```dart
// config/test_config.dart
class TestConfig {
  static AppConfig get config => AppConfig(
    apiKey: "test_api_key",
    paymentMethods: [
      PaymentMethodConfig(
        paymentMethod: PaymobPaymentMethod.valu,
        identifier: '123456',
        integrationId: "123456",
        customSubtype: "VALU",
        displayName: "ValU",
        description: "Buy now, pay later with ValU",
      ),
    ],
    iframes: [/* test iframes */],
    defaultIntegrationId: 123456,
  );
}

// config/live_config.dart
class LiveConfig {
  static AppConfig get config => AppConfig(
    apiKey: "live_api_key",
    paymentMethods: [
      PaymentMethodConfig(
        paymentMethod: PaymobPaymentMethod.valu,
        identifier: '789012',
        integrationId: "789012",
        customSubtype: "VALU",
        displayName: "ValU",
        description: "Buy now, pay later with ValU",
      ),
    ],
    iframes: [/* live iframes */],
    defaultIntegrationId: 789012,
  );
}
```

### **Initialize with Configuration**

```dart
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Set environment
  ConfigManager.setEnvironment(Environment.live);
  
  // Get configuration
  final config = ConfigManager.currentConfig;
  
  // Initialize
  PaymobFlutter.instance.initializeWithConfig(
    apiKey: config.apiKey,
    paymentMethods: config.paymentMethods,
    iframes: config.iframes,
    defaultIntegrationId: config.defaultIntegrationId,
  );
  
  runApp(MyApp());
}
```

## 🔧 API Reference

### **Available Methods**

```dart
// Initialize with configuration
Future<bool> initializeWithConfig({
  required String apiKey,
  required List<PaymentMethodConfig> paymentMethods,
  required List<PaymobIframe> iframes,
  required int defaultIntegrationId,
});

// Process payment with custom method
Future<void> payWithCustomMethod({
  required BuildContext context,
  required PaymentMethodConfig paymentMethod,
  required String currency,
  required double amount,
  BillingData? billingData,
  Widget? title,
  Color? appBarColor,
  void Function(PaymentPaymobResponse response)? onPayment,
});

// Process payment with iframe
Future<void> payWithIframe({
  required BuildContext context,
  required PaymobIframe iframe,
  required String currency,
  required double amount,
  BillingData? billingData,
  Widget? title,
  Color? appBarColor,
  void Function(PaymentPaymobResponse response)? onPayment,
});

// Create and open payment link
Future<void> createPayLink({
  required BuildContext context,
  required String apiKey,
  required PaymentLinkRequest request,
  String? imagePath,
  Widget? title,
  Color? appBarColor,
  void Function(PaymentPaymobResponse response)? onPayment,
});
```

### **Available Properties**

```dart
// Get available payment methods
List<PaymentMethodConfig> get availablePaymentMethods;

// Get available iframes
List<PaymobIframe> get availableIframes;

// Check if initialized
bool get isInitialized;
```

## 💳 Payment Methods

### **Custom Payment Method**

```dart
// Create a custom payment method configuration
final customMethod = PaymentMethodConfig(
  paymentMethod: PaymobPaymentMethod.valu,
  identifier: '01012345678', // Customer phone/email
  integrationId: '123456',
  customSubtype: 'VALU',
  displayName: 'ValU Payment',
  description: 'Buy now, pay later with ValU',
);

PaymobFlutter.instance.payWithCustomMethod(
  context: context,
  paymentMethod: customMethod,
  currency: "EGP",
  amount: 150.0,
  billingData: BillingData(
    firstName: "Serag",
    lastName: "Sakr",
    email: "ahmed@example.com",
    phoneNumber: "01012345678",
    city: "Cairo",
    country: "Egypt",
  ),
  onPayment: (response) {
    // Handle payment response
  },
);
```

### **Iframe Payment**

```dart
final iframe = PaymobIframe(
  iframeId: 769581,
  integrationId: 123456,
  name: "Payment Gateway",
  description: "Secure payment processing",
);

PaymobFlutter.instance.payWithIframe(
  context: context,
  iframe: iframe,
  currency: "EGP",
  amount: 200.0,
  onPayment: (response) {
    // Handle payment response
  },
);
```

### **Payment Links** 🆕

Create shareable payment links that customers can use to complete payments without being redirected back to your app.

```dart
// Create a payment link using API key (recommended)
final request = PaymentLinkRequest.fromAmount(
  amount: 100.0, // Amount in currency units
  paymentMethods: ["123456"], // Integration IDs
  email: "customer@example.com",
  fullName: "John Doe",
  phoneNumber: "+201029382968",
  description: "Payment for order #12345",
  isLive: true, // Set to false for test environment
);

await PaymobFlutter.instance.createPayLink(
  context: context,
  apiKey: "your_api_key", // Your PayMob API key
  request: request,
  imagePath: "/path/to/payment/image.png", // Optional
  title: const Text('Payment Link'),
  onPayment: (response) {
    // Handle payment response
    if (response.success) {
      print('Payment successful!');
    } else {
      print('Payment failed: ${response.message}');
    }
  },
);
```

**Payment Link Features:**
- ✅ **Shareable Links** - Send payment links via SMS, email, or any messaging platform
- ✅ **No Redirects** - Customers complete payment without returning to your app
- ✅ **Image Support** - Add custom images to payment links
- ✅ **Multiple Payment Methods** - Support for various payment options
- ✅ **Reference Tracking** - Track payments with custom reference IDs
- ✅ **Environment Support** - Works with both test and live environments
- ✅ **Unified Service** - All payment operations (regular payments + payment links) in one service

**Simple Usage:**
```dart
// Create and open payment link (same pattern as other payment methods)
await PaymobFlutter.instance.createPayLink(
  context: context,
  apiKey: "your_api_key",
  request: request,
  onPayment: (response) {
    // Handle payment response
  },
);
```

## 📱 Example App

The package includes a comprehensive example app with a **tabbed interface** demonstrating all features:

### **Three Main Tabs:**

1. **💳 Payment Methods Tab**
   - Direct payments using `payWithCustomMethod`
   - Organized by categories: Digital Wallets, Installment Services, Other Services
   - Real-time payment processing with success/error feedback

2. **🖼️ Iframe Tab**
   - Embedded payment forms using `payWithIframe`
   - All configured iframes with detailed information
   - Seamless web-based payment experience

3. **🔗 Payment Links Tab**
   - Shareable payment links using `createPayLink`
   - Same payment method organization as Payment Methods tab
   - Customer-friendly payment link creation

### **Key Features:**
- **🌍 Environment Switcher** - Toggle between test and live environments
- **📊 Real-time Feedback** - Success/error messages for all operations
- **🎨 Modern UI** - Clean, organized interface with proper categorization
- **📱 Responsive Design** - Works on all screen sizes

### **Running the Example:**

```bash
cd example
flutter run
```

## 🎨 UI Components

### **Payment Method Selection**

```dart
ListView.builder(
  itemCount: PaymobFlutter.instance.availablePaymentMethods.length,
  itemBuilder: (context, index) {
    final method = PaymobFlutter.instance.availablePaymentMethods[index];
    return Card(
      child: ListTile(
        title: Text(method.displayName),
        subtitle: Text(method.description),
        trailing: ElevatedButton(
          onPressed: () => _processPayment(method),
          child: Text("Pay"),
        ),
      ),
    );
  },
)
```

### **Environment Indicator**

```dart
Container(
  padding: EdgeInsets.all(8),
  decoration: BoxDecoration(
    color: ConfigManager.isLive ? Colors.green : Colors.orange,
    borderRadius: BorderRadius.circular(8),
  ),
  child: Text(
    "Environment: ${ConfigManager.currentEnvironment.name.toUpperCase()}",
    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
  ),
)
```

## 🔧 Configuration Options

### **Payment Method Configuration**

```dart
PaymentMethodConfig(
  paymentMethod: PaymobPaymentMethod.valu,
  identifier: '123456', // String identifier (can be numeric or text like 'AGGREGATOR')
  integrationId: '123456', // String integration ID
  customSubtype: 'VALU', // Payment method subtype
  displayName: 'ValU Payment', // User-friendly display name
  description: 'Buy now, pay later with ValU', // Description for users
)
```

**Identifier Types Supported:**
- **Numeric IDs**: `'123456'`, `'789012'` (for most payment methods)
- **Text Identifiers**: `'AGGREGATOR'` (for Kiosk payments)
- **Phone Numbers**: `'01010101010'` (for Wallet payments)

### **Billing Data**

```dart
BillingData(
  firstName: "John",
  lastName: "Doe",
  email: "john@example.com",
  phoneNumber: "01012345678",
  apartment: "Apt 123",
  building: "Building 1",
  floor: "2nd Floor",
  street: "Main Street",
  city: "Cairo",
  state: "Cairo",
  country: "Egypt",
  postalCode: "12345",
  shippingMethod: "Standard",
)
```

## 🛡️ Error Handling

```dart
try {
  await PaymobFlutter.instance.payWithCustomMethod(
    context: context,
    paymentMethod: PaymobPaymentMethod.valu,
    currency: "EGP",
    amount: 100.0,
    onPayment: (response) {
      // Handle response
    },
  );
} on PaymentInitializationException catch (e) {
  print("Initialization error: ${e.message}");
} on PaymentMethodNotAvailableException catch (e) {
  print("Payment method not available: ${e.message}");
} on InvalidApiKeyException catch (e) {
  print("Invalid API key: ${e.message}");
} catch (e) {
  print("Unexpected error: $e");
}
```

## 📱 Platform Support

| Platform | Support | Notes |
|----------|---------|-------|
| **iOS** | ✅ Full | Native iOS integration |
| **Android** | ✅ Full | Native Android integration |
| **Web** | ✅ Full | Web-based iframe integration |
| **Windows** | ✅ Full | Desktop support |
| **macOS** | ✅ Full | Desktop support |
| **Linux** | ✅ Full | Desktop support |

## 🔐 Security Features

- **🔒 Secure API Key Management** - Environment-based key management
- **🛡️ Input Validation** - Comprehensive input validation
- **🔐 HTTPS Only** - All communications over secure connections
- **🎯 Type Safety** - Full type safety with Dart
- **🚫 Error Prevention** - Built-in error handling and prevention

## 📊 Response Handling

```dart
void handlePaymentResponse(PaymentPaymobResponse response) {
  if (response.success) {
    // Payment successful
    print("Transaction ID: ${response.transactionId}");
    print("Amount: ${response.amount}");
    print("Currency: ${response.currency}");
    print("Message: ${response.message}");
  } else {
    // Payment failed
    print("Error: ${response.message}");
    print("Error Code: ${response.errorCode}");
  }
}
```

## 🧪 Testing

### **Unit Tests**

```dart
void main() {
  group('PaymobFlutter Tests', () {
    test('should initialize with valid configuration', () async {
      final result = await PaymobFlutter.instance.initializeWithConfig(
        apiKey: "test_key",
        paymentMethods: [
          PaymentMethodConfig(
            paymentMethod: PaymobPaymentMethod.valu,
            identifier: '123456',
            integrationId: '123456',
            customSubtype: 'VALU',
            displayName: 'ValU',
            description: 'Test ValU payment',
          ),
        ],
        iframes: [
          PaymobIframe(
            iframeId: 123456,
            integrationId: 123456,
            name: "Test Iframe",
            description: "Test iframe description",
          ),
        ],
        defaultIntegrationId: 123456,
      );
      expect(result, isTrue);
    });
  });
}
```

### **Integration Tests**

```dart
void main() {
  group('Payment Integration Tests', () {
    testWidgets('should process payment successfully', (tester) async {
      // Test payment flow
    });
  });
}
```

## 🚀 Deployment

### **Development**

```dart
void main() {
  ConfigManager.setEnvironment(Environment.test);
  // ... rest of initialization
}
```

### **Production**

```dart
void main() {
  ConfigManager.setEnvironment(Environment.live);
  // ... rest of initialization
}
```

## 📈 Performance

- **⚡ Fast Initialization** - Optimized startup time
- **🔄 Efficient Memory Usage** - Minimal memory footprint
- **📱 Native Performance** - Platform-optimized implementations
- **🌐 Network Optimization** - Efficient API communication

## 🤝 Contributing

We welcome contributions! Please see our [Contributing Guidelines](CONTRIBUTING.md) for details.

### **Development Setup**

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🆘 Support

- **📚 Documentation** - [Full Documentation](https://pub.dev/documentation/pay_with_paymob_flutter)
- **🐛 Issues** - [Report Issues](https://github.com/seragsabrysakr/pay_with_paymob_flutter/issues)
- **💬 Discussions** - [GitHub Discussions](https://github.com/seragsabrysakr/pay_with_paymob_flutter/discussions)
- **📧 Email** - support@yourcompany.com

## 🙏 Acknowledgments

- **Paymob Team** - For providing excellent payment gateway services
- **Flutter Community** - For the amazing Flutter framework
- **Contributors** - All the amazing contributors who helped build this package

## 🎯 Key Improvements in v1.0.0

### **🔧 Enhanced Configuration System**
- **String Identifiers**: Support for both numeric (`'123456'`) and text (`'AGGREGATOR'`) identifiers
- **Flexible Payment Methods**: Easy configuration with `PaymentMethodConfig` objects
- **Environment Management**: Seamless switching between test and live environments

### **🔗 Payment Links Integration**
- **Unified API**: Single `createPayLink` method for all payment link operations
- **3-Step Process**: Authenticate → Create Link → Open Web View (same pattern as other payments)
- **Image Support**: Optional custom images for payment links
- **No Redirects**: Customers complete payments without returning to your app

### **📱 Comprehensive Example App**
- **Tabbed Interface**: Three organized tabs for different payment types
- **Real-time Feedback**: Immediate success/error messages
- **Modern UI**: Clean, responsive design with proper categorization
- **Environment Switcher**: Easy testing between environments

### **🏗️ Improved Architecture**
- **Type Safety**: Consistent string typing throughout the codebase
- **Error Handling**: Comprehensive exception handling and user feedback
- **Clean Code**: SOLID principles and maintainable architecture
- **Documentation**: Extensive inline documentation and examples

## 📊 Stats

![GitHub stars](https://img.shields.io/github/stars/seragsabrysakr/pay_with_paymob_flutter?style=social)
![GitHub forks](https://img.shields.io/github/forks/seragsabrysakr/pay_with_paymob_flutter?style=social)
![GitHub issues](https://img.shields.io/github/issues/seragsabrysakr/pay_with_paymob_flutter)
![GitHub pull requests](https://img.shields.io/github/issues-pr/seragsabrysakr/pay_with_paymob_flutter)

---

<div align="center">

**Made with ❤️ for the Flutter community**

[⭐ Star this repo](https://github.com/seragsabrysakr/pay_with_paymob_flutter) | [🐛 Report Bug](https://github.com/seragsabrysakr/pay_with_paymob_flutter/issues) | [💡 Request Feature](https://github.com/seragsabrysakr/pay_with_paymob_flutter/issues)

</div>