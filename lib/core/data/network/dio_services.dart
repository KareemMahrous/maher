import 'package:dio/dio.dart';

import 'base_dio.dart';

enum HttpMethod {
  get('GET'),
  post('POST'),
  put('PUT'),
  patch('PATCH'),
  delete('DELETE');

  const HttpMethod(this.method);

  final String method;
}

abstract interface class NetworkService {
  Future<Response<dynamic>> request(
    String path, {
    required HttpMethod httpMethod,
    Object? data,
    Map<String, dynamic>? headers,
    Duration? receiveTimeout,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ResponseType? responseType,
    ProgressCallback? onReceiveProgress,
  });
}

class DioService implements NetworkService {
  DioService({required BaseDio baseDio}) : _baseDio = baseDio;

  final BaseDio _baseDio;

  @override
  Future<Response<dynamic>> request(
    String path, {
    required HttpMethod httpMethod,
    Object? data,
    Map<String, dynamic>? headers,
    Duration? receiveTimeout,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ResponseType? responseType,
    ProgressCallback? onReceiveProgress,
  }) {
    final options = Options(
      method: httpMethod.method,
      headers: headers,
      receiveTimeout: receiveTimeout,
      responseType: responseType,
    );

    return _baseDio.client.request(
      path,
      data: data,
      queryParameters: queryParameters,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
      options: options,
    );
  }
}
