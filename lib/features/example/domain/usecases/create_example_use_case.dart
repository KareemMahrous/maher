import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../../domain/domain.dart';

class CreateExampleUseCase extends UseCase<ExampleEntity, ExampleParamsEntity> {
  final ExampleRepository _repository;

  CreateExampleUseCase({required this._repository});

  @override
  Future<Either<Failure, ExampleEntity>> call(ExampleParamsEntity params) async {
    return await _repository.createExample(input:params);
  }
}
