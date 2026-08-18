import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../network/failures.dart';

abstract class UseCase<Input, Params> {
  Future<Either<Failure, Input>> call(Params params);
}

class NoParams extends Equatable {
  const NoParams._();

  @override
  List<Object?> get props => [];
}
