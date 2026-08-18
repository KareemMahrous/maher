import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../entities/entities.dart';

abstract class ExampleRepository {
  Future<Either<Failure, ExampleEntity>> fetchExamples();
  Future<Either<Failure, ExampleEntity>> fetchExampleDetails({required int id});
  Future<Either<Failure, ExampleEntity>> createExample({required ExampleParamsEntity input});
  Future<Either<Failure, ExampleEntity>> updateExample({required ExampleParamsEntity input});
  Future<Either<Failure, ExampleEntity>> deleteExample({required int id});
}
