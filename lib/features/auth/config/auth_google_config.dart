import 'dart:io';

class AuthGoogleConfig {
  const AuthGoogleConfig._();

  static const androidClientId =
      '22642361348-3pgjqd9sk57b6puuvampepq26goneee0.apps.googleusercontent.com';

  static const iosClientId =
      '22642361348-7i9fds4vr58utkrev2622grni0dcjh13.apps.googleusercontent.com';

  static const serverClientId =
      '22642361348-p129577ft4ia90ndglmgvfp02gbgjhud.apps.googleusercontent.com';

  // TODO: Add backend API key if the login endpoint requires one.
  static const backendApiKey = '';

  static const backendApiKeyHeaderName = 'x-api-key';

  static List<String> get scopes => const ['email', 'profile'];

  static String? get nullableClientId {
    if (Platform.isAndroid) {
      return androidClientId;
    }

    if (Platform.isIOS) {
      return iosClientId;
    }

    return null;
  }

  static String? get nullableServerClientId =>
      serverClientId.isEmpty ? null : serverClientId;
}
