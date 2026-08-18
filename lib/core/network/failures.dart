import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  final int? statusCode;
  final List properties;

  const Failure({
    this.message = '',
    this.statusCode,
    this.properties = const [],
  });

  @override
  List<Object?> get props => [message, statusCode, properties];
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure({String? message, super.statusCode}) : super(message: message ?? 'Unauthorized access');
}

class NotFoundFailure extends Failure {
  const NotFoundFailure({String? message, super.statusCode}) : super(message: message ?? 'Resource not found');
}

class BadRequestFailure extends Failure {
  const BadRequestFailure({String? message, super.statusCode}) : super(message: message ?? 'Bad request');
}

class ForbiddenFailure extends Failure {
  const ForbiddenFailure({String? message, super.statusCode}) : super(message: message ?? 'Access forbidden');
}

class ValidationFailure extends Failure {
  const ValidationFailure({String? message, super.statusCode}) : super(message: message ?? 'Validation failed');
}

class ServerFailure extends Failure {
  const ServerFailure({String? message, super.statusCode}) : super(message: message ?? 'Internal server error');
}

class NetworkFailure extends Failure {
  const NetworkFailure({String? message, super.statusCode}) : super(message: message ?? 'No internet connection');
}

class TimeoutFailure extends Failure {
  const TimeoutFailure({String? message, super.statusCode}) : super(message: message ?? 'Connection timed out');
}

class UnknownFailure extends Failure {
  const UnknownFailure({String? message, super.statusCode}) : super(message: message ?? 'An unknown error occurred');
}

class CacheFailure extends Failure {
  const CacheFailure({String? message, super.statusCode}) : super(message: message ?? 'Cache failure');
}
