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
  
  // Initialize Paymob
  PaymobFlutter.instance.initialize(
    apiKey: "your_api_key",
    paymentMethods: [
      PaymobPaymentMethod.applePay,
      PaymobPaymentMethod.valu,
      PaymobPaymentMethod.wallet,
    ],
    iframes: [
      PaymobIframe(
        iframeId: 769581,
        integrationId: 123456,
        name: "Payment Iframe",
        description: "Main payment iframe",
      ),
    ],
  );
  
  runApp(MyApp());
}
```

### 2. **Process a Payment**

```dart
// Simple payment
PaymobFlutter.instance.payWithCustomMethod(
  context: context,
  paymentMethod: PaymobPaymentMethod.valu,
  currency: "EGP",
  amount: 100.0,
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
      PaymentMethodConfig.withDefault(
        paymentMethod: PaymobPaymentMethod.valu,
        integrationId: 123456,
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
      PaymentMethodConfig.custom(
        paymentMethod: PaymobPaymentMethod.valu,
        identifier: "customer_phone",
        integrationId: 789012,
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

## 💳 Payment Methods

### **Custom Payment Method**

```dart
PaymobFlutter.instance.payWithCustomMethod(
  context: context,
  paymentMethod: PaymobPaymentMethod.valu,
  currency: "EGP",
  amount: 150.0,
  identifier: "01012345678", // Customer phone/email
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

## 🎨 UI Components

### **Payment Method Selection**

```dart
ListView.builder(
  itemCount: PaymobFlutter.instance.availablePaymentMethods.length,
  itemBuilder: (context, index) {
    final method = PaymobFlutter.instance.availablePaymentMethods[index];
    return PaymentMethodCard(
      method: method,
      onTap: () => _processPayment(method),
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
PaymentMethodConfig.custom(
  paymentMethod: PaymobPaymentMethod.valu,
  identifier: "customer_identifier",
  integrationId: 123456,
  customSubtype: "CUSTOM_SUBTYPE",
  displayName: "Custom ValU",
  description: "Custom ValU payment method",
)
```

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
      final result = await PaymobFlutter.instance.initialize(
        apiKey: "test_key",
        paymentMethods: [PaymobPaymentMethod.valu],
        iframes: [testIframe],
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