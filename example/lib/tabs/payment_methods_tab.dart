import 'package:flutter/material.dart';
import 'package:pay_with_paymob_flutter/paymob_flutter.dart';

class PaymentMethodsTab extends StatefulWidget {
  const PaymentMethodsTab({super.key});

  @override
  State<PaymentMethodsTab> createState() => _PaymentMethodsTabState();
}

class _PaymentMethodsTabState extends State<PaymentMethodsTab> {
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
            await _payWithMethod(config);
          },
          child: const Text("Pay"),
        ),
      ),
    );
  }

  Future<void> _payWithMethod(PaymentMethodConfig method) async {
    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    try {
      await PaymobFlutter.instance.payWithCustomMethod(
        context: context,
        paymentMethod: method,
        currency: "EGP",
        amount: 100,
        billingData: BillingData(
          firstName: "serag",
          lastName: "sakr",
          email: "serag.sakr@example.com",
          phoneNumber: "01010101010",
          apartment: "123",
          building: "123",
          postalCode: "12345",
          city: "Cairo",
          state: "Cairo",
          country: "Egypt",
          floor: "1",
          street: "123 Main St",
          shippingMethod: "Standard",
        ),
        onPayment: (response) {
          print('onPayment response: ${response.toString()}');
          if (response.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("${method.displayName} Payment: ${response.message ?? "Success"} Transaction ID: ${response.transactionID}"),
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
            content: Text("Failed to process payment: $e"),
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
              "Payment Methods",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "Choose from the available payment methods below:",
              style: TextStyle(fontSize: 14),
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
