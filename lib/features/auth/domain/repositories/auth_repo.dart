import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../entities/google_login_request_entity.dart';
import '../entities/microsoft_login_request_entity.dart';

abstract interface class AuthRepo {
  Future<Either<Failure, void>> loginByGoogle(GoogleLoginRequestEntity request);

  Future<Either<Failure, void>> loginByMicrosoft(
    MicrosoftLoginRequestEntity request,
  );
}
