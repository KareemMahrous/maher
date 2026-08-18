import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../../domain/domain.dart';

class FetchExamplesUseCase extends UseCase<ExampleEntity, NoParams> {
  FetchExamplesUseCase({required ExampleRepository repository})
    : _repository = repository;

  final ExampleRepository _repository;

  @override
  Future<Either<Failure, ExampleEntity>> call(NoParams params) {
    return _repository.fetchExamples();
  }
}
