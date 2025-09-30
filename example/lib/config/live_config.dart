import 'package:pay_with_paymob_flutter/paymob_flutter.dart';
import 'app_config.dart';

/// Live/Production configuration
class LiveConfig {
  static AppConfig get config => AppConfig(
     apiKey: "ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SmpiR0Z6Y3lJNklrMWxjbU5vWVc1MElpd2ljSEp2Wm1sc1pWOXdheUk2T0RNMU1ERXlMQ0p1WVcxbElqb2lNVFk0T0RrNU9USXdOQzR3TURrNE5ETWlmUS5fX1dORVJNb3h3enBkeFZycjBmX0dXRWNkQnFuSUU0MFRPVElhSkl1LVQ1eXZKRXpFWnFXQngtTWd5T2t1TElaMkJJckg2ZkZ2SWpEb3kwbm13UHc0Zw==",
       publicKey: "egy_pk_live_7HrErHpj5XXQ2D3TDW7ldTrEajtXYkPM",
    secretKey: "egy_sk_live_34a4925414ec1b4cac9f5bbefab4e099953b9e76c1407e759260c366a6471c78",
    paymentMethods: [
      const PaymentMethodConfig(
        paymentMethod: PaymobPaymentMethod.custom,
        identifier: '4029829', // Integration ID for Apple Pay
        integrationId: '4029829',
        customSubtype: 'card',
        displayName: 'OnLine Card',
        description: 'Pay securely with OnLine Card',
      ),
      const PaymentMethodConfig(
        paymentMethod: PaymobPaymentMethod.applePay,
        identifier: '4833395', // Live Integration ID for Apple Pay (Online Card)
        integrationId: '4833395',
        customSubtype: "APPLE_PAY",
        displayName: "Apple Pay",
        description: "Pay securely with Apple Pay",
      ),
      const PaymentMethodConfig(
        paymentMethod: PaymobPaymentMethod.valu,
        identifier: '5265795', // Live Integration ID for ValU
        integrationId: '5265795',
        customSubtype: "VALU",
        displayName: "ValU",
        description: "Buy now, pay later with ValU",
      ),
      const PaymentMethodConfig(
        paymentMethod: PaymobPaymentMethod.bankInstallments,
        identifier: '4036625', // Live Integration ID for bank installments (MID_TAKSEET)
        integrationId: '4036625',
        customSubtype: "BANK_INSTALLMENTS",
        displayName: "Bank Installments",
        description: "Pay in installments with your bank",
      ),
      const PaymentMethodConfig(
        paymentMethod: PaymobPaymentMethod.souhoolaV3,
        identifier: '4320916', // Live Integration ID for Souhoola (HOST)
        integrationId: '4320916',
        customSubtype: "SOUHOOLA_V3",
        displayName: "Souhoola V3",
        description: "Souhoola V3 payment service",
      ),
      const PaymentMethodConfig(
        paymentMethod: PaymobPaymentMethod.amanV3,
        identifier: '4955437', // Live Integration ID for Aman (AMANV3)
        integrationId: '4955437',
        customSubtype: "AMAN_V3",
        displayName: "Aman V3",
        description: "Aman V3 payment service",
      ),
      const PaymentMethodConfig(
        paymentMethod: PaymobPaymentMethod.forsa,
        identifier: '4028165', // Live Integration ID for Forsa (HOST)
        integrationId: '4028165',
        customSubtype: "FORSA",
        displayName: "Forsa",
        description: "Forsa payment service",
      ),
      const PaymentMethodConfig(
        paymentMethod: PaymobPaymentMethod.premium,
        identifier: '4609366', // Live Integration ID for Premium (HOST)
        integrationId: '4609366',
        customSubtype: "PREMIUM",
        displayName: "Premium",
        description: "Premium payment service",
      ),
      const PaymentMethodConfig(
        paymentMethod: PaymobPaymentMethod.contact,
        identifier: '5005227', // Live Integration ID for Contact (HOST)
        integrationId: '5005227',
        customSubtype: "CONTACT",
        displayName: "Contact",
        description: "Contact payment service",
      ),
      const PaymentMethodConfig(
        paymentMethod: PaymobPaymentMethod.halan,
        identifier: '4626046', // Live Integration ID for HALAN (SUBSCRIPTION)
        integrationId: '4626046',
        customSubtype: "HALAN",
        displayName: "HALAN",
        description: "HALAN payment service",
      ),
      const PaymentMethodConfig(
        paymentMethod: PaymobPaymentMethod.sympl,
        identifier: '5186925', // Live Integration ID for SYMPL (valU)
        integrationId: '5186925',
        customSubtype: "SYMPL",
        displayName: "SYMPL",
        description: "SYMPL payment service",
      ),
      const PaymentMethodConfig(
        paymentMethod: PaymobPaymentMethod.kiosk,
        identifier: '4833395', // Live Integration ID for Kiosk (Online Card)
        integrationId: '4833395',
        customSubtype: "kiosk",
        displayName: "Kiosk",
        description: "Pay at kiosk locations",
      ),
      const PaymentMethodConfig(
        paymentMethod: PaymobPaymentMethod.wallet,
        identifier: '4037352', // Live Integration ID for Wallet (valU)
        integrationId: '4037352',
        customSubtype: "WALLET",
        displayName: "Wallet",
        description: "Digital wallet payment",
      ),
    ],
    
    iframes: [
      PaymobIframe(
        iframeId: 769581,
        integrationId: 4833395, // MID_TAKSEET for Installment_Discount
        name: "Live Installment_Discount",
        description: "Live Installment / Discount IFrame",
      ),
      PaymobIframe(
        iframeId: 769582,
        integrationId: 4833395, // Online Card for My new card Iframe
        name: "Live My new card Iframe",
        description: "Live My new card iframe",
      ),
      PaymobIframe(
        iframeId: 769630,
        integrationId: 5186925, // valU for valU iframe
        name: "Live valU",
        description: "Live valU iFrame",
      ),
      PaymobIframe(
        iframeId: 772170,
        integrationId: 4320916, // HOST for SOUHOOLA V2
        name: "Live SOUHOOLA V2",
        description: "Live SOUHOOLA V2 IFRAME",
      ),
      PaymobIframe(
        iframeId: 774030,
        integrationId: 4028165, // HOST for Forsa
        name: "Live Forsa",
        description: "Live Forsa Iframe",
      ),
      PaymobIframe(
        iframeId: 857738,
        integrationId: 4609366, // HOST for Premium6
        name: "Live Premium6",
        description: "Live Premium6 Iframe",
      ),
    ],
    
    defaultIntegrationId: 4833395, // Using Online Card integration ID as default
  );
}
