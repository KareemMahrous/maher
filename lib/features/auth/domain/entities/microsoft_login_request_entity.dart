import 'package:equatable/equatable.dart';

class MicrosoftLoginRequestEntity extends Equatable {
  const MicrosoftLoginRequestEntity({
    required this.accessToken,
    required this.microsoftUserId,
    required this.expiresOn,
    required this.scopes,
    this.idToken,
    this.email,
    this.displayName,
    this.tenantId,
    this.authority,
  });

  final String accessToken;
  final String? idToken;
  final String microsoftUserId;
  final String? email;
  final String? displayName;
  final String? tenantId;
  final String? authority;
  final DateTime expiresOn;
  final List<String> scopes;

  @override
  List<Object?> get props => [
    accessToken,
    idToken,
    microsoftUserId,
    email,
    displayName,
    tenantId,
    authority,
    expiresOn,
    scopes,
  ];
}
