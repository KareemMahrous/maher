import 'package:formz/formz.dart';

import 'standard_validation_rule.dart';

class AtLeast10DigitsField extends FormzInput<String, StandardValidationError> {
  const AtLeast10DigitsField.pure([super.value = '']) : super.pure();

  const AtLeast10DigitsField.dirty(String? value) : super.dirty(value ?? "");

  @override
  StandardValidationError? validator(String? value) {
    if (value == null) {
      return StandardValidationError.invalid;
    } else {
      return value.length == 10 ? null : StandardValidationError.invalid;
    }
  }
}
