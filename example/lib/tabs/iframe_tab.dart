import 'package:flutter/material.dart';
import 'package:pay_with_paymob_flutter/paymob_flutter.dart';

class IframeTab extends StatefulWidget {
  const IframeTab({super.key});

  @override
  State<IframeTab> createState() => _IframeTabState();
}

class _IframeTabState extends State<IframeTab> {
  Widget _buildIframeCard(PaymobIframe iframe) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        title: Text(iframe.name ?? "Iframe ${iframe.iframeId}"),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(iframe.description ?? ""),
            const SizedBox(height: 4),
            Text(
              "Iframe ID: ${iframe.iframeId}",
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
                fontStyle: FontStyle.italic,
              ),
            ),
            Text(
              "Integration ID: ${iframe.integrationId}",
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
            _payWithIframe(iframe);
          },
          child: const Text("Pay"),
        ),
      ),
    );
  }

  void _payWithIframe(PaymobIframe iframe) {
    PaymobFlutter.instance.payWithIframe(
      context: context,
      iframe: iframe,
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
        city: "Cairo",
        state: "Cairo",
        country: "Egypt",
        floor: "1",
        street: "123 Main St",
        shippingMethod: "Standard",
      ),
      onPayment: (response) {
        if (response.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("${iframe.name ?? 'Iframe'} Payment: ${response.message ?? "Success"}"),
              backgroundColor: Colors.green,
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("${iframe.name ?? 'Iframe'} Payment: ${response.message ?? "Failed"}"),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
    );
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
              "Iframe Payments",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "Pay using embedded iframe payment forms:",
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 20),
            
            // Available Iframes
            const Text(
              "Available Iframes:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            
            ...PaymobFlutter.instance.availableIframes
                .map((iframe) => _buildIframeCard(iframe))
                .toList(),
            
            const SizedBox(height: 20),
            
            // Info Card
            Card(
              color: Colors.blue.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.info, color: Colors.blue.shade700),
                        const SizedBox(width: 8),
                        Text(
                          "About Iframe Payments",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Iframe payments allow you to embed Paymob's payment forms directly into your app. "
                      "This provides a seamless payment experience without redirecting users to external pages.",
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
