import 'package:pay_with_paymob_flutter/paymob_flutter.dart';
import 'app_config.dart';

/// Test/Development configuration
class TestConfig {
  static AppConfig get config => AppConfig(
    apiKey: "ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SmpiR0Z6Y3lJNklrMWxjbU5vWVc1MElpd2ljSEp2Wm1sc1pWOXdheUk2T0RNMU1ERXlMQ0p1WVcxbElqb2lNVFk0T0RrNU9USXdOQzR3TURrNE5ETWlmUS5fX1dORVJNb3h3enBkeFZycjBmX0dXRWNkQnFuSUU0MFRPVElhSkl1LVQ1eXZKRXpFWnFXQngtTWd5T2t1TElaMkJJckg2ZkZ2SWpEb3kwbm13UHc0Zw==",
    
    paymentMethods: [
      PaymentMethodConfig.withDefault(
        paymentMethod: PaymobPaymentMethod.applePay,
        integrationId: 3958578, // Integration ID for Apple Pay
      ),
      PaymentMethodConfig.withDefault(
        paymentMethod: PaymobPaymentMethod.valu,
        integrationId: 3958485, // Integration ID for ValU
      ),
      PaymentMethodConfig.withDefault(
        paymentMethod: PaymobPaymentMethod.bankInstallments,
        integrationId: 3958578, // Integration ID for bank installments
      ),
      PaymentMethodConfig.withDefault(
        paymentMethod: PaymobPaymentMethod.souhoolaV3,
        integrationId: 123456, // Integration ID for Souhoola
      ),
      PaymentMethodConfig.withDefault(
        paymentMethod: PaymobPaymentMethod.amanV3,
        integrationId: 123456, // Integration ID for Aman
      ),
      PaymentMethodConfig.withDefault(
        paymentMethod: PaymobPaymentMethod.forsa,
        integrationId: 123456, // Integration ID for Forsa
      ),
      PaymentMethodConfig.withDefault(
        paymentMethod: PaymobPaymentMethod.premium,
        integrationId: 123456, // Integration ID for Premium
      ),
      PaymentMethodConfig.withDefault(
        paymentMethod: PaymobPaymentMethod.contact,
        integrationId: 123456, // Integration ID for Contact
      ),
      PaymentMethodConfig.withDefault(
        paymentMethod: PaymobPaymentMethod.halan,
        integrationId: 123456, // Integration ID for HALAN
      ),
      PaymentMethodConfig.withDefault(
        paymentMethod: PaymobPaymentMethod.sympl,
        integrationId: 123456, // Integration ID for SYMPL
      ),
      PaymentMethodConfig.withDefault(
        paymentMethod: PaymobPaymentMethod.kiosk,
        integrationId: 123456, // Integration ID for Kiosk
      ),
      PaymentMethodConfig.withDefault(
        paymentMethod: PaymobPaymentMethod.wallet,
        integrationId: 5274118, // Integration ID for Wallet
      ),
    ],
    
    iframes: [
      PaymobIframe(
        iframeId: 769581,
        integrationId: 3958578,
        name: "Installment_Discount",
        description: "Installment / Discount IFrame",
      ),
      PaymobIframe(
        iframeId: 769582,
        integrationId: 3958578,
        name: "My new card Iframe",
        description: "This my new card iframe",
      ),
      PaymobIframe(
        iframeId: 769630,
        integrationId: 3959581,
        name: "valU",
        description: "valU iFrame",
      ),
      PaymobIframe(
        iframeId: 772170,
        integrationId: 123456,
        name: "SOUHOOLA V2",
        description: "SOUHOOLA V2 IFRAME",
      ),
      PaymobIframe(
        iframeId: 774030,
        integrationId: 123456,
        name: "Forsa",
        description: "Forsa Iframe",
      ),
      PaymobIframe(
        iframeId: 857738,
        integrationId: 123456,
        name: "Premium6",
        description: "Premium6 Iframe",
      ),
    ],
    
    defaultIntegrationId: 123456,
  );
}
