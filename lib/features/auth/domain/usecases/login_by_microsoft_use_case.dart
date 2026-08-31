import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../entities/microsoft_login_request_entity.dart';
import '../repositories/auth_repo.dart';

class LoginByMicrosoftUseCase
    implements UseCase<void, MicrosoftLoginRequestEntity> {
  const LoginByMicrosoftUseCase({required AuthRepo authRepo})
    : _authRepo = authRepo;

  final AuthRepo _authRepo;

  @override
  Future<Either<Failure, void>> call(MicrosoftLoginRequestEntity params) {
    return _authRepo.loginByMicrosoft(params);
  }
}
