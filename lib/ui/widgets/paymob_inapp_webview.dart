import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../models/paymob_response.dart';
import 'dart:io';
import 'package:webview_flutter_android/webview_flutter_android.dart';

class PaymobInAppWebView extends StatefulWidget {
  final String redirectURL;
  final Widget? title;
  final Color? appBarColor;
  final void Function(PaymentPaymobResponse)? onPayment;

  const PaymobInAppWebView({
    super.key,
    required this.redirectURL,
    this.onPayment,
    this.title,
    this.appBarColor,
  });

  static Future<PaymentPaymobResponse?> show({
    required BuildContext context,
    required String redirectURL,
    Widget? title,
    Color? appBarColor,
    void Function(PaymentPaymobResponse)? onPayment,
  }) =>
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PaymobInAppWebView(
            redirectURL: redirectURL,
            title: title,
            appBarColor: appBarColor,
            onPayment: onPayment,
          ),
        ),
      );

  @override
  _PaymobInAppWebViewState createState() => _PaymobInAppWebViewState();
}

class _PaymobInAppWebViewState extends State<PaymobInAppWebView> {
  late WebViewController webViewController;
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    // Initialize WebView for Android
    if (Platform.isAndroid) {
      WebViewPlatform.instance = AndroidWebViewPlatform();
    }
    // Initialize WebViewController
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            if (kDebugMode) {
              print("Page started loading: $url");
            }
            setState(() => isLoading = true);
          },
          onPageFinished: (String url) {
            if (kDebugMode) {
              print("Page finished loading: $url");
            }
            setState(() => isLoading = false);

            // Check for payment response in URL
            if (url.contains('txn_response_code') &&
                url.contains('success') &&
                url.contains('id')) {
              final params = Uri.parse(url).queryParameters;
              final response = PaymentPaymobResponse.fromJson(params);
              if (kDebugMode) {
                print(params);
              }

              if (widget.onPayment != null) {
                widget.onPayment!(response);
              }
              Navigator.pop(context, response);
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.redirectURL));

    return Scaffold(
      appBar: AppBar(
          title: widget.title ?? const Text('Paymob Payment'),
          centerTitle: true,
          backgroundColor: widget.appBarColor),
      body: Stack(
        children: [
          WebViewWidget(controller: webViewController),
          if (isLoading)
            const Center(child: CircularProgressIndicator.adaptive()),
        ],
      ),
    );
  }
}
