import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../../domain/domain.dart';

class FetchExamplesUseCase extends UseCase<ExampleEntity, NoParams> {
  final ExampleRepository _repository;

  FetchExamplesUseCase({required this._repository});

  @override
  Future<Either<Failure, ExampleEntity>> call(NoParams params) async {
    return await _repository.fetchExamples();
  }
}
