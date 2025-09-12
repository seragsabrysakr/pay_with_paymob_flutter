import 'package:flutter_test/flutter_test.dart';
import 'package:pay_with_paymob_flutter/paymob_flutter.dart';
import 'package:pay_with_paymob_flutter/core/exceptions/paymob_exceptions.dart';

void main() {
  group('PaymobFlutter Tests', () {
    late PaymobFlutter paymobFlutter;

    setUp(() {
      paymobFlutter = PaymobFlutter.instance;
    });

    test('should be a singleton instance', () {
      final instance1 = PaymobFlutter.instance;
      final instance2 = PaymobFlutter.instance;
      expect(instance1, equals(instance2));
    });

    test('should initialize with valid configuration', () async {
      final result = await paymobFlutter.initialize(
        apiKey: "test_api_key",
        paymentMethods: [PaymobPaymentMethod.valu],
        iframes: [
          PaymobIframe(
            iframeId: 123456,
            integrationId: 123456,
            name: "Test Iframe",
            description: "Test iframe description",
          ),
        ],
      );
      expect(result, isTrue);
    });

    test('should throw exception for empty API key', () async {
      expect(
        () async => await paymobFlutter.initialize(
          apiKey: "",
          paymentMethods: [PaymobPaymentMethod.valu],
          iframes: [
            PaymobIframe(
              iframeId: 123456,
              integrationId: 123456,
              name: "Test Iframe",
              description: "Test iframe description",
            ),
          ],
        ),
        throwsA(isA<InvalidApiKeyException>()),
      );
    });

    test('should throw exception for empty payment methods', () async {
      expect(
        () async => await paymobFlutter.initialize(
          apiKey: "test_api_key",
          paymentMethods: [],
          iframes: [
            PaymobIframe(
              iframeId: 123456,
              integrationId: 123456,
              name: "Test Iframe",
              description: "Test iframe description",
            ),
          ],
        ),
        throwsA(isA<PaymentInitializationException>()),
      );
    });

    test('should throw exception for empty iframes', () async {
      expect(
        () async => await paymobFlutter.initialize(
          apiKey: "test_api_key",
          paymentMethods: [PaymobPaymentMethod.valu],
          iframes: [],
        ),
        throwsA(isA<PaymentInitializationException>()),
      );
    });
  });

  group('PaymentMethodConfig Tests', () {
    test('should create custom configuration', () {
      final config = PaymentMethodConfig.custom(
        paymentMethod: PaymobPaymentMethod.valu,
        identifier: "test_identifier",
        integrationId: 123456,
      );

      expect(config.paymentMethod, equals(PaymobPaymentMethod.valu));
      expect(config.identifier, equals("test_identifier"));
      expect(config.integrationId, equals(123456));
    });

    test('should create default configuration', () {
      final config = PaymentMethodConfig.withDefault(
        paymentMethod: PaymobPaymentMethod.valu,
        integrationId: 123456,
      );

      expect(config.paymentMethod, equals(PaymobPaymentMethod.valu));
      expect(config.identifier, equals(PaymobPaymentMethod.valu.defaultIdentifier));
      expect(config.integrationId, equals(123456));
    });

    test('should support equality', () {
      final config1 = PaymentMethodConfig.custom(
        paymentMethod: PaymobPaymentMethod.valu,
        identifier: "test_identifier",
        integrationId: 123456,
      );

      final config2 = PaymentMethodConfig.custom(
        paymentMethod: PaymobPaymentMethod.valu,
        identifier: "test_identifier",
        integrationId: 123456,
      );

      expect(config1, equals(config2));
      expect(config1.hashCode, equals(config2.hashCode));
    });
  });

  group('PaymobPaymentMethod Tests', () {
    test('should have correct identifiers', () {
      expect(PaymobPaymentMethod.applePay.identifier, equals('APPLE_PAY'));
      expect(PaymobPaymentMethod.valu.identifier, equals('VALU'));
      expect(PaymobPaymentMethod.wallet.identifier, equals('WALLET'));
    });

    test('should have correct subtypes', () {
      expect(PaymobPaymentMethod.applePay.subtype, equals('APPLE_PAY'));
      expect(PaymobPaymentMethod.valu.subtype, equals('VALU'));
      expect(PaymobPaymentMethod.wallet.subtype, equals('WALLET'));
    });

    test('should have correct display names', () {
      expect(PaymobPaymentMethod.applePay.displayName, equals('Apple Pay'));
      expect(PaymobPaymentMethod.valu.displayName, equals('ValU'));
      expect(PaymobPaymentMethod.wallet.displayName, equals('Wallet'));
    });

    test('should have correct descriptions', () {
      expect(PaymobPaymentMethod.applePay.description, equals('Pay securely with Apple Pay'));
      expect(PaymobPaymentMethod.valu.description, equals('Buy now, pay later with ValU'));
      expect(PaymobPaymentMethod.wallet.description, equals('Digital wallet payment'));
    });

    test('should have correct default identifiers', () {
      expect(PaymobPaymentMethod.applePay.defaultIdentifier, equals('user@example.com'));
      expect(PaymobPaymentMethod.valu.defaultIdentifier, equals('01010101010'));
      expect(PaymobPaymentMethod.wallet.defaultIdentifier, equals('wallet_user_001'));
    });
  });

  group('BillingData Tests', () {
    test('should create billing data with all fields', () {
      final billingData = BillingData(
        firstName: "John",
        lastName: "Doe",
        email: "john@example.com",
        phoneNumber: "01012345678",
        apartment: "Apt 123",
        building: "Building 1",
        floor: "2nd Floor",
        street: "Main Street",
        city: "Cairo",
        state: "Cairo",
        country: "Egypt",
        postalCode: "12345",
        shippingMethod: "Standard",
      );

      expect(billingData.firstName, equals("John"));
      expect(billingData.lastName, equals("Doe"));
      expect(billingData.email, equals("john@example.com"));
      expect(billingData.phoneNumber, equals("01012345678"));
      expect(billingData.city, equals("Cairo"));
      expect(billingData.country, equals("Egypt"));
    });

    test('should create empty billing data', () {
      final billingData = BillingData();
      expect(billingData.firstName, isNull);
      expect(billingData.lastName, isNull);
      expect(billingData.email, isNull);
    });
  });

  group('PaymobIframe Tests', () {
    test('should create iframe with all fields', () {
      final iframe = PaymobIframe(
        iframeId: 123456,
        integrationId: 789012,
        name: "Test Iframe",
        description: "Test iframe description",
      );

      expect(iframe.iframeId, equals(123456));
      expect(iframe.integrationId, equals(789012));
      expect(iframe.name, equals("Test Iframe"));
      expect(iframe.description, equals("Test iframe description"));
    });

    test('should create iframe with minimal fields', () {
      final iframe = PaymobIframe(
        iframeId: 123456,
        integrationId: 789012,
      );

      expect(iframe.iframeId, equals(123456));
      expect(iframe.integrationId, equals(789012));
      expect(iframe.name, isNull);
      expect(iframe.description, isNull);
    });
  });

  group('PaymentPaymobResponse Tests', () {
    test('should create successful response', () {
      final response = PaymentPaymobResponse(
        success: true,
        message: "Payment successful",
        transactionID: "123456",
        amountCents: 10000,
        responseCode: "200",
      );

      expect(response.success, isTrue);
      expect(response.message, equals("Payment successful"));
      expect(response.transactionID, equals("123456"));
      expect(response.amountCents, equals(10000));
      expect(response.responseCode, equals("200"));
    });

    test('should create failed response', () {
      final response = PaymentPaymobResponse(
        success: false,
        message: "Payment failed",
        responseCode: "400",
      );

      expect(response.success, isFalse);
      expect(response.message, equals("Payment failed"));
      expect(response.responseCode, equals("400"));
    });
  });
}
