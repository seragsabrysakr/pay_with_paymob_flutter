import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../models/paymob_response.dart';

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
  late InAppWebViewController webViewController;
  bool isLoading = true;
  PaymentPaymobResponse? _paymentResponse;
  bool _paymentCompleted = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // If payment is completed, return the response
        if (_paymentCompleted && _paymentResponse != null) {
          Navigator.pop(context, _paymentResponse);
          return false; // Prevent default back behavior
        }
        // If payment not completed, show confirmation dialog
        return await _showExitConfirmation();
      },
      child: Scaffold(
        appBar: AppBar(
            title: widget.title ?? const Text('Paymob Payment'),
            centerTitle: true,
            backgroundColor: widget.appBarColor,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () async {
                // If payment is completed, return the response
                if (_paymentCompleted && _paymentResponse != null) {
                  Navigator.pop(context, _paymentResponse);
                } else {
                  // If payment not completed, show confirmation dialog
                  final shouldPop = await _showExitConfirmation();
                  if (shouldPop && mounted) {
                    Navigator.pop(context);
                  }
                }
              },
            )),
        body: Stack(
          children: [
            InAppWebView(
              initialUrlRequest: URLRequest(url: WebUri(widget.redirectURL)),
              initialSettings: InAppWebViewSettings(
                  javaScriptEnabled: true,
                  useOnLoadResource: true,
                  useHybridComposition: true,
                  allowsInlineMediaPlayback: true,
                  allowsLinkPreview: true),
              onWebViewCreated: (controller) {
                webViewController = controller;
              },
              onLoadStart: (controller, url) {
                if (kDebugMode) {
                  print("Page started loading: $url");
                }
                setState(() => isLoading = true);
              },
              onLoadStop: (controller, url) {
                if (kDebugMode) {
                  print("Page finished loading: $url");
                }
                setState(() => isLoading = false);

                if (url != null) {
                  final urlString = url.toString();
                  if (urlString.contains('txn_response_code') &&
                      urlString.contains('success') &&
                      urlString.contains('id')) {
                    final params = Uri.parse(urlString).queryParameters;
                    final response = PaymentPaymobResponse.fromJson(params);
                    if (kDebugMode) {
                      print(params);
                    }

                    // Store payment response and mark as completed
                    setState(() {
                      _paymentResponse = response;
                      _paymentCompleted = true;
                    });

                    if (widget.onPayment != null) {
                      widget.onPayment!(response);
                    }

                    // Auto-pop with response after a short delay to show success
                    Future.delayed(const Duration(milliseconds: 1500), () {
                      if (mounted) {
                        Navigator.pop(context, response);
                      }
                    });
                  }
                }
              },
            ),
            if (isLoading)
              const Center(child: CircularProgressIndicator.adaptive()),
          ],
        ),
      ),
    );
  }

  /// Show confirmation dialog when user tries to exit before payment completion
  Future<bool> _showExitConfirmation() async {
    return await showDialog<bool>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Exit Payment?'),
              content: const Text(
                'Are you sure you want to exit? Your payment may not be completed.',
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text('Exit'),
                ),
              ],
            );
          },
        ) ??
        false;
  }
}
