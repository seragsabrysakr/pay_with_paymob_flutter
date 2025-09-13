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
  Widget _buildPaymentMethodCard(PaymentMethodConfig config) {

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 2),
      child: ListTile(
        title: Text(config.displayName),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(config.description),
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
              "Integration ID: ${config.identifier}",
              style: const TextStyle(
                fontSize: 12,
                color: Colors.blue,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
        trailing: ElevatedButton(
          onPressed: ()async {
          await _createPaymentLink(config);
          },
          child: const Text("Pay"),
        ),
      ),
    );
  }

  Future<void> _createPaymentLink(PaymentMethodConfig method) async {
    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    try {
      // Get the first available integration ID for payment methods
      
       // Create payment link request
      PaymentLinkRequest request = PaymentLinkRequest.fromAmount(
        amount: 1.0,  
        paymentMethods: [method.identifier], // Use the first available integration ID
        email: "customer@example.com",
        fullName: "John Doe",
        phoneNumber: "+201029382968",
        description: "Test payment link from Flutter app",
        isLive: ConfigManager.isLive, // Use current environment setting
      );

      // Create and open payment link (same pattern as other payment methods)
      final config = ConfigManager.currentConfig;
      await PaymobFlutter.instance.createPayLink(
        context: context,
        apiKey: config.apiKey, // Use the same API key from your config
        request: request,
        title: const Text('Payment Link'),
        onPayment: (response) {
          // Handle payment response
          if (response.success) {
            // need to show the message 
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response.message ?? "Success")));
            Navigator.of(context).pop();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response.message ?? "Failed")));
            Navigator.of(context).pop();
          }
        },
      );

      // Close loading dialog
      if (context.mounted) {
        Navigator.of(context).pop();
      }
    } catch (e) {
      // Close loading dialog
      if (context.mounted) {
        Navigator.of(context).pop();
      }

      // Show error dialog
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Error"),
            content: Text("Failed to create payment link: $e"),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("OK"),
              ),
            ],
          ),
        );
      }
    }
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
                "Create Payment Link:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                  .where((config) => [
                        PaymobPaymentMethod.custom,
                        PaymobPaymentMethod.applePay,
                        PaymobPaymentMethod.wallet
                      ].contains(config.paymentMethod))
                  .map((config) => _buildPaymentMethodCard(config)),
              const SizedBox(height: 10),
              // Installment Services
              const Text(
                "Installment Services:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 5),
              ...PaymobFlutter.instance.availablePaymentMethods
                  .where((config) => [
                        PaymobPaymentMethod.valu,
                        PaymobPaymentMethod.bankInstallments,
                        PaymobPaymentMethod.souhoolaV3,
                        PaymobPaymentMethod.amanV3,
                        PaymobPaymentMethod.forsa,
                        PaymobPaymentMethod.premium
                      ].contains(config.paymentMethod))
                  .map((config) => _buildPaymentMethodCard(config)),
              const SizedBox(height: 10),
              // Other Services
              const Text(
                "Other Services:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 5),
              ...PaymobFlutter.instance.availablePaymentMethods
                  .where((config) => [
                        PaymobPaymentMethod.contact,
                        PaymobPaymentMethod.halan,
                        PaymobPaymentMethod.sympl,
                        PaymobPaymentMethod.kiosk,
                        PaymobPaymentMethod.custom
                      ].contains(config.paymentMethod))
                  .map((config) => _buildPaymentMethodCard(config)),
            
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
