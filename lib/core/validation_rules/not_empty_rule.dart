import 'package:formz/formz.dart';

import 'standard_validation_rule.dart';

class NotEmptyField extends FormzInput<String, StandardValidationError> {
  const NotEmptyField.pure([super.value = '']) : super.pure();

  const NotEmptyField.dirty(String? value) : super.dirty(value ?? "");

  @override
  StandardValidationError? validator(String? value) {
    return value != null && value.isNotEmpty
        ? null
        : StandardValidationError.invalid;
  }
}


class NotEmptyListField<T> extends FormzInput<List<T>, StandardValidationError> {
  const NotEmptyListField.pure([super.value = const []]) : super.pure();

  const NotEmptyListField.dirty(List<T>? value) : super.dirty(value ?? const []);

  @override
  StandardValidationError? validator(List<T>? value) {
    if(value == null || value.isEmpty) {
      return StandardValidationError.invalid;
    }
    return null;
  }
}




class NotEmptyIntField extends FormzInput<int, StandardValidationError> {
  const NotEmptyIntField.pure([super.value = -1]) : super.pure();

  const NotEmptyIntField.dirty(int? value) : super.dirty(value ?? -1);

  @override
  StandardValidationError? validator(int? value) {
    return value != null && value != -1
        ? null
        : StandardValidationError.invalid;
  }
}


