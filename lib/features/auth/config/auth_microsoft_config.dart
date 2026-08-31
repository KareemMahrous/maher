import 'package:msal_auth/msal_auth.dart';

class AuthMicrosoftConfig {
  const AuthMicrosoftConfig._();

  // TODO: Add Microsoft Azure application client ID.
  static const clientId = 'TODO_ADD_MICROSOFT_CLIENT_ID';

  // TODO: Add Android redirect URI from Azure, for example:
  // msauth://com.maher.app/<BASE64_SIGNATURE_HASH>
  static const androidRedirectUri = 'TODO_ADD_ANDROID_REDIRECT_URI';

  // TODO: Add iOS redirect URI from Azure if needed, for example:
  // msauth.<TEAM_ID>.com.maher.app://auth
  static const appleRedirectUri = '';

  static const androidConfigFilePath = 'assets/auth/msal_config.json';

  static const authorityType = AuthorityType.aad;

  static const broker = Broker.webView;

  static const scopes = ['https://graph.microsoft.com/user.read'];

  static String? get nullableAppleRedirectUri =>
      appleRedirectUri.isEmpty ? null : appleRedirectUri;
}
