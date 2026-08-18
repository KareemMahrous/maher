import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../../domain/domain.dart';

class CreateExampleUseCase extends UseCase<ExampleEntity, ExampleParamsEntity> {
  CreateExampleUseCase({required ExampleRepository repository})
    : _repository = repository;

  final ExampleRepository _repository;

  @override
  Future<Either<Failure, ExampleEntity>> call(ExampleParamsEntity params) {
    return _repository.createExample(input: params);
  }
}
