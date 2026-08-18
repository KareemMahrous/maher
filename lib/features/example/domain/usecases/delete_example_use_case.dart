import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../../domain/domain.dart';

class DeleteExampleUseCase extends UseCase<ExampleEntity, int> {
  DeleteExampleUseCase({required ExampleRepository repository})
    : _repository = repository;

  final ExampleRepository _repository;

  @override
  Future<Either<Failure, ExampleEntity>> call(int params) {
    return _repository.deleteExample(id: params);
  }
}
