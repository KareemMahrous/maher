import 'package:dartz/dartz.dart';

import '../../../../core/network/error_handler.dart';
import '../../../../core/network/failures.dart';
import '../../example.dart';

class ExampleRepositoryImpl implements ExampleRepository {
  ExampleRepositoryImpl({required ExampleRemoteDataSource remoteDataSource})
    : _remoteDataSource = remoteDataSource;

  final ExampleRemoteDataSource _remoteDataSource;

  @override
  Future<Either<Failure, ExampleEntity>> fetchExamples() async {
    try {
      final response = await _remoteDataSource.fetchExamples();
      final data = response.data;

      if (!response.success || data == null) {
        return Left(ServerFailure(message: response.message));
      }

      return Right(ExampleModel.fromJson(data as Map<String, dynamic>));
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, ExampleEntity>> deleteExample({
    required int id,
  }) async {
    try {
      final response = await _remoteDataSource.deleteExample(id: id);
      final data = response.data;

      if (!response.success || data == null) {
        return Left(ServerFailure(message: response.message));
      }

      return Right(ExampleModel.fromJson(data as Map<String, dynamic>));
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, ExampleEntity>> updateExample({
    required ExampleParamsEntity input,
  }) async {
    try {
      final response = await _remoteDataSource.updateExample(input: input);
      final data = response.data;

      if (!response.success || data == null) {
        return Left(ServerFailure(message: response.message));
      }

      return Right(ExampleModel.fromJson(data as Map<String, dynamic>));
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, ExampleEntity>> createExample({
    required ExampleParamsEntity input,
  }) async {
    try {
      final response = await _remoteDataSource.createExample(input: input);
      final data = response.data;

      if (!response.success || data == null) {
        return Left(ServerFailure(message: response.message));
      }

      return Right(ExampleModel.fromJson(data as Map<String, dynamic>));
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, ExampleEntity>> fetchExampleDetails({
    required int id,
  }) async {
    try {
      final response = await _remoteDataSource.fetchExampleDetails(id: id);
      final data = response.data;

      if (!response.success || data == null) {
        return Left(ServerFailure(message: response.message));
      }

      return Right(ExampleModel.fromJson(data as Map<String, dynamic>));
    } catch (e) {
      return Left(ErrorHandler.handle(e));
    }
  }
}
