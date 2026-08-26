import 'package:google_sign_in/google_sign_in.dart';

import '../../config/auth_google_config.dart';
import '../../domain/entities/google_login_request_entity.dart';

class GoogleAuthService {
  GoogleAuthService({GoogleSignIn? googleSignIn})
    : _googleSignIn = googleSignIn ?? GoogleSignIn.instance;

  final GoogleSignIn _googleSignIn;
  bool _isInitialized = false;

  Future<GoogleLoginRequestEntity> signIn() async {
    await _initialize();

    if (!_googleSignIn.supportsAuthenticate()) {
      throw UnsupportedError(
        'Google Sign-In is not supported on this platform.',
      );
    }

    final account = await _googleSignIn.authenticate(
      scopeHint: AuthGoogleConfig.scopes,
    );
    final idToken = account.authentication.idToken;

    if (idToken == null || idToken.isEmpty) {
      throw StateError('Google Sign-In did not return an ID token.');
    }

    final authorization = await account.authorizationClient
        .authorizationForScopes(AuthGoogleConfig.scopes);

    return GoogleLoginRequestEntity(
      idToken: idToken,
      accessToken: authorization?.accessToken,
      email: account.email,
      googleUserId: account.id,
      displayName: account.displayName,
      photoUrl: account.photoUrl,
    );
  }

  Future<void> signOut() async {
    await _initialize();
    await _googleSignIn.signOut();
  }

  Future<void> _initialize() async {
    if (_isInitialized) {
      return;
    }

    await _googleSignIn.initialize(
      clientId: AuthGoogleConfig.nullableClientId,
      serverClientId: AuthGoogleConfig.nullableServerClientId,
    );
    _isInitialized = true;
  }
}
