import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../core/core.dart';
import '../../domain/usecases/login_by_google_use_case.dart';
import '../services/google_auth_service.dart';

part 'login_by_google_state.dart';

class LoginByGoogleCubit extends Cubit<LoginByGoogleState> {
  LoginByGoogleCubit({
    required LoginByGoogleUseCase loginByGoogleUseCase,
    required GoogleAuthService googleAuthService,
  }) : _loginByGoogleUseCase = loginByGoogleUseCase,
       _googleAuthService = googleAuthService,
       super(const LoginByGoogleInitial());

  final LoginByGoogleUseCase _loginByGoogleUseCase;
  final GoogleAuthService _googleAuthService;

  Future<void> loginByGoogle() async {
    emit(const LoginByGoogleLoading());

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
}
