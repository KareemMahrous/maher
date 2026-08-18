import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../../domain/domain.dart';

class DeleteExampleUseCase extends UseCase<ExampleEntity, int> {
  final ExampleRepository _repository;

  DeleteExampleUseCase({required this._repository});

  @override
  Future<Either<Failure, ExampleEntity>> call(int params) async {
    return await _repository.deleteExample(id: params);
  }
}
