import 'package:flutter/material.dart';
import 'package:pay_with_paymob_flutter/paymob_flutter.dart';

import 'config/config_manager.dart';
import 'tabs/payment_methods_tab.dart';
import 'tabs/iframe_tab.dart';
import 'tabs/payment_links_tab.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Set the environment (change this to Environment.live for production)
  ConfigManager.setEnvironment(Environment.test);

  // Get configuration from the selected environment
  final config = ConfigManager.currentConfig;

  // Initialize Paymob with the configuration
  PaymobFlutter.instance.initializeWithConfig(
    apiKey: config.apiKey,
    paymentMethods: config.paymentMethods,
    iframes: config.iframes,
    defaultIntegrationId: config.defaultIntegrationId,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Paymob'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(
              icon: Icon(Icons.payment),
              text: 'Payment Methods',
            ),
            Tab(
              icon: Icon(Icons.web),
              text: 'Iframes',
            ),
            Tab(
              icon: Icon(Icons.link),
              text: 'Payment Links',
            ),
          ],
        ),
        actions: [
              // Environment indicator and switcher
              Row(
                children: [
                  Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: ConfigManager.isTest ? Colors.orange : Colors.green,
                  borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                  ConfigManager.currentEnvironment.name.toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                    fontSize: 10,
                      ),
                    ),
                  ),
              const SizedBox(width: 8),
                  // Environment switcher (for testing purposes)
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        ConfigManager.setEnvironment(
                      ConfigManager.isTest
                          ? Environment.live
                          : Environment.test,
                        );
                      });
                    },
                    style: ElevatedButton.styleFrom(
                  backgroundColor:
                      ConfigManager.isTest ? Colors.green : Colors.orange,
                      foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    ),
                    child: Text(
                      "Switch to ${ConfigManager.isTest ? 'LIVE' : 'TEST'}",
                  style: const TextStyle(fontSize: 8),
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          PaymentMethodsTab(),
          IframeTab(),
          PaymentLinksTab(),
        ],
      ),
    );
  }
}
