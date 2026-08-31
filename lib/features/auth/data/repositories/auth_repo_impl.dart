import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/core.dart';
import '../../domain/entities/google_login_request_entity.dart';
import '../../domain/entities/microsoft_login_request_entity.dart';
import '../../domain/repositories/auth_repo.dart';
import '../datasource/datasource.dart';
import '../models/google_login_request_model.dart';
import '../models/microsoft_login_request_model.dart';

class AuthRepoImpl implements AuthRepo {
  AuthRepoImpl({required AuthRemoteDataSource remoteDataSource})
    : _remoteDataSource = remoteDataSource;

  final AuthRemoteDataSource _remoteDataSource;

  @override
  Future<Either<Failure, void>> loginByGoogle(
    GoogleLoginRequestEntity request,
  ) async {
    try {
      await _remoteDataSource.loginByGoogle(
        GoogleLoginRequestModel(
          idToken: request.idToken,
          accessToken: request.accessToken,
          email: request.email,
          googleUserId: request.googleUserId,
          displayName: request.displayName,
          photoUrl: request.photoUrl,
        ),
      );
      return const Right(null);
    } on DioException catch (error) {
      return Left(
        ServerFailure(
          message: error.response?.data?.toString() ?? error.message,
          statusCode: error.response?.statusCode,
        ),
      );
    } catch (error) {
      return Left(UnknownFailure(message: error.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> loginByMicrosoft(
    MicrosoftLoginRequestEntity request,
  ) async {
    try {
      await _remoteDataSource.loginByMicrosoft(
        MicrosoftLoginRequestModel(
          accessToken: request.accessToken,
          idToken: request.idToken,
          microsoftUserId: request.microsoftUserId,
          email: request.email,
          displayName: request.displayName,
          tenantId: request.tenantId,
          authority: request.authority,
          expiresOn: request.expiresOn,
          scopes: request.scopes,
        ),
      );
      return const Right(null);
    } on DioException catch (error) {
      return Left(
        ServerFailure(
          message: error.response?.data?.toString() ?? error.message,
          statusCode: error.response?.statusCode,
        ),
      );
    } catch (error) {
      return Left(UnknownFailure(message: error.toString()));
    }
  }
}
