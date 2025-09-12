import 'app_config.dart';
import 'test_config.dart';
import 'live_config.dart';

/// Environment types
enum Environment { test, live }

/// Configuration manager to switch between different environments
class ConfigManager {
  static Environment _currentEnvironment = Environment.test;
  
  /// Get the current environment
  static Environment get currentEnvironment => _currentEnvironment;
  
  /// Set the current environment
  static void setEnvironment(Environment environment) {
    _currentEnvironment = environment;
  }
  
  /// Get the current configuration based on the selected environment
  static AppConfig get currentConfig {
    switch (_currentEnvironment) {
      case Environment.test:
        return TestConfig.config;
      case Environment.live:
        return LiveConfig.config;
    }
  }
  
  /// Check if we're in test mode
  static bool get isTest => _currentEnvironment == Environment.test;
  
  /// Check if we're in live mode
  static bool get isLive => _currentEnvironment == Environment.live;
}
