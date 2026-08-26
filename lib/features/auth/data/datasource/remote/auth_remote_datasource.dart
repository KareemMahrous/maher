import '../../models/google_login_request_model.dart';

abstract interface class AuthRemoteDataSource {
  Future<void> loginByGoogle(GoogleLoginRequestModel request);
}
