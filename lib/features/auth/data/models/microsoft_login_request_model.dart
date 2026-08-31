import '../../domain/entities/microsoft_login_request_entity.dart';

class MicrosoftLoginRequestModel extends MicrosoftLoginRequestEntity {
  const MicrosoftLoginRequestModel({
    required super.accessToken,
    required super.microsoftUserId,
    required super.expiresOn,
    required super.scopes,
    super.idToken,
    super.email,
    super.displayName,
    super.tenantId,
    super.authority,
  });

  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'idToken': idToken,
      'microsoftUserId': microsoftUserId,
      'email': email,
      'displayName': displayName,
      'tenantId': tenantId,
      'authority': authority,
      'expiresOn': expiresOn.toIso8601String(),
      'scopes': scopes,
    };
  }
}
