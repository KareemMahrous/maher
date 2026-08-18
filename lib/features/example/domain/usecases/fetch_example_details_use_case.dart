import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../../domain/domain.dart';

class FetchExampleDetailsUseCase extends UseCase<ExampleEntity, int> {
  FetchExampleDetailsUseCase({required ExampleRepository repository})
    : _repository = repository;

  final ExampleRepository _repository;

  @override
  Future<Either<Failure, ExampleEntity>> call(int params) {
    return _repository.fetchExampleDetails(id: params);
  }
}
