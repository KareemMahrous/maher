import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import 'standard_validation_rule.dart';

class IsStrongParams extends Equatable {
  final String value;

  const IsStrongParams({required this.value});

  @override
  List<Object?> get props => [value];
}

class IsStrongField
    extends FormzInput<IsStrongParams, StandardValidationError> {
  const IsStrongField.pure([
    super.isStrongParams = const IsStrongParams(value: ''),
  ]) : super.pure();

  const IsStrongField.dirty(super.isStrongParams) : super.dirty();

  /// it is accept a class of type [IsStrongParams]
  ///
  /// it contains [value] to validate if there are equal
  @override
  StandardValidationError? validator(IsStrongParams params) {
    final RegExp regex = RegExp(r'^(?=.*[A-Z])(?=.*[^a-zA-Z0-9]).{8}$');

    return (regex.hasMatch(params.value)) && params.value.isNotEmpty
        ? null
        : StandardValidationError.invalid;
  }
}
