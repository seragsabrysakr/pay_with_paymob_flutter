import 'dart:io';
import 'package:dio/dio.dart';
import '../constants/api_constants.dart';
import '../exceptions/paymob_exceptions.dart';
import '../interfaces/api_service_interface.dart';

/// HTTP service implementation using Dio with logging
class HttpService implements ApiServiceInterface {
  late final Dio _dio;

  HttpService() {
    _dio = Dio();
    _setupInterceptors();
  }

  /// Setup Dio interceptors for logging and error handling
  void _setupInterceptors() {
    // Request interceptor for logging
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          print('🚀 [REQUEST] ${options.method} ${options.uri}');
          print('📋 [HEADERS] ${options.headers}');
          if (options.data != null) {
            print('📦 [BODY] ${options.data}');
          }
          handler.next(options);
        },
        onResponse: (response, handler) {
          print('✅ [RESPONSE] ${response.statusCode} ${response.requestOptions.uri}');
          print('📄 [DATA] ${response.data}');
          handler.next(response);
        },
        onError: (error, handler) {
          print('❌ [ERROR] ${error.response?.statusCode} ${error.requestOptions.uri}');
          print('💥 [ERROR MESSAGE] ${error.message}');
          if (error.response?.data != null) {
            print('📄 [ERROR DATA] ${error.response?.data}');
          }
          handler.next(error);
        },
      ),
    );

    // Log interceptor for detailed logging
    _dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        requestHeader: true,
        responseHeader: false,
        error: true,
        logPrint: (obj) => print('📝 [DIO LOG] $obj'),
      ),
    );
  }

  @override
  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options ?? Options(
          headers: ApiConstants.defaultHeaders,
        ),
      );
      return response;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: options ?? Options(
          headers: ApiConstants.defaultHeaders,
        ),
      );
      return response;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  Future<Response<T>> postMultipart<T>(
    String path, {
    Map<String, dynamic>? fields,
    Map<String, dynamic>? files,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      // Create FormData for multipart request
      final formData = FormData();
      
      // Add fields
      if (fields != null) {
        fields.forEach((key, value) {
          formData.fields.add(MapEntry(key, value.toString()));
        });
      }
      
      // Add files
      if (files != null) {
        files.forEach((key, value) {
          if (value is File) {
            formData.files.add(MapEntry(
              key,
              MultipartFile.fromFileSync(
                value.path,
                filename: value.path.split('/').last,
              ),
            ));
          }
        });
      }

      final response = await _dio.post<T>(
        path,
        data: formData,
        queryParameters: queryParameters,
        options: options ?? Options(
          headers: {
            ...ApiConstants.defaultHeaders,
            'Content-Type': 'multipart/form-data',
          },
        ),
      );
      return response;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  @override
  void setAuthToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  @override
  void clearAuthToken() {
    _dio.options.headers.remove('Authorization');
  }

  /// Handle Dio errors and convert to Paymob exceptions
  PaymobException _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const ApiRequestException('Connection timeout. Please check your internet connection.');
      
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final message = error.response?.data?['message']?.toString() ?? 'API request failed';
        return ApiRequestException(message, statusCode?.toString());
      
      case DioExceptionType.cancel:
        return const ApiRequestException('Request was cancelled');
      
      case DioExceptionType.connectionError:
        return const ApiRequestException('Connection error. Please check your internet connection.');
      
      case DioExceptionType.badCertificate:
        return const ApiRequestException('SSL certificate error');
      
      case DioExceptionType.unknown:
        return ApiRequestException('Unknown error: ${error.message}');
    }
  }
}
