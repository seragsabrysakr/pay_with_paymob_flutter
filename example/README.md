# 🚀 Paymob Flutter SDK - Example App

This example demonstrates the full capabilities of the Paymob Flutter SDK with a complete, production-ready implementation.

## 📱 Features Demonstrated

- ✅ **Environment Management** - Switch between test and live environments
- ✅ **All Payment Methods** - Complete implementation of all supported payment methods
- ✅ **Iframe Integration** - Web-based payment processing
- ✅ **Configuration Management** - External configuration files
- ✅ **Error Handling** - Comprehensive error handling and user feedback
- ✅ **UI Components** - Beautiful, responsive UI components
- ✅ **Billing Data** - Complete billing information handling

## 🏗️ Project Structure

```
example/
├── lib/
│   ├── config/                 # Configuration management
│   │   ├── app_config.dart     # Base configuration class
│   │   ├── config_manager.dart # Environment management
│   │   ├── test_config.dart    # Test environment config
│   │   └── live_config.dart    # Live environment config
│   └── main.dart              # Main application
├── android/                   # Android-specific files
├── ios/                      # iOS-specific files
└── README.md                 # This file
```

## 🚀 Getting Started

### 1. **Clone and Setup**

```bash
git clone https://github.com/your-username/pay_with_paymob_flutter.git
cd pay_with_paymob_flutter/example
flutter pub get
```

### 2. **Configure Your API Keys**

Update the configuration files with your Paymob credentials:

**For Test Environment:**
```dart
// lib/config/test_config.dart
apiKey: "your_test_api_key_here",
```

**For Live Environment:**
```dart
// lib/config/live_config.dart
apiKey: "your_live_api_key_here",
```

### 3. **Run the App**

```bash
flutter run
```

## 🎯 Key Features

### **Environment Switching**
- Toggle between test and live environments
- Visual indicators for current environment
- Automatic configuration switching

### **Payment Method Support**
- Apple Pay
- ValU (Buy now, pay later)
- Bank Installments
- Souhoola V3
- Aman V3
- Forsa
- Premium
- Contact
- HALAN
- SYMPL
- Kiosk
- Wallet
- Custom payment methods

### **Iframe Integration**
- Web-based payment processing
- Multiple iframe configurations
- Secure payment token handling

### **Configuration Management**
- External configuration files
- Environment-specific settings
- Easy deployment management

## 🔧 Configuration

### **Test Configuration**
```dart
// lib/config/test_config.dart
class TestConfig {
  static AppConfig get config => AppConfig(
    apiKey: "your_test_api_key",
    paymentMethods: [
      PaymentMethodConfig.withDefault(
        paymentMethod: PaymobPaymentMethod.valu,
        integrationId: 123456,
      ),
      // ... more payment methods
    ],
    iframes: [
      PaymobIframe(
        iframeId: 769581,
        integrationId: 123456,
        name: "Test Iframe",
        description: "Test payment iframe",
      ),
      // ... more iframes
    ],
    defaultIntegrationId: 123456,
  );
}
```

### **Live Configuration**
```dart
// lib/config/live_config.dart
class LiveConfig {
  static AppConfig get config => AppConfig(
    apiKey: "your_live_api_key",
    paymentMethods: [
      PaymentMethodConfig.custom(
        paymentMethod: PaymobPaymentMethod.valu,
        identifier: "customer_phone",
        integrationId: 789012,
      ),
      // ... more payment methods
    ],
    iframes: [
      PaymobIframe(
        iframeId: 769581,
        integrationId: 789012,
        name: "Live Iframe",
        description: "Live payment iframe",
      ),
      // ... more iframes
    ],
    defaultIntegrationId: 789012,
  );
}
```

## 💳 Payment Processing

### **Custom Payment Method**
```dart
PaymobFlutter.instance.payWithCustomMethod(
  context: context,
  paymentMethod: PaymobPaymentMethod.valu,
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
      // Payment successful
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Payment successful: ${response.message}")),
      );
    } else {
      // Payment failed
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Payment failed: ${response.message}")),
      );
    }
  },
);
```

### **Iframe Payment**
```dart
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

### **Payment Method Card**
```dart
Widget _buildPaymentMethodCard(PaymobPaymentMethod method) {
  final config = PaymobFlutter.instance.availablePaymentMethodConfigs
      .firstWhere((config) => config.paymentMethod == method);
  
  return Card(
    margin: const EdgeInsets.symmetric(vertical: 2),
    child: ListTile(
      title: Text(method.displayName),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(method.description),
          const SizedBox(height: 4),
          Text(
            "Identifier: ${config.identifier}",
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
          Text(
            "Integration ID: ${config.integrationId}",
            style: const TextStyle(fontSize: 12, color: Colors.blue),
          ),
        ],
      ),
      trailing: ElevatedButton(
        onPressed: () => _processPayment(method),
        child: const Text("Pay"),
      ),
    ),
  );
}
```

### **Environment Indicator**
```dart
Container(
  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
  decoration: BoxDecoration(
    color: ConfigManager.isTest ? Colors.orange : Colors.green,
    borderRadius: BorderRadius.circular(20),
  ),
  child: Text(
    "Environment: ${ConfigManager.currentEnvironment.name.toUpperCase()}",
    style: const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 12,
    ),
  ),
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
  _showErrorDialog("Initialization Error", e.message);
} on PaymentMethodNotAvailableException catch (e) {
  _showErrorDialog("Payment Method Error", e.message);
} on InvalidApiKeyException catch (e) {
  _showErrorDialog("API Key Error", e.message);
} catch (e) {
  _showErrorDialog("Unexpected Error", e.toString());
}
```

## 🚀 Deployment

### **Development**
```dart
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Set to test environment
  ConfigManager.setEnvironment(Environment.test);
  
  // Initialize with test configuration
  final config = ConfigManager.currentConfig;
  PaymobFlutter.instance.initializeWithConfig(
    apiKey: config.apiKey,
    paymentMethods: config.paymentMethods,
    iframes: config.iframes,
    defaultIntegrationId: config.defaultIntegrationId,
  );
  
  runApp(const MyApp());
}
```

### **Production**
```dart
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Set to live environment
  ConfigManager.setEnvironment(Environment.live);
  
  // Initialize with live configuration
  final config = ConfigManager.currentConfig;
  PaymobFlutter.instance.initializeWithConfig(
    apiKey: config.apiKey,
    paymentMethods: config.paymentMethods,
    iframes: config.iframes,
    defaultIntegrationId: config.defaultIntegrationId,
  );
  
  runApp(const MyApp());
}
```

## 📱 Screenshots

### **Main Screen**
- Environment indicator
- Payment method selection
- Iframe options

### **Payment Processing**
- Secure payment flow
- Real-time status updates
- Error handling

### **Configuration**
- Environment switching
- Payment method configuration
- Integration ID management

## 🔧 Customization

### **Adding New Payment Methods**
```dart
// Add to PaymobPaymentMethod enum
enum PaymobPaymentMethod {
  // ... existing methods
  newPaymentMethod,
}

// Add to extension
extension PaymobPaymentMethodExtension on PaymobPaymentMethod {
  String get identifier {
    switch (this) {
      // ... existing cases
      case PaymobPaymentMethod.newPaymentMethod:
        return 'NEW_PAYMENT_METHOD';
    }
  }
}
```

### **Custom UI Components**
```dart
class CustomPaymentButton extends StatelessWidget {
  final PaymobPaymentMethod method;
  final VoidCallback onPressed;
  
  const CustomPaymentButton({
    Key? key,
    required this.method,
    required this.onPressed,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      // Your custom UI here
    );
  }
}
```

## 🧪 Testing

### **Unit Tests**
```dart
void main() {
  group('Payment Tests', () {
    test('should process payment successfully', () async {
      // Test implementation
    });
  });
}
```

### **Widget Tests**
```dart
void main() {
  testWidgets('should display payment methods', (tester) async {
    // Widget test implementation
  });
}
```

## 📊 Performance

- **Fast Initialization** - Optimized startup time
- **Efficient Memory Usage** - Minimal memory footprint
- **Smooth UI** - 60fps animations and transitions
- **Network Optimization** - Efficient API communication

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License.

## 🆘 Support

- **Documentation** - [Full Documentation](https://pub.dev/documentation/pay_with_paymob_flutter)
- **Issues** - [Report Issues](https://github.com/your-username/pay_with_paymob_flutter/issues)
- **Discussions** - [GitHub Discussions](https://github.com/your-username/pay_with_paymob_flutter/discussions)

---

**Made with ❤️ for the Flutter community**