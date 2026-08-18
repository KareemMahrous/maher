import 'package:dio/dio.dart';

import 'failures.dart';

class ErrorHandler {
  static Failure handle(dynamic error) {
    if (error is Failure) return error;
    if (error is DioException) {
      return NetworkExceptionMapper.mapDioException(error);
    }
    return const UnknownFailure();
  }
}

class NetworkExceptionMapper {
  static Failure mapDioException(DioException error) {
    switch (error.type) {
      case DioExceptionType.transformTimeout:
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const TimeoutFailure();
      case DioExceptionType.badResponse:
        return _handleBadResponse(error.response);
      case DioExceptionType.cancel:
        return const UnknownFailure(
          message: 'Request to API server was cancelled',
        );
      case DioExceptionType.connectionError:
        return const NetworkFailure();
      case DioExceptionType.badCertificate:
        return const UnknownFailure(message: 'Bad certificate');
      case DioExceptionType.unknown:
        return const UnknownFailure();
    }
  }

  static Failure _handleBadResponse(Response? response) {
    if (response == null) {
      return const ServerFailure();
    }

    final int statusCode = response.statusCode ?? 500;
    //TODO: map to the returned message from the server
    final String? serverMessage = response.data['message'];

    switch (statusCode) {
      case 400:
        return BadRequestFailure(
          message: serverMessage ?? 'Bad request',
          statusCode: statusCode,
        );
      case 401:
        return UnauthorizedFailure(
          message: serverMessage ?? 'Unauthorized access',
          statusCode: statusCode,
        );
      case 403:
        return ForbiddenFailure(
          message: serverMessage ?? 'Access forbidden',
          statusCode: statusCode,
        );
      case 404:
        return NotFoundFailure(
          message: serverMessage ?? 'Resource not found',
          statusCode: statusCode,
        );
      case 408:
        return TimeoutFailure(
          message: serverMessage ?? 'Request timeout',
          statusCode: statusCode,
        );
      case 409:
        return BadRequestFailure(
          message: serverMessage ?? 'Conflict',
          statusCode: statusCode,
        );
      case 422:
        return ValidationFailure(
          message: serverMessage ?? 'Validation failed',
          statusCode: statusCode,
        );
      case 429:
        return ServerFailure(
          message: serverMessage ?? 'Too many requests',
          statusCode: statusCode,
        );
      case 500:
      case 502:
      case 503:
      case 504:
        return ServerFailure(
          message: serverMessage ?? 'Internal server error',
          statusCode: statusCode,
        );
      default:
        return UnknownFailure(
          message: serverMessage ?? 'An unknown error occurred',
          statusCode: statusCode,
        );
    }
  }
}
