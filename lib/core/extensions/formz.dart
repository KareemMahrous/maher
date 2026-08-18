import 'package:formz/formz.dart';

extension Formz on FormzInput{
  bool get shouldShowError{
    return !isPure && isNotValid;
  }
}