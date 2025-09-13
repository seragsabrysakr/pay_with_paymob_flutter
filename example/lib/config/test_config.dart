import 'package:pay_with_paymob_flutter/paymob_flutter.dart';
import 'app_config.dart';

/// Test/Development configuration
class TestConfig {
  static AppConfig get config => AppConfig(
    apiKey: "ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SmpiR0Z6Y3lJNklrMWxjbU5vWVc1MElpd2ljSEp2Wm1sc1pWOXdheUk2T0RNMU1ERXlMQ0p1WVcxbElqb2lNVFk0T0RrNU9USXdOQzR3TURrNE5ETWlmUS5fX1dORVJNb3h3enBkeFZycjBmX0dXRWNkQnFuSUU0MFRPVElhSkl1LVQ1eXZKRXpFWnFXQngtTWd5T2t1TElaMkJJckg2ZkZ2SWpEb3kwbm13UHc0Zw==",
    
    paymentMethods: [
      const PaymentMethodConfig(
        paymentMethod: PaymobPaymentMethod.custom,
        identifier: 3958578, // Integration ID for Apple Pay
        customSubtype: 'card',
        displayName: 'OnLine Card',
        description: 'Pay securely with OnLine Card',
      ),
      const PaymentMethodConfig(
        paymentMethod: PaymobPaymentMethod.applePay,
        identifier: 3958578, // Integration ID for Apple Pay
        customSubtype: 'APPLE_PAY',
        displayName: 'Apple Pay',
        description: 'Pay securely with Apple Pay',
      ),
      const PaymentMethodConfig(
        paymentMethod: PaymobPaymentMethod.valu,
        identifier: 3958485, // Integration ID for ValU
        customSubtype: 'VALU',
        displayName: 'ValU',
        description: 'Buy now, pay later with ValU',
      ),
      const PaymentMethodConfig(
        paymentMethod: PaymobPaymentMethod.bankInstallments,
        identifier: 3958578, // Integration ID for bank installments
        customSubtype: 'BANK_INSTALLMENTS',
        displayName: 'Bank Installments',
        description: 'Pay in installments with your bank',
      ),
      const PaymentMethodConfig(
        paymentMethod: PaymobPaymentMethod.souhoolaV3,
        identifier: 123456, // Integration ID for Souhoola
        customSubtype: 'SOUHOOLA_V3',
        displayName: 'Souhoola V3',
        description: 'Souhoola V3 payment service',
      ),
      const PaymentMethodConfig(
        paymentMethod: PaymobPaymentMethod.amanV3,
        identifier: 123456, // Integration ID for Aman
        customSubtype: 'AMAN_V3',
        displayName: 'Aman V3',
        description: 'Aman V3 payment service',
      ),
      const PaymentMethodConfig(
        paymentMethod: PaymobPaymentMethod.forsa,
        identifier: 123456, // Integration ID for Forsa
        customSubtype: 'FORSA',
        displayName: 'Forsa',
        description: 'Forsa payment service',
      ),
      const PaymentMethodConfig(
        paymentMethod: PaymobPaymentMethod.premium,
        identifier: 123456, // Integration ID for Premium
        customSubtype: 'PREMIUM',
        displayName: 'Premium',
        description: 'Premium payment service',
      ),
      const PaymentMethodConfig(
        paymentMethod: PaymobPaymentMethod.contact,
        identifier: 123456, // Integration ID for Contact
        customSubtype: 'CONTACT',
        displayName: 'Contact',
        description: 'Contact payment service',
      ),
      const PaymentMethodConfig(
        paymentMethod: PaymobPaymentMethod.halan,
        identifier: 123456, // Integration ID for HALAN
        customSubtype: 'HALAN',
        displayName: 'HALAN',
        description: 'HALAN payment service',
      ),
      const PaymentMethodConfig(
        paymentMethod: PaymobPaymentMethod.sympl,
        identifier: 123456, // Integration ID for SYMPL
        customSubtype: 'SYMPL',
        displayName: 'SYMPL',
        description: 'SYMPL payment service',
      ),
      const PaymentMethodConfig(
        paymentMethod: PaymobPaymentMethod.kiosk,
        identifier: 123456, // Integration ID for Kiosk
        customSubtype: 'kiosk',
        displayName: 'Kiosk',
        description: 'Pay at kiosk locations',
      ),
      const PaymentMethodConfig(
        paymentMethod: PaymobPaymentMethod.wallet,
        identifier: 5274118, // Integration ID for Wallet
        customSubtype: 'WALLET',
        displayName: 'Wallet',
        description: 'Digital wallet payment',
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
