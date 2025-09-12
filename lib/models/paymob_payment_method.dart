/// Enum representing different Paymob payment methods
enum PaymobPaymentMethod {
  /// Apple Pay
  applePay,
  
  /// ValU installment service
  valu,
  
  /// Bank Installments
  bankInstallments,
  
  /// Souhoola V3
  souhoolaV3,
  
  /// Aman V3
  amanV3,
  
  /// Forsa
  forsa,
  
  /// Premium
  premium,
  
  /// Contact
  contact,
  
  /// HALAN
  halan,
  
  /// SYMPL
  sympl,
  
  /// Kiosk
  kiosk,
  
  /// Generic wallet
  wallet,
  
  /// Custom payment method
  custom,
}

/// Extension to get string values and descriptions for payment methods
extension PaymobPaymentMethodExtension on PaymobPaymentMethod {
  /// Get the string identifier for the payment method
  String get identifier {
    switch (this) {
      case PaymobPaymentMethod.applePay:
        return 'APPLE_PAY';
      case PaymobPaymentMethod.valu:
        return 'VALU';
      case PaymobPaymentMethod.bankInstallments:
        return 'BANK_INSTALLMENTS';
      case PaymobPaymentMethod.souhoolaV3:
        return 'SOUHOOLA_V3';
      case PaymobPaymentMethod.amanV3:
        return 'AMAN_V3';
      case PaymobPaymentMethod.forsa:
        return 'FORSA';
      case PaymobPaymentMethod.premium:
        return 'PREMIUM';
      case PaymobPaymentMethod.contact:
        return 'CONTACT';
      case PaymobPaymentMethod.halan:
        return 'HALAN';
      case PaymobPaymentMethod.sympl:
        return 'SYMPL';
      case PaymobPaymentMethod.kiosk:
        return 'kiosk';
      case PaymobPaymentMethod.wallet:
        return 'WALLET';
      case PaymobPaymentMethod.custom:
        return 'CUSTOM';
    }
  }
  
  /// Get the subtype for the payment method
  String get subtype {
    switch (this) {
      case PaymobPaymentMethod.applePay:
        return 'APPLE_PAY';
      case PaymobPaymentMethod.valu:
        return 'VALU';
      case PaymobPaymentMethod.bankInstallments:
        return 'BANK_INSTALLMENTS';
      case PaymobPaymentMethod.souhoolaV3:
        return 'SOUHOOLA_V3';
      case PaymobPaymentMethod.amanV3:
        return 'AMAN_V3';
      case PaymobPaymentMethod.forsa:
        return 'FORSA';
      case PaymobPaymentMethod.premium:
        return 'PREMIUM';
      case PaymobPaymentMethod.contact:
        return 'CONTACT';
      case PaymobPaymentMethod.halan:
        return 'HALAN';
      case PaymobPaymentMethod.sympl:
        return 'SYMPL';
      case PaymobPaymentMethod.kiosk:
        return 'kiosk';
      case PaymobPaymentMethod.wallet:
        return 'WALLET';
      case PaymobPaymentMethod.custom:
        return 'CUSTOM';
    }
  }
  
  /// Get a user-friendly display name
  String get displayName {
    switch (this) {
      case PaymobPaymentMethod.applePay:
        return 'Apple Pay';
      case PaymobPaymentMethod.valu:
        return 'ValU';
      case PaymobPaymentMethod.bankInstallments:
        return 'Bank Installments';
      case PaymobPaymentMethod.souhoolaV3:
        return 'Souhoola V3';
      case PaymobPaymentMethod.amanV3:
        return 'Aman V3';
      case PaymobPaymentMethod.forsa:
        return 'Forsa';
      case PaymobPaymentMethod.premium:
        return 'Premium';
      case PaymobPaymentMethod.contact:
        return 'Contact';
      case PaymobPaymentMethod.halan:
        return 'HALAN';
      case PaymobPaymentMethod.sympl:
        return 'SYMPL';
      case PaymobPaymentMethod.kiosk:
        return 'kiosk';
      case PaymobPaymentMethod.wallet:
        return 'Wallet';
      case PaymobPaymentMethod.custom:
        return 'Custom';
    }
  }
  
  /// Get a description of the payment method
  String get description {
    switch (this) {
      case PaymobPaymentMethod.applePay:
        return 'Pay securely with Apple Pay';
      case PaymobPaymentMethod.valu:
        return 'Buy now, pay later with ValU';
      case PaymobPaymentMethod.bankInstallments:
        return 'Pay in installments with your bank';
      case PaymobPaymentMethod.souhoolaV3:
        return 'Souhoola V3 payment service';
      case PaymobPaymentMethod.amanV3:
        return 'Aman V3 payment service';
      case PaymobPaymentMethod.forsa:
        return 'Forsa payment service';
      case PaymobPaymentMethod.premium:
        return 'Premium payment service';
      case PaymobPaymentMethod.contact:
        return 'Contact payment service';
      case PaymobPaymentMethod.halan:
        return 'HALAN payment service';
      case PaymobPaymentMethod.sympl:
        return 'SYMPL payment service';
      case PaymobPaymentMethod.kiosk:
        return 'Pay at kiosk locations';
      case PaymobPaymentMethod.wallet:
        return 'Digital wallet payment';
      case PaymobPaymentMethod.custom:
        return 'Custom payment method';
    }
  }
  
  /// Get the default identifier for the payment method
  /// This provides sensible defaults that can be used when no specific identifier is provided
  String get defaultIdentifier {
    switch (this) {
      case PaymobPaymentMethod.applePay:
        return 'user@example.com'; // Email for Apple Pay
      case PaymobPaymentMethod.valu:
        return '01010101010'; // Phone number for ValU
      case PaymobPaymentMethod.bankInstallments:
        return '01010101010'; // Phone number for bank installments
      case PaymobPaymentMethod.souhoolaV3:
        return '01010101010'; // Phone number for Souhoola
      case PaymobPaymentMethod.amanV3:
        return '01010101010'; // Phone number for Aman
      case PaymobPaymentMethod.forsa:
        return '01010101010'; // Phone number for Forsa
      case PaymobPaymentMethod.premium:
        return '01010101010'; // Phone number for Premium
      case PaymobPaymentMethod.contact:
        return '01010101010'; // Phone number for Contact
      case PaymobPaymentMethod.halan:
        return '01010101010'; // Phone number for HALAN
      case PaymobPaymentMethod.sympl:
        return '01010101010'; // Phone number for SYMPL
      case PaymobPaymentMethod.kiosk:
        return 'KIOSK_001'; // Kiosk identifier
      case PaymobPaymentMethod.wallet:
        return 'wallet_user_001'; // Wallet user identifier
      case PaymobPaymentMethod.custom:
        return 'custom_user_001'; // Custom identifier
    }
  }
}
