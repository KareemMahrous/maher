import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:msal_auth/msal_auth.dart';

import '../../config/auth_microsoft_config.dart';
import '../../domain/entities/microsoft_login_request_entity.dart';

class MicrosoftAuthService {
  SingleAccountPca? _publicClientApplication;

  Future<MicrosoftLoginRequestEntity> signIn() async {
    try {
      final publicClientApplication = await _getPublicClientApplication();
      final authResult = await publicClientApplication.acquireToken(
        scopes: AuthMicrosoftConfig.scopes,
        prompt: Prompt.selectAccount,
      );

      return MicrosoftLoginRequestEntity(
        accessToken: authResult.accessToken,
        idToken: authResult.idToken,
        microsoftUserId: authResult.account.id,
        email: authResult.account.username,
        displayName: authResult.account.name,
        tenantId: authResult.tenantId,
        authority: authResult.authority,
        expiresOn: authResult.expiresOn,
        scopes: authResult.scopes,
      );
    } catch (error, stackTrace) {
      if (kDebugMode) {
        log(
          'Microsoft sign-in failed.',
          name: 'MicrosoftAuthService',
          error: error,
          stackTrace: stackTrace,
        );
      }
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _publicClientApplication?.signOut();
  }

  Future<SingleAccountPca> _getPublicClientApplication() async {
    final currentPublicClientApplication = _publicClientApplication;
    if (currentPublicClientApplication != null) {
      return currentPublicClientApplication;
    }

    _validateConfig();

    final publicClientApplication = await SingleAccountPca.create(
      clientId: AuthMicrosoftConfig.clientId,
      androidConfig: AndroidConfig(
        configFilePath: AuthMicrosoftConfig.androidConfigFilePath,
        redirectUri: AuthMicrosoftConfig.androidRedirectUri,
      ),
      appleConfig: AppleConfig(
        authority: AuthMicrosoftConfig.authority,
        authorityType: AuthMicrosoftConfig.authorityType,
        broker: AuthMicrosoftConfig.broker,
        redirectUri: AuthMicrosoftConfig.nullableAppleRedirectUri,
      ),
    );
    _publicClientApplication = publicClientApplication;
    return publicClientApplication;
  }

  void _validateConfig() {
    if (_isMissing(AuthMicrosoftConfig.clientId)) {
      throw StateError('Microsoft client ID is not configured.');
    }

    if (Platform.isAndroid &&
        _isMissing(AuthMicrosoftConfig.androidRedirectUri)) {
      throw StateError('Microsoft Android redirect URI is not configured.');
    }
  }

  bool _isMissing(String value) {
    return value.isEmpty || value.startsWith('TODO_');
  }
}
