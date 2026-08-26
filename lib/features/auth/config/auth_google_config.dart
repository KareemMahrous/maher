class AuthGoogleConfig {
  const AuthGoogleConfig._();

  // TODO: Add Google OAuth client ID if the target platform requires it.
  static const clientId = '';

  // TODO: Add the backend/server OAuth client ID when it is available.
  static const serverClientId = '';

  // TODO: Add backend API key if the login endpoint requires one.
  static const backendApiKey = '';

  static const backendApiKeyHeaderName = 'x-api-key';

  static List<String> get scopes => const ['email', 'profile'];

  static String? get nullableClientId => clientId.isEmpty ? null : clientId;

  static String? get nullableServerClientId =>
      serverClientId.isEmpty ? null : serverClientId;
}
