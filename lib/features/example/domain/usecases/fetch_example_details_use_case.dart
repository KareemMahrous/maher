import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../../domain/domain.dart';

class FetchExampleDetailsUseCase extends UseCase<ExampleEntity, int> {
  final ExampleRepository _repository;

  FetchExampleDetailsUseCase({required this._repository});

  @override
  Future<Either<Failure, ExampleEntity>> call(int params) async {
    return await _repository.fetchExampleDetails(id: params);
  }
}
