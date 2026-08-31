import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:msal_auth/msal_auth.dart';

import '../../../../core/core.dart';
import '../../domain/usecases/login_by_google_use_case.dart';
import '../../domain/usecases/login_by_microsoft_use_case.dart';
import '../services/google_auth_service.dart';
import '../services/microsoft_auth_service.dart';

part 'login_by_google_state.dart';

class LoginByGoogleCubit extends Cubit<LoginByGoogleState> {
  LoginByGoogleCubit({
    required LoginByGoogleUseCase loginByGoogleUseCase,
    required LoginByMicrosoftUseCase loginByMicrosoftUseCase,
    required GoogleAuthService googleAuthService,
    required MicrosoftAuthService microsoftAuthService,
  }) : _loginByGoogleUseCase = loginByGoogleUseCase,
       _loginByMicrosoftUseCase = loginByMicrosoftUseCase,
       _googleAuthService = googleAuthService,
       _microsoftAuthService = microsoftAuthService,
       super(const LoginByGoogleInitial());

  final LoginByGoogleUseCase _loginByGoogleUseCase;
  final LoginByMicrosoftUseCase _loginByMicrosoftUseCase;
  final GoogleAuthService _googleAuthService;
  final MicrosoftAuthService _microsoftAuthService;

  Future<void> loginByGoogle() async {
    emit(const LoginByGoogleLoading(provider: LoginProvider.google));

    try {
      final googleLoginRequest = await _googleAuthService.signIn();
      final result = await _loginByGoogleUseCase(googleLoginRequest);

      await result.fold(
        (failure) async {
          await _googleAuthService.signOut();
          emit(const LoginByGoogleError(messageKey: 'auth.login.googleError'));
        },
        (_) async {
          await SharedPref.setBoolean(
            key: PrefKeys.isUserLoggedIn,
            value: true,
          );
          emit(const LoginByGoogleSuccess());
        },
      );
    } on GoogleSignInException catch (error) {
      emit(
        LoginByGoogleError(
          messageKey: error.code == GoogleSignInExceptionCode.canceled
              ? 'auth.login.googleCanceled'
              : 'auth.login.googleError',
        ),
      );
    } catch (_) {
      emit(const LoginByGoogleError(messageKey: 'auth.login.googleError'));
    }
  }

  Future<void> loginByMicrosoft() async {
    emit(const LoginByGoogleLoading(provider: LoginProvider.microsoft));

    try {
      final microsoftLoginRequest = await _microsoftAuthService.signIn();
      final result = await _loginByMicrosoftUseCase(microsoftLoginRequest);

      await result.fold(
        (failure) async {
          await _microsoftAuthService.signOut();
          emit(
            const LoginByGoogleError(messageKey: 'auth.login.microsoftError'),
          );
        },
        (_) async {
          await SharedPref.setBoolean(
            key: PrefKeys.isUserLoggedIn,
            value: true,
          );
          emit(const LoginByGoogleSuccess());
        },
      );
    } on MsalUserCancelException {
      emit(
        const LoginByGoogleError(messageKey: 'auth.login.microsoftCanceled'),
      );
    } on MsalException {
      emit(const LoginByGoogleError(messageKey: 'auth.login.microsoftError'));
    } catch (_) {
      emit(const LoginByGoogleError(messageKey: 'auth.login.microsoftError'));
    }
  }
}
