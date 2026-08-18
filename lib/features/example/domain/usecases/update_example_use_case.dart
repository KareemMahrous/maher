import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../../domain/domain.dart';

class UpdateExampleUseCase extends UseCase<ExampleEntity, ExampleParamsEntity> {
  final ExampleRepository _repository;

  UpdateExampleUseCase({required this._repository});

  @override
  Future<Either<Failure, ExampleEntity>> call(ExampleParamsEntity params) async {
    return await _repository.updateExample(input:params);
  }
}
