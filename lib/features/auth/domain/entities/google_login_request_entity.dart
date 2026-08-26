import 'package:equatable/equatable.dart';

class GoogleLoginRequestEntity extends Equatable {
  const GoogleLoginRequestEntity({
    required this.idToken,
    required this.email,
    required this.googleUserId,
    this.displayName,
    this.photoUrl,
    this.accessToken,
  });

  final String idToken;
  final String? accessToken;
  final String email;
  final String googleUserId;
  final String? displayName;
  final String? photoUrl;

  @override
  List<Object?> get props => [
    idToken,
    accessToken,
    email,
    googleUserId,
    displayName,
    photoUrl,
  ];
}
