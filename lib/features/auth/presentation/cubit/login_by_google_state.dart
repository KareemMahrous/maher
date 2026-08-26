part of 'login_by_google_cubit.dart';

sealed class LoginByGoogleState extends Equatable {
  const LoginByGoogleState();

  @override
  List<Object?> get props => [];
}

class LoginByGoogleInitial extends LoginByGoogleState {
  const LoginByGoogleInitial();
}

class LoginByGoogleLoading extends LoginByGoogleState {
  const LoginByGoogleLoading();
}

class LoginByGoogleSuccess extends LoginByGoogleState {
  const LoginByGoogleSuccess();
}

class LoginByGoogleError extends LoginByGoogleState {
  const LoginByGoogleError({required this.messageKey});

  final String messageKey;

  @override
  List<Object?> get props => [messageKey];
}
