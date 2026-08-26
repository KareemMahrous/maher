import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../entities/google_login_request_entity.dart';
import '../repositories/auth_repo.dart';

class LoginByGoogleUseCase implements UseCase<void, GoogleLoginRequestEntity> {
  const LoginByGoogleUseCase({required AuthRepo authRepo})
    : _authRepo = authRepo;

  final AuthRepo _authRepo;

  @override
  Future<Either<Failure, void>> call(GoogleLoginRequestEntity params) {
    return _authRepo.loginByGoogle(params);
  }
}
