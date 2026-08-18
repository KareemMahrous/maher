import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import 'standard_validation_rule.dart';

class IsEqualParams extends Equatable {
  final String value1;

  final String value2;

  const IsEqualParams({required this.value1, required this.value2});

  @override
  List<Object?> get props => [value1, value2];
}

class EqualField extends FormzInput<IsEqualParams, StandardValidationError> {
  const EqualField.pure([
    super.isEqualParams = const IsEqualParams(value1: '', value2: ''),
  ]) : super.pure();

  const EqualField.dirty(super.isEqualParams) : super.dirty();

  /// it is accept a class of type [IsEqualParams]
  ///
  /// it contains [value1] and [value2] to validate if there are equal
  @override
  StandardValidationError? validator(IsEqualParams params) {
    return (params.value1 == params.value2) && params.value1.isNotEmpty
        ? null
        : StandardValidationError.invalid;
  }
}
