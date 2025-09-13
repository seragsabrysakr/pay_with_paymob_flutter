import 'package:flutter/material.dart';
import 'package:pay_with_paymob_flutter/paymob_flutter.dart';
import '../config/config_manager.dart';

class PaymentLinksTab extends StatefulWidget {
  const PaymentLinksTab({super.key});

  @override
  State<PaymentLinksTab> createState() => _PaymentLinksTabState();
}

class _PaymentLinksTabState extends State<PaymentLinksTab> {
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
          onPressed: () async {
            await _createPaymentLink(config);
          },
          child: const Text("Create Link"),
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
      // Create payment link request
      PaymentLinkRequest request = PaymentLinkRequest.fromAmount(
        amount: 1.0,
        paymentMethods: [method.identifier],
        email: "serag.sakr@example.com",
        fullName: "serag sakr",
        phoneNumber: "01010101010",
        description: "Test payment link from Flutter app",
        isLive: ConfigManager.isLive,
      );

      // Create and open payment link
      final config = ConfigManager.currentConfig;
      await PaymobFlutter.instance.createPayLink(
        context: context,
        apiKey: config.apiKey,
        request: request,
        title: const Text('Payment Link'),
        onPayment: (response) {
          if (response.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("${method.displayName} Payment: ${response.message ?? "Success"}"),
                backgroundColor: Colors.green,
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("${method.displayName} Payment: ${response.message ?? "Failed"}"),
                backgroundColor: Colors.red,
              ),
            );
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
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "Payment Links",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "Create shareable payment links for customers:",
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 20),
            
            // Info Card
            Card(
              color: Colors.green.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.info, color: Colors.green.shade700),
                        const SizedBox(width: 8),
                        Text(
                          "About Payment Links",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.green.shade700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Payment links allow you to create shareable URLs that customers can use to make payments. "
                      "They can be sent via SMS, email, or any messaging platform. "
                      "Customers complete the payment without being redirected back to your app.",
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 20),
            
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
                    ].contains(config.paymentMethod))
                .map((config) => _buildPaymentMethodCard(config)),
          ],
        ),
      ),
    );
  }
}
