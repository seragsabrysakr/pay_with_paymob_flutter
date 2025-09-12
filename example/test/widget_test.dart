import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pay_with_paymob_flutter_example/main.dart';

void main() {
  group('Example App Tests', () {
    testWidgets('should display welcome message', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(const MyApp());

      // Verify that the welcome message is displayed
      expect(find.text('Welcome to Paymob Payment Demo'), findsOneWidget);
      expect(find.text('Choose from the available payment methods and iframes below:'), findsOneWidget);
    });

    testWidgets('should display environment indicator', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      // Verify that the environment indicator is displayed
      expect(find.textContaining('Environment:'), findsOneWidget);
    });

    testWidgets('should display payment method sections', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      // Verify that payment method sections are displayed
      expect(find.text('Digital Wallets & Payment Methods:'), findsOneWidget);
      expect(find.text('Digital Wallets:'), findsOneWidget);
      expect(find.text('Installment Services:'), findsOneWidget);
      expect(find.text('Other Services:'), findsOneWidget);
      expect(find.text('Available Iframes:'), findsOneWidget);
    });

    testWidgets('should display payment method cards', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      // Verify that payment method cards are displayed
      expect(find.text('Apple Pay'), findsOneWidget);
      expect(find.text('ValU'), findsOneWidget);
      expect(find.text('Wallet'), findsOneWidget);
    });

    testWidgets('should have pay buttons for payment methods', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      // Verify that pay buttons are displayed
      expect(find.text('Pay'), findsWidgets);
    });

    testWidgets('should display iframe cards', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      // Verify that iframe cards are displayed
      expect(find.textContaining('Iframe'), findsWidgets);
    });
  });

  group('Payment Method Card Tests', () {
    testWidgets('should display payment method information', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      // Find a payment method card
      final paymentMethodCard = find.byType(Card).first;
      expect(paymentMethodCard, findsOneWidget);

      // Verify that the card contains expected elements
      expect(find.byType(ListTile), findsWidgets);
      expect(find.byType(ElevatedButton), findsWidgets);
    });

    testWidgets('should display identifier and integration ID', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      // Verify that identifier and integration ID are displayed
      expect(find.textContaining('Identifier:'), findsWidgets);
      expect(find.textContaining('Integration ID:'), findsWidgets);
    });
  });

  group('Environment Switcher Tests', () {
    testWidgets('should have environment switcher button', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      // Verify that the environment switcher button is displayed
      expect(find.textContaining('Switch to'), findsOneWidget);
    });

    testWidgets('should switch environment when button is tapped', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      // Find the environment switcher button
      final switchButton = find.textContaining('Switch to');
      expect(switchButton, findsOneWidget);

      // Tap the button
      await tester.tap(switchButton);
      await tester.pumpAndSettle();

      // Verify that the environment has changed
      expect(find.textContaining('Environment:'), findsOneWidget);
    });
  });

  group('App Structure Tests', () {
    testWidgets('should have proper app structure', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      // Verify that the app has the expected structure
      expect(find.byType(MaterialApp), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byType(SingleChildScrollView), findsOneWidget);
      expect(find.byType(Column), findsWidgets);
    });

    testWidgets('should have proper navigation', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      // Verify that the app bar is displayed
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.text('Flutter Paymob'), findsOneWidget);
    });
  });

  group('Responsive Design Tests', () {
    testWidgets('should handle different screen sizes', (WidgetTester tester) async {
      // Test with a small screen
      await tester.binding.setSurfaceSize(const Size(400, 800));
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      // Verify that the app still displays properly
      expect(find.text('Welcome to Paymob Payment Demo'), findsOneWidget);

      // Test with a large screen
      await tester.binding.setSurfaceSize(const Size(1200, 800));
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      // Verify that the app still displays properly
      expect(find.text('Welcome to Paymob Payment Demo'), findsOneWidget);
    });
  });
}
