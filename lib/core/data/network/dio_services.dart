import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:logger/logger.dart';

import '../../../app.dart';
import '../../domain/use_cases/user_id_use_case.dart';
import '../../domain/use_cases/user_select_department.dart';
import '../../domain/use_cases/user_token_use_case.dart';
import '../../services/shared_prefrences/shared_prefrences.dart';
import '../../utils/constants/db_keys/db_keys.dart';
import 'interceptors/validate_token_interceptor.dart';
import 'utill/build_config.dart';
import 'utill/remote_urls.dart';

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
  Future<void> init();

  Future<Response<dynamic>> request(
    String path, {
    required HttpMethod httpMethod,
    Map<String, dynamic>? data,
    Map<String, dynamic>? header,
    Duration? receiveTimeout,
    FormData? formData,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ResponseType? responseType,
    ProgressCallback? onReceiveProgress,
    bool isMultipart = false,
    bool sendDelegation = true,
  });
}

class DioService implements NetworkService {
  DioService(
    this._dio,
    this._getUserTokenUseCase,
    this._getUserIdUseCase,
    this._getUserNameUseCase,
    this._userSelectedDepartmentUseCase,
  );

  final Dio _dio;
  final GetUserTokenUseCase _getUserTokenUseCase;
  final GetUserIdUseCase _getUserIdUseCase;
  final GetUserNameUseCase _getUserNameUseCase;
  final UserSelectedDepartmentUseCase _userSelectedDepartmentUseCase;

  /// No interceptors — used for login/refresh to avoid re-entrancy when
  /// [ValidateTokenInterceptor] triggers a refresh on the same Dio instance.
  late final Dio _authDio;

  @override
  Future<void> init() async {
    const timeout = Duration(seconds: 30);

    final options = BaseOptions(
      baseUrl: BuildConfig.of().baseURL,
      connectTimeout: timeout,
      receiveTimeout: timeout,
      followRedirects: false,
      receiveDataWhenStatusError: true,
    );
    _dio.options = options;
    _dio.interceptors.add(alice.getDioInterceptor());
    _dio.interceptors.add(ValidateTokenInterceptor());
    _dio.interceptors.add(
      CurlLoggerDioInterceptor(printOnSuccess: true, convertFormData: true),
    );
    _dio.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        final client = HttpClient();
        client.badCertificateCallback = (cert, host, port) => true;
        return client;
      },
    );

    _authDio = Dio(options);
    _authDio.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        final client = HttpClient();
        client.badCertificateCallback = (cert, host, port) => true;
        return client;
      },
    );
  }

  @override
  Future<Response<dynamic>> request(
    String path, {
    required HttpMethod httpMethod,
    Duration? receiveTimeout,
    Map<String, dynamic>? data,
    Map<String, dynamic>? header,
    FormData? formData,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ResponseType? responseType,
    ProgressCallback? onReceiveProgress,
    bool isMultipart = false,
    bool sendDelegation = true,
  }) async {
    final selectedDepartment = await _userSelectedDepartmentUseCase.call();
    final token = await _getUserTokenUseCase.call();
    final userId = await _getUserIdUseCase.call();
    final bool skipAuthHeader =
        path.contains(RemoteURLs.refreshTokenPath) ||
        path.contains(RemoteURLs.loginPath);

    final String encodedDepartmentName = selectedDepartment != null
        ? base64Encode(utf8.encode(selectedDepartment.departmentName))
        : '';

    final userName = await _getUserNameUseCase.getUserName();
    final userName2 = await _getUserNameUseCase.getUserName();
    final bool isInDelegationMode =
        SharedPref.getBoolean(LocalDbKeys.isUserInDelegationMode) ?? false;
    final String delegationId =
        SharedPref.getString(LocalDbKeys.delegationModeId) ?? '';
    final String delegationUserId =
        SharedPref.getString(LocalDbKeys.delegationModeUserId) ?? '';
    final String delegatorId =
        SharedPref.getString(LocalDbKeys.delegationModeDelegatorId) ?? '';

    final Map<String, dynamic> finalHeaders = {
      if (!skipAuthHeader && token != null && token.isNotEmpty)
        'Authorization': 'Bearer $token',
      if (selectedDepartment != null) ...{
        'departmentid': '${selectedDepartment.departmentId}',
        'departmentname': encodedDepartmentName,
      },
      'currentuserid': '$userId',
      'currentusername': userName,
      'currentusernationalid': userName2,
      if (sendDelegation && isInDelegationMode && delegationId.isNotEmpty)
        'delegationid': delegationId,
      if (sendDelegation && isInDelegationMode && delegationUserId.isNotEmpty)
        'delegationuserid': delegationUserId,
      if (sendDelegation && isInDelegationMode && delegatorId.isNotEmpty)
        'delegatorid': delegatorId,
    };

    if (header != null) {
      for (final entry in header.entries) {
        finalHeaders.putIfAbsent(entry.key, () => entry.value);
      }
    }

    final Options options = Options(
      method: httpMethod.method,
      headers: finalHeaders,
      receiveTimeout: receiveTimeout,
      responseType: responseType,
    );

    final Logger logger = Logger(
      printer: PrettyPrinter(
        methodCount: 0,
        lineLength: 120,
        printEmojis: true,
      ),
    );

    logger.i(
      'Request → $path\n'
      'Method → ${httpMethod.method}\n'
      'Headers → $finalHeaders\n'
      'Query → $queryParameters\n'
      'Body → ${data ?? formData}',
    );

    // Login/refresh must not go through ValidateTokenInterceptor (deadlock risk
    // when refresh is triggered from onError on this same Dio instance).
    final dioClient = skipAuthHeader ? _authDio : _dio;

    final Response response = await dioClient.request(
      path,
      data: data ?? formData,
      queryParameters: queryParameters,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
      options: options,
    );

    logger.i(
      'Response ← ${response.statusCode}\n'
      'Data ← ${response.data}',
    );

    return response;
  }
}
