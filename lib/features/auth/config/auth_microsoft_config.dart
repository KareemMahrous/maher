import 'package:msal_auth/msal_auth.dart';

class AuthMicrosoftConfig {
  const AuthMicrosoftConfig._();

  static const clientId = '313f1f6e-186a-44d2-9abe-bf79f2b31bfb';

  static const tenantId = 'e73d5f51-e0f3-4c3b-aaeb-3ab18749df37';

  static const authority = 'https://login.microsoftonline.com/$tenantId';

  static const graphEndpoint = 'https://graph.microsoft.com/';

  static const androidRedirectUri =
      'msauth://com.maher.app/53F9T2Eb92l%2FQxDZ7WzGe4zQTAA%3D';

  static const appleRedirectUri = 'msauth.com.maher.app://auth';

  static const androidConfigFilePath = 'assets/auth/msal_config.json';

  static const authorityType = AuthorityType.aad;

  static const broker = Broker.webView;

  static const scopes = ['${graphEndpoint}user.read'];

  static String? get nullableAppleRedirectUri =>
      appleRedirectUri.isEmpty ? null : appleRedirectUri;
}
