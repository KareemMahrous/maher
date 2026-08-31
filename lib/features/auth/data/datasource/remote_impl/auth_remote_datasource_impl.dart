import 'package:dio/dio.dart';

import '../../../../../core/core.dart';
import '../../../config/auth_google_config.dart';
import '../../models/google_login_request_model.dart';
import '../remote/auth_remote_datasource.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl({required NetworkService networkService})
    : _networkService = networkService;

  final NetworkService _networkService;

  @override
  Future<void> loginByGoogle(GoogleLoginRequestModel request) async {
    final headers = <String, dynamic>{
      if (AuthGoogleConfig.backendApiKey.isNotEmpty)
        AuthGoogleConfig.backendApiKeyHeaderName:
            AuthGoogleConfig.backendApiKey,
    };

    final response = await _networkService.request(
      RemoteURLs.loginByGoogle,
      httpMethod: HttpMethod.post,
      data: request.toJson(),
      headers: headers.isEmpty ? null : headers,
    );

    if (response.statusCode == null || response.statusCode! >= 400) {
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        type: DioExceptionType.badResponse,
      );
    }
  }
}
