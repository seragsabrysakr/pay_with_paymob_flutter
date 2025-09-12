import 'package:pay_with_paymob_flutter/paymob_flutter.dart';
import 'app_config.dart';

/// Live/Production configuration
class LiveConfig {
  static AppConfig get config => AppConfig(
     apiKey: "ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SmpiR0Z6Y3lJNklrMWxjbU5vWVc1MElpd2ljSEp2Wm1sc1pWOXdheUk2T0RNMU1ERXlMQ0p1WVcxbElqb2lNVFk0T0RrNU9USXdOQzR3TURrNE5ETWlmUS5fX1dORVJNb3h3enBkeFZycjBmX0dXRWNkQnFuSUU0MFRPVElhSkl1LVQ1eXZKRXpFWnFXQngtTWd5T2t1TElaMkJJckg2ZkZ2SWpEb3kwbm13UHc0Zw==",
    
    paymentMethods: [
      PaymentMethodConfig.custom(
        identifier: "",
        paymentMethod: PaymobPaymentMethod.applePay,
        integrationId: 4833395, // Live Integration ID for Apple Pay (Online Card)
      ),
      PaymentMethodConfig.custom(
        identifier: "",
        paymentMethod: PaymobPaymentMethod.valu,
        integrationId: 5265795, // Live Integration ID for ValU
      ),
      PaymentMethodConfig.custom(
        identifier: "",
        paymentMethod: PaymobPaymentMethod.bankInstallments,
        integrationId: 5090202, // Live Integration ID for bank installments (MID_TAKSEET)
      ),
      PaymentMethodConfig.custom(
        identifier: "",
        paymentMethod: PaymobPaymentMethod.souhoolaV3,
        integrationId: 4320916, // Live Integration ID for Souhoola (HOST)
      ),
      PaymentMethodConfig.custom(
        identifier: "",
        paymentMethod: PaymobPaymentMethod.amanV3,
        integrationId: 4955437, // Live Integration ID for Aman (AMANV3)
      ),
      PaymentMethodConfig.custom(
        identifier: "",
        paymentMethod: PaymobPaymentMethod.forsa,
        integrationId: 4028165, // Live Integration ID for Forsa (HOST)
      ),
      PaymentMethodConfig.custom(
        identifier: "",
        paymentMethod: PaymobPaymentMethod.premium,
        integrationId: 4609366, // Live Integration ID for Premium (HOST)
      ),
      PaymentMethodConfig.custom(
        identifier: "",
        paymentMethod: PaymobPaymentMethod.contact,
        integrationId: 5005227, // Live Integration ID for Contact (HOST)
      ),
      PaymentMethodConfig.custom(
        identifier: "",
        paymentMethod: PaymobPaymentMethod.halan,
        integrationId: 4626046, // Live Integration ID for HALAN (SUBSCRIPTION)
      ),
      PaymentMethodConfig.custom(
        identifier: "",
        paymentMethod: PaymobPaymentMethod.sympl,
        integrationId: 5186925, // Live Integration ID for SYMPL (valU)
      ),
      PaymentMethodConfig.custom(
        identifier: "",
        paymentMethod: PaymobPaymentMethod.kiosk,
        integrationId: 4833395, // Live Integration ID for Kiosk (Online Card)
      ),
      PaymentMethodConfig.custom(
        identifier: "",
        paymentMethod: PaymobPaymentMethod.wallet,
        integrationId: 4037352, // Live Integration ID for Wallet (valU)
      ),
    ],
    
    iframes: [
      PaymobIframe(
        iframeId: 769581,
        integrationId: 5090202, // MID_TAKSEET for Installment_Discount
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
        integrationId: 5265795, // valU for valU iframe
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
