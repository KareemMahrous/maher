import '../../domain/entities/google_login_request_entity.dart';

class GoogleLoginRequestModel extends GoogleLoginRequestEntity {
  const GoogleLoginRequestModel({
    required super.idToken,
    required super.email,
    required super.googleUserId,
    super.displayName,
    super.photoUrl,
    super.accessToken,
  });

  Map<String, dynamic> toJson() {
    return {
      'idToken': idToken,
      'email': email,
      'googleUserId': googleUserId,
      'displayName': displayName,
      'photoUrl': photoUrl,
      'accessToken': accessToken,
    };
  }
}
