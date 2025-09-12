import 'package:flutter/material.dart';
import 'package:pay_with_paymob_flutter/paymob_flutter.dart';
import 'config/config_manager.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Set the environment (change this to Environment.live for production)
  ConfigManager.setEnvironment(Environment.live);

  // Get configuration from the selected environment
  final config = ConfigManager.currentConfig;

  // Initialize Paymob with the configuration
  PaymobFlutter.instance.initializeWithConfig(
    apiKey: config.apiKey,
    paymentMethods: config.paymentMethods,
    iframes: config.iframes,
    defaultIntegrationId: config.defaultIntegrationId,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Paymob'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget _buildPaymentMethodCard(PaymobPaymentMethod method) {
    // Get the configuration for this payment method
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
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
                fontStyle: FontStyle.italic,
              ),
            ),
            Text(
              "Integration ID: ${config.integrationId}",
              style: const TextStyle(
                fontSize: 12,
                color: Colors.blue,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
        trailing: ElevatedButton(
          onPressed: () {
            // Now you can call payWithCustomMethod without specifying identifier
            // The system will automatically use the configured identifier from initialization
            PaymobFlutter.instance.payWithCustomMethod(
              context: context,
              paymentMethod: method,
              currency: "EGP",
              amount: 100,
              billingData: BillingData(
                firstName: "John",
                lastName: "Doe",
                email: "john.doe@example.com",
                phoneNumber: "01010101010",
                apartment: "123",
                building: "123",
                postalCode: "12345",
                city: "Anytown",
                state: "CA",
                country: "USA",
                floor: "1",
                street: "123 Main St",
                shippingMethod: "Standard",
              ),
              // identifier is now optional - will use the configured identifier from initialization
              // identifier: "custom_identifier", // You can still override with custom identifier
              onPayment: (response) {
                response.success == true
                    ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                            "${method.displayName} Payment: ${response.message ?? "Success"}")))
                    : ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                            "${method.displayName} Payment: ${response.message ?? "Failed"}")));
              },
            );
          },
          child: const Text("Pay"),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "Welcome to Paymob Payment Demo",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              // Environment indicator and switcher
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
                  ),
                  // Environment switcher (for testing purposes)
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        ConfigManager.setEnvironment(
                          ConfigManager.isTest ? Environment.live : Environment.test,
                        );
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ConfigManager.isTest ? Colors.green : Colors.orange,
                      foregroundColor: Colors.white,
                    ),
                    child: Text(
                      "Switch to ${ConfigManager.isTest ? 'LIVE' : 'TEST'}",
                      style: const TextStyle(fontSize: 10),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                "Choose from the available payment methods and iframes below:",
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 20),
              const Text(
                "Digital Wallets & Payment Methods:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              // Digital Wallets
              const Text(
                "Digital Wallets:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 5),
              ...PaymobFlutter.instance.availablePaymentMethods
                  .where((method) => [
                        PaymobPaymentMethod.applePay,
                        PaymobPaymentMethod.wallet
                      ].contains(method))
                  .map((method) => _buildPaymentMethodCard(method)),
              const SizedBox(height: 10),
              // Installment Services
              const Text(
                "Installment Services:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 5),
              ...PaymobFlutter.instance.availablePaymentMethods
                  .where((method) => [
                        PaymobPaymentMethod.valu,
                        PaymobPaymentMethod.bankInstallments,
                        PaymobPaymentMethod.souhoolaV3,
                        PaymobPaymentMethod.amanV3,
                        PaymobPaymentMethod.forsa,
                        PaymobPaymentMethod.premium
                      ].contains(method))
                  .map((method) => _buildPaymentMethodCard(method)),
              const SizedBox(height: 10),
              // Other Services
              const Text(
                "Other Services:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 5),
              ...PaymobFlutter.instance.availablePaymentMethods
                  .where((method) => [
                        PaymobPaymentMethod.contact,
                        PaymobPaymentMethod.halan,
                        PaymobPaymentMethod.sympl,
                        PaymobPaymentMethod.kiosk,
                        PaymobPaymentMethod.custom
                      ].contains(method))
                  .map((method) => _buildPaymentMethodCard(method)),
              const SizedBox(height: 20),
              const Text(
                "Available Iframes:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ...PaymobFlutter.instance.availableIframes
                  .map((iframe) => Card(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        child: ListTile(
                          title:
                              Text(iframe.name ?? "Iframe ${iframe.iframeId}"),
                          subtitle: Text(iframe.description ?? ""),
                          trailing: ElevatedButton(
                            onPressed: () {
                              PaymobFlutter.instance.payWithIframe(
                                context: context,
                                iframe: iframe,
                                currency: "EGP",
                                amount: 100,
                                onPayment: (response) {
                                  response.success == true
                                      ? ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(response.message ??
                                                  "Success")))
                                      : ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(response.message ??
                                                  "Payment failed")));
                                },
                              );
                            },
                            child: const Text("Pay"),
                          ),
                        ),
                      ))
                  .toList(),
            ],
          ),
        ),
      ),
    );
  }
}
