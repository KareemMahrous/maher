import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app.dart';
import '../../../../injection/injection.dart';
import '../../../presentation/manager/layout/layout_cubit.dart';
import '../../../presentation/manager/user_settings/user_settings_cubit.dart';
import '../../../routes/app_router.dart';
import '../token_refresh_service.dart';
import '../utill/build_config.dart';
import '../utill/remote_urls.dart';

class ValidateTokenInterceptor extends Interceptor {
  /// Shared logout so concurrent failures don't navigate/clear twice.
  static Future<void>? _ongoingLogout;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (_isAuthExemptPath(options.path)) {
      handler.next(options);
      return;
    }

    try {
      final token = await InjectionContainer.locator<TokenRefreshService>()
          .ensureValidAccessToken();
      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    } catch (_) {
      // Let the request proceed; onError will handle a resulting 401.
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final status = err.response?.statusCode;
    if (status != 401) {
      handler.next(err);
      return;
    }

    final path = err.requestOptions.path;
    if (_isAuthExemptPath(path)) {
      handler.next(err);
      return;
    }

    try {
      // Force refresh — server already rejected the current access token.
      final newToken =
          await InjectionContainer.locator<TokenRefreshService>().refresh();
      if (newToken == null || newToken.isEmpty) {
        await _forceLogout();
        handler.next(err);
        return;
      }

      err.requestOptions.headers['Authorization'] = 'Bearer $newToken';
      final retryResponse = await _buildPlainDio().fetch(err.requestOptions);
      handler.resolve(retryResponse);
    } on DioException catch (retryError) {
      // Fresh token still rejected → session is invalid.
      if (retryError.response?.statusCode == 401) {
        await _forceLogout();
      }
      handler.next(retryError);
    } catch (_) {
      await _forceLogout();
      handler.next(err);
    }
  }

  bool _isAuthExemptPath(String path) {
    return path.contains(RemoteURLs.logoutPath) ||
        path.contains(RemoteURLs.refreshTokenPath) ||
        path.contains(RemoteURLs.loginPath);
  }

  Future<void> _forceLogout() {
    return _ongoingLogout ??= _doForceLogout().whenComplete(() {
      _ongoingLogout = null;
    });
  }

  Future<void> _doForceLogout() async {
    try {
      final context = navigatorKey.currentContext;
      await InjectionContainer.locator<UserSettingsCubit>()
          .deleteUserSettingsWhenLogOut();
      if (context != null && context.mounted) {
        context.read<LayoutCubit>().changePageIndex(0);
        AutoRouter.of(context).root.replace(const LoginViewRoute());
      }
    } catch (_) {}
  }

  Dio _buildPlainDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: BuildConfig.of().baseURL,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        receiveDataWhenStatusError: true,
      ),
    );
    dio.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        final client = HttpClient();
        client.badCertificateCallback = (cert, host, port) => true;
        return client;
      },
    );
    return dio;
  }
}
