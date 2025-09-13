import 'package:dio/dio.dart';

/// Interface for HTTP service operations
abstract class ApiServiceInterface {
  /// Make a POST request
  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  });

  /// Make a GET request
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  });

  /// Make a multipart POST request
  Future<Response<T>> postMultipart<T>(
    String path, {
    Map<String, dynamic>? fields,
    Map<String, dynamic>? files,
    Map<String, dynamic>? queryParameters,
    Options? options,
  });

  /// Set authorization header
  void setAuthToken(String token);

  /// Clear authorization header
  void clearAuthToken();
}
